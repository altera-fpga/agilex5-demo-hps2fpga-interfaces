/*
 * SPDX-FileCopyrightText: Copyright (C) 2025 Intel Corporation
 * SPDX-FileCopyrightText: Copyright (C) 2026 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <sys/mman.h>
#include <termios.h>
#include <poll.h>
#include <signal.h>
#include <sys/stat.h>
#include <limits.h>
#include <linux/vfio.h>
#include <linux/iommufd.h>
#include <sys/eventfd.h>
#include <sys/ioctl.h>
#include <errno.h>
#include "uio_helpers.h"
#include "standalone_common.h"

#define BUFFER_SIZE (F2H_OCRAM_32K_SPAN * 2)
#define IOVA_BASE   0x82000000ULL	// Fixed IOVA for DMA descriptors
#define DEVICE_NAME "20000000.f2h-bridge"

struct f2h_bridge_s {
	uint32_t gp_sig_value;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint32_t error;
	uint64_t buffer_compare_time1;
	uint64_t buffer_compare_time2;
	uint64_t dcache_flush_time;
	uint64_t h2f_dma_time;
	uint64_t f2h_dma_time;
};

void do_the_interesting_thing(struct f2h_bridge_s *, struct uio_map_s *,
							void *);

// Write to sysfs file
static int sysfs_write(const char *path, const char *value) {
	int fd = open(path, O_WRONLY);
	if (fd < 0) return -1;
	ssize_t ret = write(fd, value, strlen(value));
	close(fd);
	return (ret > 0) ? 0 : -1;
}

// Read symlink target
static char *read_symlink(const char *path) {
	char *target = malloc(PATH_MAX);
	if (!target) return NULL;
	ssize_t len = readlink(path, target, PATH_MAX - 1);
	if (len < 0) {
		free(target);
		return NULL;
	}
	target[len] = '\0';
	return target;
}

// Detect if bound to vfio-platform
static int is_bound_to_vfio(const char *dev_name) {
	char path[256];
	snprintf(path, sizeof(path),
			"/sys/bus/platform/devices/%s/driver", dev_name);
	char *driver = read_symlink(path);
	if (!driver) return 0;
	int bound = (strstr(driver, "vfio-platform") != NULL);
	free(driver);
	return bound;
}

// Bind to vfio-platform
static int bind_to_vfio(const char *dev_name) {
	char path[256];

	// Set driver_override
	snprintf(path, sizeof(path),
		"/sys/bus/platform/devices/%s/driver_override", dev_name);
	if (sysfs_write(path, "vfio-platform") < 0) {
		perror("driver_override");
		return -1;
	}

	// Bind
	snprintf(path, sizeof(path),
		"/sys/bus/platform/drivers/vfio-platform/bind");
	if (sysfs_write(path, dev_name) < 0) {
		perror("bind");
		return -1;
	}

	return 0;
}

// Detect vfio0 association
static int is_vfio0_associated(const char *dev_name) {
	char path[256];
	snprintf(path, sizeof(path),
				"/sys/class/vfio-dev/vfio0/device");
	char *device = read_symlink(path);
	if (!device) return 0;
	int associated = (strstr(device, dev_name) != NULL);
	free(device);
	return associated;
}

void sigbus_handler(int sig) {
	const char *msg = "\n\nERROR: SIGBUS (Bus Error) detected...\n\n";

	if (sig != SIGBUS) {
		return;
	}

	write(STDERR_FILENO, msg, strlen(msg));
	_exit(1);
}

int main(void)
{
	char c;
	int i;
	int result;
	int the_fd;
	char *next_app_name;
	ssize_t next_app_name_len;
	uint64_t cntfrq_el0;
	struct f2h_bridge_s f2h_bridge = {0};
	struct uio_map_s hps_gp_uio_map;
	struct termios orig_attr;
	struct termios new_attr;
	struct sigaction sa;

	/* register a SIGBUS signal handler */
	memset(&sa, 0, sizeof(sa));
	sa.sa_handler = sigbus_handler;
	sigemptyset(&sa.sa_mask);
	sa.sa_flags = 0;

	if (sigaction(SIGBUS, &sa, NULL) == -1) {
		return 1;
	}

	/* set NEXTPROG file to run boot_app upon our exit */
	the_fd = open("/NEXTPROG", O_WRONLY | O_TRUNC | O_CREAT,
		S_IRWXU | S_IRUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
	if(the_fd < 0) {
		puts("ERROR: opening NEXTPROG file");
		return 1;
	}
	next_app_name = "boot_app";
	next_app_name_len = strnlen(next_app_name, 32);
	result = write(the_fd, next_app_name, next_app_name_len);
	if((result < 0) || (result != next_app_name_len)) {
		puts("ERROR: writing NEXTPROG file");
		return 1;
	}
	result = close(the_fd);
	if(result < 0) {
		puts("ERROR: closing NEXTPROG file");
		return 1;
	}

	/* configure struct for hps-gp-uio device */
	hps_gp_uio_map.uio_name = "hps-gp-uio";
	hps_gp_uio_map.uio_length = getpagesize();
	hps_gp_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	hps_gp_uio_map.uio_flags = MAP_SHARED;
	hps_gp_uio_map.uio_offset = 0;

	/* find the hps-gp-uio device */
	result = find_uio_index(&hps_gp_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the hps-gp-uio device */
	result = mmap_uio(&hps_gp_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* map the DMA buffers with vfio, iommufd and user space alloc buffer */

	/* bind the vfio driver to our peripheral if not already bound */
	if (getuid() != 0) {
		fprintf(stderr, "Must run as root\n");
		return 1;
	}

	if (is_bound_to_vfio(DEVICE_NAME)) {
		printf("Already bound to vfio-platform; skipping\n");
	} else {
		if (bind_to_vfio(DEVICE_NAME) < 0) {
			fprintf(stderr, "Binding failed\n");
			return 1;
		}
		printf("Bound to vfio-platform\n");
	}

	if (!is_vfio0_associated(DEVICE_NAME)) {
		fprintf(stderr, "Misalignment: not associated with vfio0\n");
		return 1;
	}
	printf("Associated with /dev/vfio/devices/vfio0\n");

	int dev_fd, iommufd_fd, irq_efd = -1;
	struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
				.index = 0 };	// IRQ set index 0 from DT
	void *regs = NULL;		// Mapped device registers
	void *buffer = NULL;		// Userspace DMA buffer VA
	__u64 allocated_iova = 0;	// Returned IOVA for DMA descriptors

	// Construct VFIO cdev path (hardcoded for single device
	char device_path[64];
	snprintf(device_path, sizeof(device_path),
					"/dev/vfio/devices/%s", "vfio0");

	// Open VFIO device for control and mapping
	dev_fd = open(device_path, O_RDWR);
	if (dev_fd < 0) { perror("open device cdev"); return 1; }

	// Open iommufd for IOMMU management (IOVA mapping)
	iommufd_fd = open("/dev/iommu", O_RDWR);
	if (iommufd_fd < 0) { perror("open /dev/iommu"); return 1; }

	/*
	 * binding the VFIO device to the iommufd is going to generate printk
	 * output from the driver, so we delay here to ensure all previous
	 * output from this application has had time to print to the console
	 */
	fflush(stdout);
	usleep(20000);

	// Bind VFIO device to iommufd (enables userspace IOMMU ops;
	//				sets access_granted for further ioctls)
	struct vfio_device_bind_iommufd bind = {
		.argsz = sizeof(bind),
		.flags = 0,
		.iommufd = iommufd_fd
	};
	if (ioctl(dev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind) < 0) {
		perror("VFIO_DEVICE_BIND_IOMMUFD");
		return 1;
	}

	/*
	 * now we delay for a couple lines of console output time to allow the
	 * printk output to print to the console
	 */
	usleep(20000);

	// Query device capabilities (flags, num regions/IRQs from DT)
	struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
	if (ioctl(dev_fd, VFIO_DEVICE_GET_INFO, &dev_info) < 0) {
		perror("VFIO_DEVICE_GET_INFO");
		return 1;
	}
	if (dev_info.num_regions == 0) {
		puts("No mappable regions available");
		return 1;
	}

	// Query MMIO region 0 info (single reg from DT; size 0x10000)
	struct vfio_region_info reg_info = { .argsz = sizeof(reg_info),
								.index = 0 };
	if (ioctl(dev_fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info) < 0) {
		perror("VFIO_DEVICE_GET_REGION_INFO");
		return 1;
	}

	// Map registers if supported (non-cacheable Device memory)
	if (reg_info.flags & VFIO_REGION_INFO_FLAG_MMAP) {
		regs = mmap(NULL, reg_info.size,
				PROT_READ | PROT_WRITE, MAP_SHARED,
				dev_fd, reg_info.offset);
		if (regs == MAP_FAILED) {
			perror("mmap regs");
			return 1;
		}
	} else {
		puts("Region not mappable");
		return 1;
	}

	// Allocate I/O Address Space (IOAS) for IOVA mappings
	struct iommu_ioas_alloc alloc = {
		.size = sizeof(alloc),
		.flags = 0
	};
	if (ioctl(iommufd_fd, IOMMU_IOAS_ALLOC, &alloc) < 0) {
		perror("IOMMU_IOAS_ALLOC");
		return 1;
	}
	__u32 ioas_id = alloc.out_ioas_id;

	// Attach device to IOAS (enables coherent DMA translations via IOMMU)
	struct vfio_device_attach_iommufd_pt attach = {
		.argsz = sizeof(attach),
		.flags = 0,
		.pt_id = ioas_id
	};
	if (ioctl(dev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach) < 0) {
		perror("VFIO_DEVICE_ATTACH_IOMMUFD_PT");
		return 1;
	}

	// Optional: Query allowed IOVA ranges (first step to get num_iovas;
	//				second step commented as it may fail)
	struct iommu_ioas_iova_ranges range_query = {
					.size = sizeof(range_query),
					.ioas_id = ioas_id, .num_iovas = 0 };
	if (ioctl(iommufd_fd, IOMMU_IOAS_IOVA_RANGES, &range_query) < 0) {
		if (errno == EMSGSIZE) {
			__u32 num_ranges = range_query.num_iovas;
			printf("num_ranges = %u\n", num_ranges);
			// Second call with allocated buffer can be added here
			// if needed for debugging
		} else {
			perror("IOMMU_IOAS_IOVA_RANGES initial");
			return 1;
		}
	}

	// Allocate anonymous buffer (page-aligned, cacheable for coherent DMA)
	buffer = aligned_alloc(getpagesize(), BUFFER_SIZE);
	if (!buffer) { perror("aligned_alloc buffer"); return 1; }

	// Map buffer VA to fixed IOVA (pins pages, sets up IOMMU tables;
	//				use returned iova in descriptors)
	struct iommu_ioas_map map_data = {
		.size = sizeof(map_data),
		.flags = IOMMU_IOAS_MAP_READABLE | IOMMU_IOAS_MAP_WRITEABLE |
						IOMMU_IOAS_MAP_FIXED_IOVA,
		.ioas_id = ioas_id,
		.user_va = (__u64)buffer,
		.length = BUFFER_SIZE,
		.iova = IOVA_BASE
	};
	if (ioctl(iommufd_fd, IOMMU_IOAS_MAP, &map_data) < 0) {
		perror("IOMMU_IOAS_MAP");
		return 1;
	}
	allocated_iova = map_data.iova;  // Should match IOVA_BASE
	if(allocated_iova != IOVA_BASE) {
		puts("allocated_iova not equal to IOVA_BASE");
		return 1;
	}

	// Query IRQ info
	// (confirms eventfd support and automasked for level-triggered)
	if (ioctl(dev_fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0) {
		perror("VFIO_DEVICE_GET_IRQ_INFO");
		return 1;
	}
	if (irq_info.flags & VFIO_IRQ_INFO_AUTOMASKED) {
		printf("IRQ is automasked (level-triggered); "
			"unmask required after handling\n");
	}

	// Configure IRQ to signal eventfd if supported
	if (irq_info.flags & VFIO_IRQ_INFO_EVENTFD) {
		irq_efd = eventfd(0, EFD_NONBLOCK);	// Non-blocking eventfd
							// for IRQ notifications
		struct vfio_irq_set *irq_set = malloc(sizeof(*irq_set) +
								sizeof(__s32));
		irq_set->argsz = sizeof(*irq_set) + sizeof(__s32);
		irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
						VFIO_IRQ_SET_ACTION_TRIGGER;
		irq_set->index = 0;
		irq_set->start = 0;
		irq_set->count = 1;
		*(__s32 *)(irq_set->data) = irq_efd;
		if (ioctl(dev_fd, VFIO_DEVICE_SET_IRQS, irq_set) < 0) {
			perror("VFIO_DEVICE_SET_IRQS");
			return 1;
		}
		free(irq_set);
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&f2h_bridge, &hps_gp_uio_map,
				regs);

	/* print the results */
	puts("");
	printf ("F2H Demo - VFIO write streaming test\n");
	puts("");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
				f2h_bridge.gp_sig_value,
				(f2h_bridge.gp_sig_value >>  0) & 0xFF,
				(f2h_bridge.gp_sig_value >>  8) & 0xFF,
				(f2h_bridge.gp_sig_value >> 16) & 0xFF,
				(f2h_bridge.gp_sig_value >> 24) & 0xFF);
	puts("");

	printf("SYSID_ID: 0x%08X\n", f2h_bridge.sysid_id);
	printf("SYSID_TS: 0x%08X\n", f2h_bridge.sysid_ts);
	puts("");

	switch(f2h_bridge.error) {
	case(0):
		puts("FPGA system validation successful...");
		puts("");
		break;
	case(1):
		puts("FPGA system validation error returned...");
		break;
	default:
		puts("Unknown error returned...");
	}

	/* perform the various writes through the LWH2F bridge */

	/* flush stdout and delay while data is written to console */
	fflush(stdout);
	usleep(35000);

	/* configure a base pointer to the FPGA RAM buffer */
	void *base_ptr = regs +
			((F2H_OCRAM_32K_BASE) &
			((F2H_OCRAM_32K_SPAN * 2) - 1));

	/*
	 * write the value of i to each successive byte
	 */
	puts("Writing value i to FPGA OCRAM...");
	fflush(stdout);
	usleep(7000);
	for(i = 0 ; i < F2H_OCRAM_32K_SPAN ; i++) {
		((uint8_t *)(base_ptr))[i] = i;
	}

	/*
	 * write the value ZERO to each successive byte with a dsb preceeding
	 */
	puts("Writing value ZERO with dsb to FPGA OCRAM...");
	fflush(stdout);
	usleep(7000);
	for(i = 0 ; i < F2H_OCRAM_32K_SPAN ; i++) {
		asm volatile ("dsb sy\n");
		((uint8_t *)(base_ptr))[i] = 0x00;
	}

	/*
	 * write the value ZERO to each successive byte
	 */
	puts("Writing value ZERO to FPGA OCRAM as bytes...");
	fflush(stdout);
	usleep(7000);
	for(i = 0 ; i < F2H_OCRAM_32K_SPAN ; i++) {
		((volatile uint8_t *)(base_ptr))[i] = 0x00;
	}

	/*
	 * write the value ZERO to each successive 128-bit word
	 */
	puts("Writing value ZERO to FPGA OCRAM as 128-bit words...");
	fflush(stdout);
	usleep(7000);
	void *temp_ptr = base_ptr;
	for(i = 0 ; i < (F2H_OCRAM_32K_SPAN / 16) ; i++) {
		__asm__ volatile (
			"stp xzr, xzr, [%[dest]], #16"
			: [dest] "+r" (temp_ptr)
			:
			: "memory"
		);
	}

	/*
	 * write the value ZERO to each successive 256-bit word
	 */
	puts("Writing value ZERO to FPGA OCRAM as 256-bit words...");
	fflush(stdout);
	usleep(7000);
	temp_ptr = base_ptr;
	__asm__ volatile ("movi v0.16b, #0");
	for(i = 0 ; i < (F2H_OCRAM_32K_SPAN / 32) ; i++) {
		__asm__ volatile (
			"stp q0, q0, [%[dest]], #32"
			: [dest] "+r" (temp_ptr)
			:
			: "memory"
		);
	}

	/*
	 * write the value ZERO to each successive 512-bit word
	 */
	puts("Writing value ZERO to FPGA OCRAM as 512-bit words...");

	// Query the DCZID_EL0 register to get the block size
	uint64_t dczid;
	__asm__ volatile ("mrs %0, dczid_el0" : "=r" (dczid));

	// Check if DC ZVA is prohibited (bit 4)
	if (dczid & 0x10) {
		puts("ERROR: DC ZVA is prohibited...");
		goto common_exit;
	}

	// Calculate block size in bytes: 4 * 2^(bits 0:3)
	size_t block_size = 4 << (dczid & 0xf);

	printf("DC ZVA is allowed and block size is %ld bytes.\n", block_size);

	fflush(stdout);
	usleep(7000);
	temp_ptr = base_ptr;
	for(i = 0 ; i < (int)(F2H_OCRAM_32K_SPAN / block_size) ; i++) {
		__asm__ volatile (
			"dc zva, %[dest]"
			:
			: [dest] "r" (temp_ptr)
			: "memory"
		);
		temp_ptr += block_size;
	}

	/*
	 * memset the value ZERO to each successive byte
	 */
	puts("memset() value ZERO to FPGA OCRAM...");
	fflush(stdout);
	usleep(7000);
	memset(((void *)(base_ptr)), 0, F2H_OCRAM_32K_SPAN);

	puts("All tests completed...");

common_exit:
	puts("");
	printf ("Press any key to exit this demo.");
	fflush(stdout);

	/* adjust termios so we see each character input and no echo */
	tcgetattr(STDIN_FILENO, &orig_attr);
	new_attr = orig_attr;
	new_attr.c_lflag &= ~(ICANON | ECHO);
	tcsetattr(STDIN_FILENO, TCSANOW, &new_attr);

	/* wait for console input */
	do {
		result = read(STDIN_FILENO, &c, 1);
	} while(result == 0);

	/* restore termios */
	tcsetattr(STDIN_FILENO, TCSANOW, &orig_attr);

	printf ("\n\n");
	return 0;
}

void do_the_interesting_thing(struct f2h_bridge_s *f2h_bridge,
				struct uio_map_s *map,
				void *regs) {

	uint32_t gp_in;
	uint32_t sysid_id;
	uint32_t sysid_ts;

	f2h_bridge->error = 1;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	f2h_bridge->gp_sig_value = gp_in;

	if(gp_in != F2H_SIG)
		return;

	/* validate the sysid signature */
	sysid_id = *((volatile uint32_t *)(regs +
		((F2H_SYSID_ID_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))));

	f2h_bridge->sysid_id = sysid_id;

	if(sysid_id != F2H_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(regs +
		((F2H_SYSID_TS_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))));
	f2h_bridge->sysid_ts = sysid_ts;

	f2h_bridge->error = 0;
}

