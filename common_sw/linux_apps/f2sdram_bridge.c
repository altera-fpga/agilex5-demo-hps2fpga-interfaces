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

struct f2sdram_bridge_s {
	uint32_t gp_sig_value;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint32_t error;
	uint64_t buffer_compare_time;
	uint64_t h2f_dma_time;
	uint64_t f2h_dma_time;
};

void do_the_interesting_thing(struct f2sdram_bridge_s *, struct uio_map_s *,
							struct uio_map_s *,
							struct uio_map_s *);

void do_the_interesting_thing_irq(struct f2sdram_bridge_s *, struct uio_map_s *,
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
	struct f2sdram_bridge_s f2sdram_bridge = {0};
	struct uio_map_s hps_gp_uio_map;
	struct uio_map_s f2sdram_bridge_uio_map;
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

	/* configure struct for f2sdram-bridge device */
	f2sdram_bridge_uio_map.uio_name = "f2sdram-bridge-uio";
	f2sdram_bridge_uio_map.uio_length = (F2SDRAM_OCRAM_32K_SPAN * 2);
	f2sdram_bridge_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	f2sdram_bridge_uio_map.uio_flags = MAP_SHARED;
	f2sdram_bridge_uio_map.uio_offset = 0;

	/* find the f2sdram-bridge device */
	result = find_uio_index(&f2sdram_bridge_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the f2sdram-bridge device */
	result = mmap_uio(&f2sdram_bridge_uio_map);
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

	/* polled version */
	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&f2sdram_bridge, &hps_gp_uio_map,
				&f2sdram_bridge_uio_map, &resmem_buf_uio_map);

	/* print the results */
	puts("");
	printf ("F2SDRAM Demo\n");
	puts("");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
				f2sdram_bridge.gp_sig_value,
				(f2sdram_bridge.gp_sig_value >>  0) & 0xFF,
				(f2sdram_bridge.gp_sig_value >>  8) & 0xFF,
				(f2sdram_bridge.gp_sig_value >> 16) & 0xFF,
				(f2sdram_bridge.gp_sig_value >> 24) & 0xFF);
	puts("");

	printf("SYSID_ID: 0x%08X\n", f2sdram_bridge.sysid_id);
	printf("SYSID_TS: 0x%08X\n", f2sdram_bridge.sysid_ts);
	puts("");

	puts("---------- Polled Example ----------");
	puts("");
	switch(f2sdram_bridge.error) {
	case(0):
		puts("No errors detected...");
		puts("");
		printf(" BUFFER COMPARE TIME: ");
		ns_time = (f2sdram_bridge.buffer_compare_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2sdram_bridge.buffer_compare_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns\n", ns_time, ps_time);

		printf("HPS to FPGA DMA TIME: ");
		ns_time = (f2sdram_bridge.h2f_dma_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2sdram_bridge.h2f_dma_time * 1000000000)
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

		printf("FPGA to HPS DMA TIME: ");
		ns_time = (f2sdram_bridge.f2h_dma_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2sdram_bridge.f2h_dma_time * 1000000000)
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
		puts("HPS to FPGA UIO interrupt enable failed...");
		printf("ERROR: %u\n", f2sdram_bridge.error);
		break;
	case(7):
	case(8):
	case(9):
	case(10):
		puts("HPS to FPGA DMA timeout error returned...");
		printf("ERROR: %u\n", f2sdram_bridge.error);
		break;
	case(4):
		puts("FPGA to HPS DMA busy error returned...");
		break;
	case(5):
		puts("FPGA to HPS UIO interrupt enable failed...");
		printf("ERROR: %u\n", f2sdram_bridge.error);
		break;
	case(11):
	case(12):
	case(13):
	case(14):
		puts("FPGA to HPS DMA timeout error returned...");
		printf("ERROR: %u\n", f2sdram_bridge.error);
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
	do_the_interesting_thing_irq(&f2sdram_bridge, &hps_gp_uio_map,
				&f2sdram_bridge_uio_map, &resmem_buf_uio_map);

	puts("");
	puts("---------- Interrupt Example ----------");
	puts("");
	switch(f2sdram_bridge.error) {
	case(0):
		puts("No errors detected...");
		puts("");
		printf(" BUFFER COMPARE TIME: ");
		ns_time = (f2sdram_bridge.buffer_compare_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2sdram_bridge.buffer_compare_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9ld.%03ldns\n", ns_time, ps_time);

		printf("HPS to FPGA DMA TIME: ");
		ns_time = (f2sdram_bridge.h2f_dma_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2sdram_bridge.h2f_dma_time * 1000000000)
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

		printf("FPGA to HPS DMA TIME: ");
		ns_time = (f2sdram_bridge.f2h_dma_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2sdram_bridge.f2h_dma_time * 1000000000)
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
		puts("HPS to FPGA UIO interrupt enable failed...");
		printf("ERROR: %u\n", f2sdram_bridge.error);
		break;
	case(7):
	case(8):
	case(9):
	case(10):
		puts("HPS to FPGA DMA timeout error returned...");
		printf("ERROR: %u\n", f2sdram_bridge.error);
		break;
	case(4):
		puts("FPGA to HPS DMA busy error returned...");
		break;
	case(5):
		puts("FPGA to HPS UIO interrupt enable failed...");
		printf("ERROR: %u\n", f2sdram_bridge.error);
		break;
	case(11):
	case(12):
	case(13):
	case(14):
		puts("FPGA to HPS DMA timeout error returned...");
		printf("ERROR: %u\n", f2sdram_bridge.error);
		break;
	case(6):
		puts("Buffer validation error returned...\n");
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

void do_the_interesting_thing(struct f2sdram_bridge_s *f2sdram_bridge,
				struct uio_map_s *map,
				struct uio_map_s *f2sdram_bridge_map,
				struct uio_map_s *resmem_buf_map) {

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
	uint8_t *dma_buffer_0 = (void*)(resmem_buf_map->uio_mmap_addr);
	uint8_t *dma_buffer_1 = (void*)(resmem_buf_map->uio_mmap_addr +
							F2SDRAM_OCRAM_32K_SPAN);
	uint64_t *dma_buffer_0_word_ptr = (uint64_t *)dma_buffer_0;
	uint32_t descriptor[8];
	uint64_t dma_wr_ptr;
	uint64_t dma_rd_ptr;

	f2sdram_bridge->error = 1;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	f2sdram_bridge->gp_sig_value = gp_in;

	if(gp_in != F2SD_SIG)
		return;

	/* validate the sysid signature */
	sysid_id = *((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_SYSID_ID_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))));

	f2sdram_bridge->sysid_id = sysid_id;

	if(sysid_id != F2SD_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_SYSID_TS_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))));

	f2sdram_bridge->sysid_ts = sysid_ts;

	/*
	 * we will now DMA data from dma_buffer_0 to the FPGA OCRAM buffer
	 * and then DMA from the FPGA OCRAM buffer to dma_buffer_1
	 */

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* clear the three buffers that we'll use for DMA transfers */
	/* this isn't necessary but for demonstration purposes we'll do it */
	memset(dma_buffer_0, 0, F2SDRAM_OCRAM_32K_SPAN);
	memset(dma_buffer_1, 0, F2SDRAM_OCRAM_32K_SPAN);
	for(i = 0 ; i < F2SDRAM_OCRAM_32K_SPAN ; i++) {
		((uint8_t *)(f2sdram_bridge_map->uio_mmap_addr +
			((F2SDRAM_OCRAM_32K_BASE) &
			((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[i] =
			0x00;
	}

	/* fill the initial buffer with a randomized data pattern */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	temp ^= 0xFbFdF1F3F5F7FbFd;
	temp += 0x0b0d010305070b0d;
	for(i = 0 ; i < (F2SDRAM_OCRAM_32K_SPAN / sizeof(uint64_t)) ; i++) {
		temp += 0x0b0d010305070b0d;
		dma_buffer_0_word_ptr[i] = temp++;
	}

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[0];
	if(temp_32 != 0x00000002) {
		f2sdram_bridge->error = 2;
		return;
	}

	/* build our descriptor for dma_buffer_0 to FPGA OCRAM */
	descriptor[0] = (uint64_t)(0x82000000) & 0xFFFFFFFF;
	descriptor[1] = MSGDMA_OCRAM_32K_BASE & 0xFFFFFFFF;
	descriptor[2] = F2SDRAM_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = (uint64_t)(0x00000000) >> 32;
	descriptor[6] = MSGDMA_OCRAM_32K_BASE >> 32;
	descriptor[7] = 0x80000000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 8 ; i++) {
		((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_DES_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[i] = descriptor[i];
	}

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

	temp_32 = ((volatile uint32_t *)(
			f2sdram_bridge_map->uio_mmap_addr +
			((F2SDRAM_MSGDMA_CSR_BASE) &
			((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[0];
	while((temp_32 & 0x00000001) == 0x00000001) {
		asm volatile (
			"mrs %[temp], cntvct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			f2sdram_bridge->error = 3;
			return;
		}
		temp_32 = ((volatile uint32_t *)(
			f2sdram_bridge_map->uio_mmap_addr +
			((F2SDRAM_MSGDMA_CSR_BASE) &
			((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[0];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	f2sdram_bridge->h2f_dma_time = end_time - start_time;

	/* initialize intermediate DMA pointers for F2H transfer */
	dma_rd_ptr = MSGDMA_OCRAM_32K_BASE;
	dma_wr_ptr = (uint64_t)(0x82000000 + F2SDRAM_OCRAM_32K_SPAN);

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[0];
	if(temp_32 != 0x00000002) {
		f2sdram_bridge->error = 4;
		return;
	}

	/* build our descriptor for FPGA OCRAM to dma_buffer_0 */
	descriptor[0] = dma_rd_ptr & 0xFFFFFFFF;
	descriptor[1] = dma_wr_ptr & 0xFFFFFFFF;
	descriptor[2] = F2SDRAM_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = dma_rd_ptr >> 32;
	descriptor[6] = dma_wr_ptr >> 32;
	descriptor[7] = 0x80000000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 4 ; i++) {
		((volatile uint64_t *)(f2sdram_bridge_map->uio_mmap_addr +
			((F2SDRAM_MSGDMA_DES_BASE) &
			((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[i] =
			((uint64_t)(descriptor[(i * 2) + 1]) << 32) |
			descriptor[i * 2];
	}

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

	temp_32 = ((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[0];
	while((temp_32 & 0x00000001) == 0x00000001) {
		asm volatile (
			"mrs %[temp], cntvct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			f2sdram_bridge->error = 5;
			return;
		}
		temp_32 =
		((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[0];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	f2sdram_bridge->f2h_dma_time = end_time - start_time;

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
	if(memcmp(dma_buffer_0, dma_buffer_1, F2SDRAM_OCRAM_32K_SPAN) == 0) {
		f2sdram_bridge->error = 0;
	} else {
		f2sdram_bridge->error = 6;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	f2sdram_bridge->buffer_compare_time = end_time - start_time;
}

void do_the_interesting_thing_irq(struct f2sdram_bridge_s *f2sdram_bridge,
				struct uio_map_s *map,
				struct uio_map_s *f2sdram_bridge_map,
				struct uio_map_s *resmem_buf_map) {

	uint32_t i;
	uint32_t gp_in;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t temp;
	uint32_t temp_32;
	uint8_t *dma_buffer_0 = (void*)(resmem_buf_map->uio_mmap_addr);
	uint8_t *dma_buffer_1 = (void*)(resmem_buf_map->uio_mmap_addr +
							F2SDRAM_OCRAM_32K_SPAN);
	uint64_t *dma_buffer_0_word_ptr = (uint64_t *)dma_buffer_0;
	uint32_t descriptor[8];
	uint64_t dma_wr_ptr;
	uint64_t dma_rd_ptr;
	struct pollfd fds;
	int result;

	f2sdram_bridge->error = 1;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	f2sdram_bridge->gp_sig_value = gp_in;

	if(gp_in != F2SD_SIG)
		return;

	/* validate the sysid signature */
	sysid_id = *((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_SYSID_ID_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))));

	f2sdram_bridge->sysid_id = sysid_id;

	if(sysid_id != F2SD_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_SYSID_TS_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))));

	f2sdram_bridge->sysid_ts = sysid_ts;

	/*
	 * we will now DMA data from dma_buffer_0 to the FPGA OCRAM buffer
	 * and then DMA from the FPGA OCRAM buffer to dma_buffer_1
	 */

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* clear the three buffers that we'll use for DMA transfers */
	/* this isn't necessary but for demonstration purposes we'll do it */
	memset(dma_buffer_0, 0, F2SDRAM_OCRAM_32K_SPAN);
	memset(dma_buffer_1, 0, F2SDRAM_OCRAM_32K_SPAN);
	for(i = 0 ; i < F2SDRAM_OCRAM_32K_SPAN ; i++) {
		((uint8_t *)(f2sdram_bridge_map->uio_mmap_addr +
			((F2SDRAM_OCRAM_32K_BASE) &
			((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[i] =
			0x00;
	}

	/* fill the initial buffer with a randomized data pattern */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	temp ^= 0xFbFdF1F3F5F7FbFd;
	temp += 0x0b0d010305070b0d;
	for(i = 0 ; i < (F2SDRAM_OCRAM_32K_SPAN / sizeof(uint64_t)) ; i++) {
		temp += 0x0b0d010305070b0d;
		dma_buffer_0_word_ptr[i] = temp++;
	}

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[0];
	if(temp_32 != 0x00000002) {
		f2sdram_bridge->error = 2;
		return;
	}

	/* enable the MSGDMA global interrupt mask */
	((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[1] = 0x10;

	/* enable the uio interrupt */
	temp_32 = 1;
	result = write(f2sdram_bridge_map->uio_fd, &temp_32, 4);
	if(result != 4) {
		f2sdram_bridge->error = 3;
		return;
	}

	/* build our descriptor for dma_buffer_0 to FPGA OCRAM */
	descriptor[0] = (uint64_t)(0x82000000) & 0xFFFFFFFF;
	descriptor[1] = MSGDMA_OCRAM_32K_BASE & 0xFFFFFFFF;
	descriptor[2] = F2SDRAM_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = (uint64_t)(0x00000000) >> 32;
	descriptor[6] = MSGDMA_OCRAM_32K_BASE >> 32;
	descriptor[7] = 0x80004000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 8 ; i++) {
		((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_DES_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[i] = descriptor[i];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	fds.fd = f2sdram_bridge_map->uio_fd;
	fds.events = POLLIN;
	fds.revents = 0;
	result = poll(&fds, 1, 1);

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* check the poll response */
	if(result < 0) {
		f2sdram_bridge->error = 7;
		return;
	}
	else if(result == 0) {
		f2sdram_bridge->error = 8;
		return;
	}
	if((fds.revents & POLLIN) != POLLIN) {
		f2sdram_bridge->error = 9;
		return;
	}

	/* read the uio IRQ */
	result = read(f2sdram_bridge_map->uio_fd, &temp_32, 4);
	if(result != 4) {
		f2sdram_bridge->error = 10;
		return;
	}

	/* return the DMA time */
	f2sdram_bridge->h2f_dma_time = end_time - start_time;

	/* clear the MSGDMA interrupt */
	((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[0] = 0x200;

	/* disable the MSGDMA global interrupt mask */
	((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[1] = 0x00;

	/* initialize intermediate DMA pointers for F2H transfer */
	dma_rd_ptr = MSGDMA_OCRAM_32K_BASE;
	dma_wr_ptr = (uint64_t)(0x82000000 + F2SDRAM_OCRAM_32K_SPAN);

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[0];
	if(temp_32 != 0x00000002) {
		f2sdram_bridge->error = 4;
		return;
	}

	/* enable the MSGDMA global interrupt mask */
	((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[1] = 0x10;

	/* enable the uio interrupt */
	temp_32 = 1;
	result = write(f2sdram_bridge_map->uio_fd, &temp_32, 4);
	if(result != 4) {
		f2sdram_bridge->error = 5;
		return;
	}

	/* build our descriptor for FPGA OCRAM to dma_buffer_0 */
	descriptor[0] = dma_rd_ptr & 0xFFFFFFFF;
	descriptor[1] = dma_wr_ptr & 0xFFFFFFFF;
	descriptor[2] = F2SDRAM_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = dma_rd_ptr >> 32;
	descriptor[6] = dma_wr_ptr >> 32;
	descriptor[7] = 0x80004000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 4 ; i++) {
		((volatile uint64_t *)(f2sdram_bridge_map->uio_mmap_addr +
			((F2SDRAM_MSGDMA_DES_BASE) &
			((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[i] =
			((uint64_t)(descriptor[(i * 2) + 1]) << 32) |
			descriptor[i * 2];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	fds.fd = f2sdram_bridge_map->uio_fd;
	fds.events = POLLIN;
	fds.revents = 0;
	result = poll(&fds, 1, 1);

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* check the poll response */
	if(result < 0) {
		f2sdram_bridge->error = 11;
		return;
	}
	else if(result == 0) {
		f2sdram_bridge->error = 12;
		return;
	}
	if((fds.revents & POLLIN) != POLLIN) {
		f2sdram_bridge->error = 13;
		return;
	}

	/* read the uio IRQ */
	result = read(f2sdram_bridge_map->uio_fd, &temp_32, 4);
	if(result != 4) {
		f2sdram_bridge->error = 14;
		return;
	}

	/* return the DMA time */
	f2sdram_bridge->f2h_dma_time = end_time - start_time;

	/* clear the MSGDMA interrupt */
	((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[0] = 0x200;

	/* disable the MSGDMA global interrupt mask */
	((volatile uint32_t *)(f2sdram_bridge_map->uio_mmap_addr +
		((F2SDRAM_MSGDMA_CSR_BASE) &
		((F2SDRAM_OCRAM_32K_SPAN * 2) - 1))))[1] = 0x00;

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
	if(memcmp(dma_buffer_0, dma_buffer_1, F2SDRAM_OCRAM_32K_SPAN) == 0) {
		f2sdram_bridge->error = 0;
	} else {
		f2sdram_bridge->error = 6;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	f2sdram_bridge->buffer_compare_time = end_time - start_time;
}

