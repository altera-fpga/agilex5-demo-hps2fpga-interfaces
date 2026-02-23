/*
 * SPDX-FileCopyrightText: Copyright (C) 2025 Intel Corporation
 * SPDX-FileCopyrightText: Copyright (C) 2026 Altera Corporation
 * SPDX-License-Identifier: MIT-0
 */

/* SPDX-FileCopyrightText: Copyright (C) 2026 Altera Corporation */

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
							void *,
							void *);

void do_the_interesting_thing_irq(struct f2h_bridge_s *, struct uio_map_s *,
							void *,
							void *,
							int,
							int);

static void dcache_clean_invalidate(void *start, size_t size) {
	char *ptr = start;
	char *end = ptr + size;
	asm volatile(
		"1:\n"  // Local label 1 (forward reference)
		"dc civac, %0\n"
		"add %0, %0, #64\n"
		"cmp %0, %1\n"
		"b.lo 1b\n"
		"dsb sy\n"
		: "+r" (ptr)
		: "r" (end)
		: "memory"
	);
}

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

int main(void)
{
	char c;
	int result;
	int the_fd;
	char *next_app_name;
	ssize_t next_app_name_len;
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	uint64_t bytes_per_sec;
	uint64_t gb_per_sec;
	uint64_t gb_per_sec_frac;
	struct f2h_bridge_s f2h_bridge = {0};
	struct uio_map_s hps_gp_uio_map;
	struct termios orig_attr;
	struct termios new_attr;

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

	/* measure the cache system performance */

	volatile int keep;
	uint64_t start_time;
	uint64_t end_time;
	int i;
	volatile uint8_t *precharge_ptr;
	uint8_t temp_8;

	/* zero out the full buffer */
	memset(buffer, 0, BUFFER_SIZE);

	/* precharge the cache */
	precharge_ptr = buffer;
	for(i = 0 ; i < (BUFFER_SIZE) ; i += 64) {
		temp_8 = precharge_ptr[i];
		(void)temp_8;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* verify the first half of the buffer matches the second half */
	keep = memcmp(buffer, buffer + (BUFFER_SIZE / 2), (BUFFER_SIZE / 2));
	if(keep != 0) {
		puts("First buffer memcmp failed during cache measurement.");
		return 1;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	uint64_t full_cached_compare_time = end_time - start_time;

	/* flush the data cache */
	dcache_clean_invalidate(buffer, BUFFER_SIZE);

	/* precharge the first half of the cache */
	precharge_ptr = buffer;
	for(i = 0 ; i < (BUFFER_SIZE / 2) ; i += 64) {
		temp_8 = precharge_ptr[i];
		(void)temp_8;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* verify the first half of the buffer matches the second half */
	keep = memcmp(buffer, buffer + (BUFFER_SIZE / 2), (BUFFER_SIZE / 2));
	if(keep != 0) {
		puts("Second buffer memcmp failed during cache measurement.");
		return 1;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	uint64_t half_cached_compare_time = end_time - start_time;

	/* flush the data cache */
	dcache_clean_invalidate(buffer, BUFFER_SIZE);

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* verify the first half of the buffer matches the second half */
	keep = memcmp(buffer, buffer + (BUFFER_SIZE / 2), (BUFFER_SIZE / 2));
	if(keep != 0) {
		puts("Third buffer memcmp failed during cache measurement.");
		return 1;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	uint64_t no_cached_compare_time = end_time - start_time;

	/* polled version */
	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&f2h_bridge, &hps_gp_uio_map,
				regs, buffer);

	/* print the results */
	puts("");
	printf ("F2H Cache Stash Demo - VFIO with cache flush\n");
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

	puts("---------- Cache Measurements ----------");
	printf("  NO CACHED BUFFER COMPARE TIME: ");
	ns_time = (no_cached_compare_time * 1000000000)
							/ cntfrq_el0;
	ps_time = (no_cached_compare_time * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9ld.%03ldns\n", ns_time, ps_time);
	printf("HALF CACHED BUFFER COMPARE TIME: ");
	ns_time = (half_cached_compare_time * 1000000000)
							/ cntfrq_el0;
	ps_time = (half_cached_compare_time * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9ld.%03ldns\n", ns_time, ps_time);
	printf("FULL CACHED BUFFER COMPARE TIME: ");
	ns_time = (full_cached_compare_time * 1000000000)
							/ cntfrq_el0;
	ps_time = (full_cached_compare_time * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9ld.%03ldns\n", ns_time, ps_time);

	puts("");
	puts("---------- Polled Example ----------");
	puts("");

	puts("---------- Cached Buffers ----------");
	puts("");
	switch(f2h_bridge.error) {
	case(0):
		puts("No errors detected...");
		puts("");
		printf("      DCACHE FLUSH TIME: ");
		ns_time = (f2h_bridge.dcache_flush_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.dcache_flush_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns\n", ns_time, ps_time);

		printf("1ST BUFFER COMPARE TIME: ");
		ns_time = (f2h_bridge.buffer_compare_time1 * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.buffer_compare_time1 * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns\n", ns_time, ps_time);

		printf("2ND BUFFER COMPARE TIME: ");
		ns_time = (f2h_bridge.buffer_compare_time2 * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.buffer_compare_time2 * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns\n", ns_time, ps_time);

		printf("   HPS to FPGA DMA TIME: ");
		ns_time = (f2h_bridge.h2f_dma_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.h2f_dma_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns", ns_time, ps_time);
		bytes_per_sec = (F2H_OCRAM_32K_SPAN * 1000000000UL) / ns_time;
		gb_per_sec = bytes_per_sec / (1024 * 1024 * 1024);
		gb_per_sec_frac = bytes_per_sec % (1024 * 1024 * 1024);
		gb_per_sec_frac *= 1000;
		gb_per_sec_frac /= (1024 * 1024 * 1024);
		printf(" : %3ld.%03ldGB/s\n", gb_per_sec, gb_per_sec_frac);

		printf("   FPGA to HPS DMA TIME: ");
		ns_time = (f2h_bridge.f2h_dma_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.f2h_dma_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns", ns_time, ps_time);
		bytes_per_sec = (F2H_OCRAM_32K_SPAN * 1000000000UL) / ns_time;
		gb_per_sec = bytes_per_sec / (1024 * 1024 * 1024);
		gb_per_sec_frac = bytes_per_sec % (1024 * 1024 * 1024);
		gb_per_sec_frac *= 1000;
		gb_per_sec_frac /= (1024 * 1024 * 1024);
		printf(" : %3ld.%03ldGB/s\n", gb_per_sec, gb_per_sec_frac);
		break;
	case(1):
		puts("FPGA system validation error returned...");
		break;
	case(2):
		puts("HPS to FPGA DMA busy error returned...");
		break;
	case(3):
		puts("HPS to FPGA DMA timeout error returned...");
		break;
	case(4):
		puts("FPGA to HPS DMA busy error returned...");
		break;
	case(5):
		puts("FPGA to HPS DMA timeout error returned...");
		break;
	case(6):
		puts("Buffer validation error returned...\n");
		puts("Initial buffer does not match final buffer...");
		break;
	default:
		puts("Unknown error returned...");
	}

	/* interrupt version */
	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing_irq(&f2h_bridge, &hps_gp_uio_map,
				regs, buffer, irq_efd, dev_fd);

	puts("");
	puts("---------- Interrupt Example ----------");
	puts("");
	puts("---------- Cached Buffers ----------");
	puts("");
	switch(f2h_bridge.error) {
	case(0):
		puts("No errors detected...");
		puts("");
		printf("      DCACHE FLUSH TIME: ");
		ns_time = (f2h_bridge.dcache_flush_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.dcache_flush_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns\n", ns_time, ps_time);

		printf("1ST BUFFER COMPARE TIME: ");
		ns_time = (f2h_bridge.buffer_compare_time1 * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.buffer_compare_time1 * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns\n", ns_time, ps_time);

		printf("2ND BUFFER COMPARE TIME: ");
		ns_time = (f2h_bridge.buffer_compare_time2 * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.buffer_compare_time2 * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns\n", ns_time, ps_time);

		printf("   HPS to FPGA DMA TIME: ");
		ns_time = (f2h_bridge.h2f_dma_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.h2f_dma_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns", ns_time, ps_time);
		bytes_per_sec = (F2H_OCRAM_32K_SPAN * 1000000000UL) / ns_time;
		gb_per_sec = bytes_per_sec / (1024 * 1024 * 1024);
		gb_per_sec_frac = bytes_per_sec % (1024 * 1024 * 1024);
		gb_per_sec_frac *= 1000;
		gb_per_sec_frac /= (1024 * 1024 * 1024);
		printf(" : %3ld.%03ldGB/s\n", gb_per_sec, gb_per_sec_frac);

		printf("   FPGA to HPS DMA TIME: ");
		ns_time = (f2h_bridge.f2h_dma_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.f2h_dma_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns", ns_time, ps_time);
		bytes_per_sec = (F2H_OCRAM_32K_SPAN * 1000000000UL) / ns_time;
		gb_per_sec = bytes_per_sec / (1024 * 1024 * 1024);
		gb_per_sec_frac = bytes_per_sec % (1024 * 1024 * 1024);
		gb_per_sec_frac *= 1000;
		gb_per_sec_frac /= (1024 * 1024 * 1024);
		printf(" : %3ld.%03ldGB/s\n", gb_per_sec, gb_per_sec_frac);
		break;
	case(1):
		puts("FPGA system validation error returned...");
		break;
	case(2):
		puts("HPS to FPGA DMA busy error returned...");
		break;
	case(3):
		puts("HPS to FPGA DMA timeout error returned...");
		break;
	case(4):
		puts("FPGA to HPS DMA busy error returned...");
		break;
	case(5):
		puts("FPGA to HPS DMA timeout error returned...");
		break;
	case(6):
		puts("Buffer validation error returned...\n");
		puts("Initial buffer does not match final buffer...");
		break;
	default:
		puts("Unknown error returned...");
		printf("f2h_bridge.error = %u\n", f2h_bridge.error);
	}

	fflush(stdout);

	// Teardown VFIO config (reverse order)
	struct iommu_ioas_unmap unmap_data = {
		.size = sizeof(unmap_data),
		.ioas_id = ioas_id,
		.iova = allocated_iova,
		.length = BUFFER_SIZE
	};
	ioctl(iommufd_fd, IOMMU_IOAS_UNMAP, &unmap_data);	// Unmap IOVA
							// (unpins pages)
	free(buffer);			// Free anonymous buffer
	munmap(regs, reg_info.size);	// Unmap registers

	/*
	 * closing the VFIO device is going to generate printk output from the
	 * driver, so we delay here to ensure all previous output from this
	 * application has had time to print to the console
	 */
	fflush(stdout);
	usleep(125000);

	close(dev_fd);			// Close VFIO device

	/*
	 * now we delay for a couple lines of console output time to allow the
	 * printk output to print to the console
	 */
	usleep(20000);

	close(iommufd_fd);		// Close iommufd
	if (irq_efd >= 0) close(irq_efd);	// Close eventfd if created

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
				void *regs,
				void *buffer) {

	uint32_t i;
	uint32_t gp_in;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t timeout;
	uint64_t temp;
	uint32_t temp_32;
	uint8_t *dma_buffer_0 = (void*)(buffer);
	uint8_t *dma_buffer_1 = (void*)(buffer + F2H_OCRAM_32K_SPAN);
	uint64_t *dma_buffer_0_word_ptr = (uint64_t *)dma_buffer_0;
	uint32_t descriptor[8];
	uint64_t dma_wr_ptr;
	uint64_t dma_rd_ptr;

	f2h_bridge->error = 1;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	f2h_bridge->gp_sig_value = gp_in;

	if(gp_in != F2HS_SIG)
		return;

	/* validate the sysid signature */
	sysid_id = *((volatile uint32_t *)(regs +
		((F2H_SYSID_ID_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))));

	f2h_bridge->sysid_id = sysid_id;

	if(sysid_id != F2HS_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(regs +
		((F2H_SYSID_TS_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))));
	f2h_bridge->sysid_ts = sysid_ts;

	/*
	 * we will now DMA data from dma_buffer_0 to the FPGA OCRAM buffer
	 * and then DMA from the FPGA OCRAM buffer to dma_buffer_1
	 *
	 * the data cache WILL be flushed prior to triggering the dma so the
	 * coherent transactions WILL NOT hit the cache
	 */

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* precharge the cache */
	volatile uint8_t *precharge_ptr = dma_buffer_0;
	uint8_t temp_8;
	for(i = 0 ; i < (F2H_OCRAM_32K_SPAN * 2) ; i += 64) {
		temp_8 = precharge_ptr[i];
		(void)temp_8;
	}

	/* clear the three buffers that we'll use for DMA transfers */
	/* this isn't necessary but for demonstration purposes we'll do it */
	memset(dma_buffer_0, 0, F2H_OCRAM_32K_SPAN);
	memset(dma_buffer_1, 0, F2H_OCRAM_32K_SPAN);
	for(i = 0 ; i < F2H_OCRAM_32K_SPAN / 2 ; i++) {
		asm volatile ("dsb sy\n");
		((uint8_t *)(regs +
			((F2H_OCRAM_32K_BASE) &
			((F2H_OCRAM_32K_SPAN * 2) - 1))))[i] =
			0x00;
	}

	/* fill the initial buffer with a randomized data pattern */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	temp ^= 0xFbFdF1F3F5F7FbFd;
	temp += 0x0b0d010305070b0d;
	for(i = 0 ; i < (F2H_OCRAM_32K_SPAN / sizeof(uint64_t)) ; i++) {
		temp += 0x0b0d010305070b0d;
		dma_buffer_0_word_ptr[i] = temp++;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* flush the data cache */
	dcache_clean_invalidate(buffer, BUFFER_SIZE);

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	f2h_bridge->dcache_flush_time = end_time - start_time;

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(regs +
		((F2H_MSGDMA_CSR_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))))[0];
	if(temp_32 != 0x00000002) {
		f2h_bridge->error = 2;
		return;
	}

	/* build our descriptor for dma_buffer_0 to FPGA OCRAM */
	descriptor[0] = (uint64_t)(0x82000000) & 0xFFFFFFFF;
	descriptor[1] = MSGDMA_OCRAM_32K_BASE & 0xFFFFFFFF;
	descriptor[2] = F2H_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = (uint64_t)(0x00000000) >> 32;
	descriptor[6] = MSGDMA_OCRAM_32K_BASE >> 32;
	descriptor[7] = 0x80000000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 8 ; i++) {
		((volatile uint32_t *)(regs +
		((F2H_MSGDMA_DES_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))))[i] = descriptor[i];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = ((volatile uint32_t *)(
			regs +
			((F2H_MSGDMA_CSR_BASE) &
			((F2H_OCRAM_32K_SPAN * 2) - 1))))[0];
	while((temp_32 & 0x00000001) == 0x00000001) {
		asm volatile (
			"dsb sy\n"
			"isb\n"
			"mrs %[temp], cntvct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			f2h_bridge->error = 3;
			return;
		}
		temp_32 = ((volatile uint32_t *)(
			regs +
			((F2H_MSGDMA_CSR_BASE) &
			((F2H_OCRAM_32K_SPAN * 2) - 1))))[0];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	f2h_bridge->h2f_dma_time = end_time - start_time;

	/* initialize intermediate DMA pointers for F2H transfer */
	dma_rd_ptr = MSGDMA_OCRAM_32K_BASE;
	dma_wr_ptr = (uint64_t)(0x82000000 + F2H_OCRAM_32K_SPAN);

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(
			regs +
			((F2H_MSGDMA_CSR_BASE) &
			((F2H_OCRAM_32K_SPAN * 2) - 1))))[0];
	if(temp_32 != 0x00000002) {
		f2h_bridge->error = 4;
		return;
	}

	/* build our descriptor for FPGA OCRAM to dma_buffer_0 */
	uint64_t local_count = 0;
	uint32_t prepped_desc[(F2H_OCRAM_32K_SPAN / 128) * 8];
	uint32_t prepped_desc_cnt = 0;
	while(local_count < F2H_OCRAM_32K_SPAN) {
		descriptor[0] = (dma_rd_ptr + local_count) & 0xFFFFFFFF;
		descriptor[1] = (dma_wr_ptr + local_count) & 0xFFFFFFFF;
		descriptor[2] = 128;
		descriptor[3] = 0x00000000;
		descriptor[4] = 0x00000000;
		descriptor[5] = dma_rd_ptr >> 32;
		descriptor[6] = dma_wr_ptr >> 32;
		descriptor[7] = 0x80000000;
		local_count += 128;

		/* save the descriptor into a temporary array */
		for(i = 0 ; i < 8 ; i++) {
			prepped_desc[(prepped_desc_cnt * 8) + i] =
								descriptor[i];
		}
	        prepped_desc_cnt++;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* push the descriptors into the MSGDMA */
	uint32_t *the_src = &prepped_desc[0];
	uint32_t *the_dst = (uint32_t *)(regs +
		((F2H_MSGDMA_DES_BASE) & ((F2H_OCRAM_32K_SPAN * 2) - 1)));
	for(i = 0 ; i < prepped_desc_cnt ; i++) {
		asm volatile (
			"ldp q0, q1, [%[src_ptr]], #32 \n"
			"stp q0, q1, [%[dst_ptr]] \n"
			: [src_ptr] "+r" (the_src)
			: [dst_ptr] "r" (the_dst)
			: "q0", "q1", "memory"
		);
	}

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = ((volatile uint32_t *)(
			regs +
			((F2H_MSGDMA_CSR_BASE) &
			((F2H_OCRAM_32K_SPAN * 2) - 1))))[0];
	while((temp_32 & 0x00000001) == 0x00000001) {
		asm volatile (
			"dsb sy\n"
			"isb\n"
			"mrs %[temp], cntvct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			f2h_bridge->error = 5;
			return;
		}
		temp_32 =
		((volatile uint32_t *)(
			regs +
			((F2H_MSGDMA_CSR_BASE) &
			((F2H_OCRAM_32K_SPAN * 2) - 1))))[0];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	f2h_bridge->f2h_dma_time = end_time - start_time;

	/* dsb so that a76 waits for outstanding io before comparing buffers */
	asm volatile (
		"dsb sy\n"
	);

	volatile int keep;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* verify the initial buffer matches the final buffer */
	if((keep = memcmp(dma_buffer_0, dma_buffer_1, F2H_OCRAM_32K_SPAN))
									== 0) {
		f2h_bridge->error = 0;
	} else {
		f2h_bridge->error = 6;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	f2h_bridge->buffer_compare_time1 = end_time - start_time;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* verify the initial buffer matches the final buffer */
	if((keep = memcmp(dma_buffer_0, dma_buffer_1, F2H_OCRAM_32K_SPAN))
									== 0) {
		f2h_bridge->error = 0;
	} else {
		f2h_bridge->error = 6;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	f2h_bridge->buffer_compare_time2 = end_time - start_time;
}

void do_the_interesting_thing_irq(struct f2h_bridge_s *f2h_bridge,
				struct uio_map_s *map,
				void *regs,
				void *buffer,
				int irq_efd,
				int dev_fd) {

	uint32_t i;
	uint32_t gp_in;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t temp;
	uint32_t temp_32;
	uint8_t *dma_buffer_0 = (void*)(buffer);
	uint8_t *dma_buffer_1 = (void*)(buffer + F2H_OCRAM_32K_SPAN);
	uint64_t *dma_buffer_0_word_ptr = (uint64_t *)dma_buffer_0;
	uint32_t descriptor[8];
	uint64_t dma_wr_ptr;
	uint64_t dma_rd_ptr;
	struct pollfd fds;
	int result;

	f2h_bridge->error = 1;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	f2h_bridge->gp_sig_value = gp_in;

	if(gp_in != F2HS_SIG)
		return;

	/* validate the sysid signature */
	sysid_id = *((volatile uint32_t *)(regs +
		((F2H_SYSID_ID_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))));

	f2h_bridge->sysid_id = sysid_id;

	if(sysid_id != F2HS_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(regs +
		((F2H_SYSID_TS_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))));
	f2h_bridge->sysid_ts = sysid_ts;

	/*
	 * we will now DMA data from dma_buffer_0 to the FPGA OCRAM buffer
	 * and then DMA from the FPGA OCRAM buffer to dma_buffer_1
	 *
	 * the data cache WILL be flushed prior to triggering the dma so the
	 * coherent transactions WILL NOT hit the cache
	 */

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* precharge the cache */
	volatile uint8_t *precharge_ptr = dma_buffer_0;
	uint8_t temp_8;
	for(i = 0 ; i < (F2H_OCRAM_32K_SPAN * 2) ; i += 64) {
		temp_8 = precharge_ptr[i];
		(void)temp_8;
	}

	/* clear the three buffers that we'll use for DMA transfers */
	/* this isn't necessary but for demonstration purposes we'll do it */
	memset(dma_buffer_0, 0, F2H_OCRAM_32K_SPAN);
	memset(dma_buffer_1, 0, F2H_OCRAM_32K_SPAN);
	for(i = 0 ; i < F2H_OCRAM_32K_SPAN / 2 ; i++) {
		asm volatile ("dsb sy\n");
		((uint8_t *)(regs +
			((F2H_OCRAM_32K_BASE) &
			((F2H_OCRAM_32K_SPAN * 2) - 1))))[i] =
			0x00;
	}

	/* fill the initial buffer with a randomized data pattern */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	temp ^= 0xFbFdF1F3F5F7FbFd;
	temp += 0x0b0d010305070b0d;
	for(i = 0 ; i < (F2H_OCRAM_32K_SPAN / sizeof(uint64_t)) ; i++) {
		temp += 0x0b0d010305070b0d;
		dma_buffer_0_word_ptr[i] = temp++;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* flush the data cache */
	dcache_clean_invalidate(buffer, BUFFER_SIZE);

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	f2h_bridge->dcache_flush_time = end_time - start_time;

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(regs +
		((F2H_MSGDMA_CSR_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))))[0];
	if(temp_32 != 0x00000002) {
		f2h_bridge->error = 2;
		return;
	}

	/* enable the MSGDMA global interrupt mask */
	((volatile uint32_t *)(regs +
		((F2H_MSGDMA_CSR_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))))[1] = 0x10;

	/* enable the uio interrupt */
	// Unmask struct (similar to set, but no data needed)
	struct vfio_irq_set unmask_set = {
		.argsz = sizeof(unmask_set),
		.flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
		.index = 0,
		.start = 0,
		.count = 1
	};

	// Unmask to re-enable for next interrupt
	if (ioctl(dev_fd, VFIO_DEVICE_SET_IRQS, &unmask_set) < 0) {
		perror("VFIO_DEVICE_SET_IRQS unmask");
		f2h_bridge->error = 3;
		return;
	}

	/* build our descriptor for dma_buffer_0 to FPGA OCRAM */
	descriptor[0] = (uint64_t)(0x82000000) & 0xFFFFFFFF;
	descriptor[1] = MSGDMA_OCRAM_32K_BASE & 0xFFFFFFFF;
	descriptor[2] = F2H_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = (uint64_t)(0x00000000) >> 32;
	descriptor[6] = MSGDMA_OCRAM_32K_BASE >> 32;
	descriptor[7] = 0x80004000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 8 ; i++) {
		((volatile uint32_t *)(regs +
		((F2H_MSGDMA_DES_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))))[i] = descriptor[i];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	fds.fd = irq_efd;
	fds.events = POLLIN;
	fds.revents = 0;
	result = poll(&fds, 1, 1);

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* check the poll response */
	if(result < 0) {
		f2h_bridge->error = 7;
		return;
	}
	else if(result == 0) {
		f2h_bridge->error = 8;
		return;
	}
	if((fds.revents & POLLIN) != POLLIN) {
		f2h_bridge->error = 9;
		return;
	}

	/* read the uio IRQ */
	result = read(irq_efd, &temp, 8);
	if(result != 8) {
		f2h_bridge->error = 10;
		return;
	}

	/* return the DMA time */
	f2h_bridge->h2f_dma_time = end_time - start_time;

	/* clear the MSGDMA interrupt */
	((volatile uint32_t *)(regs +
		((F2H_MSGDMA_CSR_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))))[0] = 0x200;

	/* disable the MSGDMA global interrupt mask */
	((volatile uint32_t *)(regs +
		((F2H_MSGDMA_CSR_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))))[1] = 0x00;

	/* initialize intermediate DMA pointers for F2H transfer */
	dma_rd_ptr = MSGDMA_OCRAM_32K_BASE;
	dma_wr_ptr = (uint64_t)(0x82000000 + F2H_OCRAM_32K_SPAN);

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(
			regs +
			((F2H_MSGDMA_CSR_BASE) &
			((F2H_OCRAM_32K_SPAN * 2) - 1))))[0];
	if(temp_32 != 0x00000002) {
		f2h_bridge->error = 4;
		return;
	}

	/* enable the MSGDMA global interrupt mask */
	((volatile uint32_t *)(regs +
		((F2H_MSGDMA_CSR_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))))[1] = 0x10;

	/* enable the uio interrupt */
	// Unmask to re-enable for next interrupt
	if (ioctl(dev_fd, VFIO_DEVICE_SET_IRQS, &unmask_set) < 0) {
		perror("VFIO_DEVICE_SET_IRQS unmask");
		f2h_bridge->error = 5;
		return;
	}

	/* build our descriptor for FPGA OCRAM to dma_buffer_0 */
	uint64_t local_count = 0;
	uint32_t prepped_desc[(F2H_OCRAM_32K_SPAN / 128) * 8];
	uint32_t prepped_desc_cnt = 0;
	while(local_count < F2H_OCRAM_32K_SPAN) {
		descriptor[0] = (dma_rd_ptr + local_count) & 0xFFFFFFFF;
		descriptor[1] = (dma_wr_ptr + local_count) & 0xFFFFFFFF;
		descriptor[2] = 128;
		descriptor[3] = 0x00000000;
		descriptor[4] = 0x00000000;
		descriptor[5] = dma_rd_ptr >> 32;
		descriptor[6] = dma_wr_ptr >> 32;
		descriptor[7] = 0x80000000;
		local_count += 128;

		/* save the descriptor into a temporary array */
		for(i = 0 ; i < 8 ; i++) {
			prepped_desc[(prepped_desc_cnt * 8) + i] =
								descriptor[i];
		}
	        prepped_desc_cnt++;
	}

	prepped_desc[((prepped_desc_cnt - 1) * 8) + 7] = 0x80004000;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* push the descriptors into the MSGDMA */
	uint32_t *the_src = &prepped_desc[0];
	uint32_t *the_dst = (uint32_t *)(regs +
		((F2H_MSGDMA_DES_BASE) & ((F2H_OCRAM_32K_SPAN * 2) - 1)));
	for(i = 0 ; i < prepped_desc_cnt ; i++) {
		asm volatile (
			"ldp q0, q1, [%[src_ptr]], #32 \n"
			"stp q0, q1, [%[dst_ptr]] \n"
			: [src_ptr] "+r" (the_src)
			: [dst_ptr] "r" (the_dst)
			: "q0", "q1", "memory"
		);
	}

	/* wait for the DMA to idle, timeout after 1ms */
	fds.fd = irq_efd;
	fds.events = POLLIN;
	fds.revents = 0;
	result = poll(&fds, 1, 1);

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* check the poll response */
	if(result < 0) {
		f2h_bridge->error = 11;
		return;
	}
	else if(result == 0) {
		f2h_bridge->error = 12;
		return;
	}
	if((fds.revents & POLLIN) != POLLIN) {
		f2h_bridge->error = 13;
		return;
	}

	/* read the uio IRQ */
	result = read(irq_efd, &temp, 8);
	if(result != 8) {
		f2h_bridge->error = 14;
		return;
	}

	/* return the DMA time */
	f2h_bridge->f2h_dma_time = end_time - start_time;

	/* clear the MSGDMA interrupt */
	((volatile uint32_t *)(regs +
		((F2H_MSGDMA_CSR_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))))[0] = 0x200;

	/* disable the MSGDMA global interrupt mask */
	((volatile uint32_t *)(regs +
		((F2H_MSGDMA_CSR_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))))[1] = 0x00;

	/* dsb so that a76 waits for outstanding io before comparing buffers */
	asm volatile (
		"dsb sy\n"
	);

	volatile int keep;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* verify the initial buffer matches the final buffer */
	if((keep = memcmp(dma_buffer_0, dma_buffer_1, F2H_OCRAM_32K_SPAN))
									== 0) {
		f2h_bridge->error = 0;
	} else {
		f2h_bridge->error = 6;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	f2h_bridge->buffer_compare_time1 = end_time - start_time;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* verify the initial buffer matches the final buffer */
	if((keep = memcmp(dma_buffer_0, dma_buffer_1, F2H_OCRAM_32K_SPAN))
									== 0) {
		f2h_bridge->error = 0;
	} else {
		f2h_bridge->error = 6;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"isb\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	f2h_bridge->buffer_compare_time2 = end_time - start_time;
}

