/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <termios.h>
#include <poll.h>
#include "uio_helpers.h"
#include "standalone_common.h"

struct hps_emac_s {
	uint32_t gp_sig_value;
	uint32_t error;
	uint32_t emac0_phy_config;
	uint64_t buffer_compare_time;
	uint64_t hps_emac_loop_time;
	uint64_t gmii_loop_time;
};

void do_the_interesting_thing(struct hps_emac_s *hps_emac, struct uio_map_s *,
							struct uio_map_s *,
							struct uio_map_s *,
							struct uio_map_s *,
							struct uio_map_s *);

int dev_mem_mmap_uio(struct uio_map_s *uio_map) {

	int the_fd;

	the_fd = open("/dev/mem", O_RDWR | O_SYNC);
	if(the_fd < 0)
		return 1;
	uio_map->uio_fd = the_fd;
	uio_map->uio_mmap_addr = mmap(NULL,
					uio_map->uio_length,
					uio_map->uio_prot,
					uio_map->uio_flags,
					uio_map->uio_fd,
					uio_map->uio_offset);
	if(uio_map->uio_mmap_addr == MAP_FAILED)
		return 2;
	return 0;
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
	struct hps_emac_s hps_emac = {0};
	struct uio_map_s hps_gp_uio_map;
	struct uio_map_s rst_mgr_uio_map;
	struct uio_map_s sys_mgr_uio_map;
	struct uio_map_s emac_uio_map;
	struct uio_map_s resmem_buf_uio_map;
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

	/* configure struct for rst-mgr-uio device */
	rst_mgr_uio_map.uio_name = "rst-mgr-uio";
	rst_mgr_uio_map.uio_length = getpagesize();
	rst_mgr_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	rst_mgr_uio_map.uio_flags = MAP_SHARED;
	rst_mgr_uio_map.uio_offset = 0;

	/* find the rst-mgr-uio device */
	result = find_uio_index(&rst_mgr_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the rst-mgr-uio device */
	result = mmap_uio(&rst_mgr_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* configure struct for sys-mgr-uio device */
	sys_mgr_uio_map.uio_name = "sys-mgr-uio";
	sys_mgr_uio_map.uio_length = getpagesize();
	sys_mgr_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	sys_mgr_uio_map.uio_flags = MAP_SHARED;
	sys_mgr_uio_map.uio_offset = 0;

	/* find the sys-mgr-uio device */
	result = find_uio_index(&sys_mgr_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the sys-mgr-uio device */
	result = mmap_uio(&sys_mgr_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* configure struct for emac device */
	emac_uio_map.uio_name = "emac-uio";
	emac_uio_map.uio_length = (getpagesize() * 4);
	emac_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	emac_uio_map.uio_flags = MAP_SHARED;
	emac_uio_map.uio_offset = 0;

	/* find the emac device */
	result = find_uio_index(&emac_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the emac device */
	result = mmap_uio(&emac_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* configure struct for resmem-buf device */
	resmem_buf_uio_map.uio_name = "resmem-buf-uio";
	resmem_buf_uio_map.uio_length = 0x04000000;
	resmem_buf_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	resmem_buf_uio_map.uio_flags = MAP_SHARED;
	resmem_buf_uio_map.uio_offset = 0x82000000;

	/* open and map the resmem-buf device */
	result = dev_mem_mmap_uio(&resmem_buf_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&hps_emac, &hps_gp_uio_map, &rst_mgr_uio_map,
			&sys_mgr_uio_map, &emac_uio_map, &resmem_buf_uio_map);

	/* print the results */
	puts("");
	printf ("HPS EMAC Demo\n");
	puts("");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
				hps_emac.gp_sig_value,
				(hps_emac.gp_sig_value >>  0) & 0xFF,
				(hps_emac.gp_sig_value >>  8) & 0xFF,
				(hps_emac.gp_sig_value >> 16) & 0xFF,
				(hps_emac.gp_sig_value >> 24) & 0xFF);
	puts("");

	switch(hps_emac.error) {
	case(0):
		puts("No errors detected...");
		puts("");

		printf("        BUFFER COMPARE TIME: ");
		ns_time = (hps_emac.buffer_compare_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_emac.buffer_compare_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns\n", ns_time, ps_time);

		if(hps_emac.emac0_phy_config != SYSMGR_TSN0_PHY_INTF_SEL_GMII) {

			printf("HPS EMAC INTERNAL LOOP TIME: ");
			ns_time = (hps_emac.hps_emac_loop_time * 1000000000)
								/ cntfrq_el0;
			ps_time = (hps_emac.hps_emac_loop_time * 1000000000)
								% cntfrq_el0;
			ps_time *= 1000;
			ps_time /= cntfrq_el0;
			printf("%9ld.%03ldns", ns_time, ps_time);
			bytes_per_sec = (F2H_OCRAM_32K_SPAN * 1000000000UL)
								/ ns_time;
			gb_per_sec = bytes_per_sec / (1024 * 1024 * 1024);
			gb_per_sec_frac = bytes_per_sec % (1024 * 1024 * 1024);
			gb_per_sec_frac *= 1000;
			gb_per_sec_frac /= (1024 * 1024 * 1024);
			printf(" : %3ld.%03ldGB/s\n", gb_per_sec,
							gb_per_sec_frac);

			puts("");
			printf("\
    This demo used the HPS EMAC internal loopback because the\n\
    phy_intf_sel field of the tsn0 register in the system manager was\n\
    NOT configured for GMII mode. The tsn0 register at 0x10D12044 can be\n\
    read from user mode but it requires secure/privileged state to write\n\
    that register.\n\
\n\
    To run this demo with the GMII loopback provided in the FPGA logic\n\
    design, reboot the board and run the hps emac demo in the u-boot\n\
    environment first and then boot into Linux and run this demo again.\n\
    When the u-boot version of this demo runs, it runs using the\n\
    internal HPS EMAC loopback first and then uses the GMII loopback and\n\
    leaves the phy_intf_sel configuration set to GMII.\n\
");
		} else {

			printf("             GMII LOOP TIME: ");
			ns_time = (hps_emac.gmii_loop_time * 1000000000)
								/ cntfrq_el0;
			ps_time = (hps_emac.gmii_loop_time * 1000000000)
								% cntfrq_el0;
			ps_time *= 1000;
			ps_time /= cntfrq_el0;
			printf("%9ld.%03ldns", ns_time, ps_time);
			bytes_per_sec = (F2H_OCRAM_32K_SPAN * 1000000000UL)
								/ ns_time;
			gb_per_sec = bytes_per_sec / (1024 * 1024 * 1024);
			gb_per_sec_frac = bytes_per_sec % (1024 * 1024 * 1024);
			gb_per_sec_frac *= 1000;
			gb_per_sec_frac /= (1024 * 1024 * 1024);
			printf(" : %3ld.%03ldGB/s\n", gb_per_sec,
							gb_per_sec_frac);

			puts("");
			printf("\
    This demo used the GMII loopback provided in the FPGA logic because\n\
    the phy_intf_sel field of the tsn0 register in the system manager\n\
    was configured for GMII mode. The tsn0 register at 0x10D12044 can be\n\
    read from user mode but it requires secure/privileged state to write\n\
    that register.\n\
\n\
    To run this demo with the HPS EMAC internal loopback, reboot the\n\
    board and DO NOT run the hps emac demo in the u-boot environment\n\
    before booting into Linux and run this demo again. When the u-boot\n\
    version of this demo runs, it runs using the internal HPS EMAC\n\
    loopback first and then uses the GMII loopback and leaves the\n\
    phy_intf_sel configuration set to GMII.\n\
");
		}
		break;
	case(1):
		puts("FPGA system validation error returned...");
		break;
	case(3):
		puts("HPS EMAC software reset timeout error returned...");
		break;
	case(4):
		puts("DMA idle timeout error returned...");
		break;
	case(5):
		puts("Buffer validation error returned...");
		puts("Initial buffer does not match final buffer...");
		break;
	default:
		puts("Unknown error returned...");
	}

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

struct descriptor_s {
	uint32_t desc0;
	uint32_t desc1;
	uint32_t desc2;
	uint32_t desc3;
};

void do_the_interesting_thing(struct hps_emac_s *hps_emac,
					struct uio_map_s *map,
					struct uio_map_s *rst_mgr_map,
					struct uio_map_s *sys_mgr_map,
					struct uio_map_s *emac_uio_map,
					struct uio_map_s *resmem_buf_map) {

	int i;
	uint32_t gp_in;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t timeout;
	uint64_t temp;
	uint32_t temp_32;
	uint8_t *tx_data_buffer = (void*)(resmem_buf_map->uio_mmap_addr);
	uint8_t *rx_data_buffer =
		(void*)(resmem_buf_map->uio_mmap_addr + 0x10000);
	uint64_t *tx_data_buffer_word_ptr = (uint64_t *)tx_data_buffer;
	struct descriptor_s *tx_descriptors =
			(void*)(resmem_buf_map->uio_mmap_addr + 0x20000);
	struct descriptor_s *rx_descriptors =
			(void*)(resmem_buf_map->uio_mmap_addr + 0x30000);

	hps_emac->error = 1;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	hps_emac->gp_sig_value = gp_in;

	if(gp_in != EMAC_SIG)
		return;

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/*
	 * we will now transmit data from tx_data_buffer, through the HPS EMAC
	 * loopback, and receive it in the rx_data_buffer
	 */

	/* clear the DMA data buffers */
	/* this isn't necessary but for demonstration purposes we'll do it */
	memset(tx_data_buffer, 0, (32 * 1024));
	memset(rx_data_buffer, 0, (32 * 1024));

	/* fill the tx buffer with a randomized data pattern */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	temp ^= 0xFbFdF1F3F5F7FbFd;
	temp += 0x0b0d010305070b0d;
	for(i = 0 ; i < (int)((32 * 1024) / sizeof(uint64_t)) ; i++) {
		temp += 0x0b0d010305070b0d;
		tx_data_buffer_word_ptr[i] = temp++;
	}

	/*
	 * adjust MAC addresses and length field for each packet
	 *
	 * set the U/L bit, clear the I/G bit and clear the two SLAP bits
	 * so our MAC addresses shall be X2-XX-XX-XX-XX-XX and our length field
	 * shall be 0x0400
	 */
	for(i = 0 ; i < 32 ; i++) {

		/* adjust destination MAC address */
		tx_data_buffer[(i * 0x400) + 0] &= 0xF0;
		tx_data_buffer[(i * 0x400) + 0] |= 0x02;

		/* adjust source MAC address */
		tx_data_buffer[(i * 0x400) + 6] &= 0xF0;
		tx_data_buffer[(i * 0x400) + 6] |= 0x02;

		/* adjust length field */
		tx_data_buffer[(i * 0x400) + 12] |= 0x04;
		tx_data_buffer[(i * 0x400) + 13] |= 0x00;
	}

	/* create the TX/RX descriptor rings */
	for(i = 0 ; i < 32 ; i++) {
		/* tx desc0 - buffer 1 address */
		tx_descriptors[i].desc0 =
			(uint64_t)(0x82000000 + (i * 1024)) & 0xFFFFFFFF;
		/* tx desc1 - buffer 2 address */
		tx_descriptors[i].desc1 = 0;
		/* tx desc2 - buffer 1 length */
		tx_descriptors[i].desc2 = 1024;
		/* tx desc3 - OWN, FD, LD */
		tx_descriptors[i].desc3 = 0xB0000000;

		/* rx desc0 - buffer 1 address */
		rx_descriptors[i].desc0 =
			(uint64_t)(0x82010000 + (i * 1024)) & 0xFFFFFFFF;
		/* rx desc1 - reserved */
		rx_descriptors[i].desc1 = 0;
		/* rx desc2 - buffer 2 */
		rx_descriptors[i].desc2 = 0;
		/* rx desc3 - OWN, reserved */
		rx_descriptors[i].desc3 = 0x80000000;
	}

	/* null the last tx descriptor in the ring */
	tx_descriptors[i].desc0 = 0;
	tx_descriptors[i].desc1 = 0;
	tx_descriptors[i].desc2 = 0;
	tx_descriptors[i].desc3 = 0;

	/* null the last rx descriptor in the ring */
	rx_descriptors[i].desc0 = 0;
	rx_descriptors[i].desc1 = 0;
	rx_descriptors[i].desc2 = 0;
	rx_descriptors[i].desc3 = 0;

	/* read the current emac0 phy interface configuration */
	hps_emac->emac0_phy_config =
		*((volatile uint32_t *)(sys_mgr_map->uio_mmap_addr +
					(SYSMGR_TSN0_BASE & 0xFFF)));
	hps_emac->emac0_phy_config &= 0x3;

	/* assert reset the EMAC0 peripheral */
	temp_32 = *((volatile uint32_t *)(rst_mgr_map->uio_mmap_addr +
					(PER0MODRST_BASE & 0xFFF)));
	*((volatile uint32_t *)(rst_mgr_map->uio_mmap_addr +
		(PER0MODRST_BASE & 0xFFF))) = temp_32 | PER0MODRST_EMAC0;

	/* deassert reset the EMAC0 peripheral */
	temp_32 = *((volatile uint32_t *)(rst_mgr_map->uio_mmap_addr +
					(PER0MODRST_BASE & 0xFFF)));
	*((volatile uint32_t *)(rst_mgr_map->uio_mmap_addr +
		(PER0MODRST_BASE & 0xFFF))) = temp_32 & ~PER0MODRST_EMAC0;

	/* assert software reset to the EMAC0 peripheral */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_BASE + DMA_Mode_OFST) & 0x3FFF))) = 0x00000001;

	/* wait for software reset to clear or timeout */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	do {
		asm volatile (
			"mrs %[temp], cntvct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			hps_emac->error = 3;
			return;
		}

		temp_32 = *((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
				((EMAC0_DMA_BASE + DMA_Mode_OFST) & 0x3FFF)));
	} while(temp_32 & 0x00000001);

	/* configure the EMAC0 DMA_SysBus_Mode register */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_BASE + DMA_SysBus_Mode_OFST) & 0x3FFF))) =
								0x000000FF;

	/* configure the transmit descriptor ring length */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_CH0_BASE + DMA_CH0_TX_Control2_OFST) & 0x3FFF))) =
									33 - 1;

	/* configure the receive descriptor ring length */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_CH0_BASE + DMA_CH0_RX_Control2_OFST) & 0x3FFF))) =
									33 - 1;

	/* configure the transmit descriptor ring base */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_CH0_BASE + DMA_CH0_TxDesc_List_LAddress_OFST) &
		0x3FFF))) = (uint64_t)(0x82020000) & 0xFFFFFFFF;

	/* configure the receive descriptor ring base */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_CH0_BASE + DMA_CH0_RxDesc_List_LAddress_OFST) &
		0x3FFF))) = (uint64_t)(0x82030000) & 0xFFFFFFFF;

	/* configure the transmit descriptor ring tail pointer */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_CH0_BASE + DMA_CH0_TxDesc_Tail_LPointer_OFST) &
		0x3FFF))) = (uint64_t)(0x82020000 +
			(32 * sizeof(struct descriptor_s))) & 0xFFFFFFFF;

	/* configure the receive descriptor ring tail pointer */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_CH0_BASE + DMA_CH0_RxDesc_Tail_LPointer_OFST) &
		0x3FFF))) = (uint64_t)(0x82030000 +
			(32 * sizeof(struct descriptor_s))) & 0xFFFFFFFF;

	/* start the transmit DMA */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_CH0_BASE + DMA_CH0_TX_Control_OFST) & 0x3FFF))) =
								0x00200001;

	/* start the receive DMA */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_CH0_BASE + DMA_CH0_RX_Control_OFST) & 0x3FFF))) =
								0x00201001;

	/* configure the MAC packet filter, receive all packets promiscuously */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_MAC_BASE + MAC_Packet_Filter_OFST) & 0x3FFF))) =
								0x80000001;

	/* enable TxQ0, store and forward mode, 32KB queue size */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_MTL_BASE + MTL_TxQ0_Operation_Mode_OFST) & 0x3FFF))) =
								0x007F000A;

	/* configure RxQ0, store and forward mode, 32KB queue size */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_MTL_BASE + MTL_RxQ0_Operation_Mode_OFST) & 0x3FFF))) =
								0x007F0020;

	/* enable RxQ0 */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_MAC_BASE + MAC_RxQ_Ctrl0_OFST) & 0x3FFF))) =
								0x00000002;

	/* enable packet reception, internal loopback, FCS stripping  */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_MAC_BASE + MAC_Rx_Configuration_OFST) & 0x3FFF))) =
		(hps_emac->emac0_phy_config == SYSMGR_TSN0_PHY_INTF_SEL_GMII) ?
								0x00000007 :
								0x00000407;

	/* enable packet transmission, 1Gbps speed */
	*((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_MAC_BASE + MAC_Tx_Configuration_OFST) & 0x3FFF))) =
								0x60000001;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = *((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_CH0_BASE + DMA_CH0_Status_OFST) & 0x3FFF)));
	while(temp_32 != 0x00000084) {
		asm volatile (
			"mrs %[temp], cntvct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			hps_emac->error = 4;
			return;
		}
		temp_32 = *((volatile uint32_t *)(emac_uio_map->uio_mmap_addr +
		((EMAC0_DMA_CH0_BASE + DMA_CH0_Status_OFST) & 0x3FFF)));
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	if(hps_emac->emac0_phy_config == SYSMGR_TSN0_PHY_INTF_SEL_GMII)
		hps_emac->gmii_loop_time = end_time - start_time;
	else
		hps_emac->hps_emac_loop_time = end_time - start_time;

	/* dsb so that a76 waits for outstanding io before comparing buffers */
	asm volatile (
		"dsb sy\n"
	);

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* verify the initial buffer matches the final buffer */
	if(memcmp(tx_data_buffer, rx_data_buffer, (32 * 1024)) == 0) {
		hps_emac->error = 0;
	} else {
		hps_emac->error = 5;
		return;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	hps_emac->buffer_compare_time = end_time - start_time;
}