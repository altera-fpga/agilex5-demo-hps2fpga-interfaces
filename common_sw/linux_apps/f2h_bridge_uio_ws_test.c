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
#include <sys/mman.h>
#include <termios.h>
#include <poll.h>
#include <signal.h>
#include "uio_helpers.h"
#include "standalone_common.h"

struct f2h_bridge_s {
	uint32_t gp_sig_value;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint32_t error;
	uint64_t buffer_compare_time;
	uint64_t h2f_dma_time;
	uint64_t f2h_dma_time;
	uint32_t error2;
	uint64_t buffer_compare_time2;
	uint64_t h2f_dma_time2;
	uint64_t f2h_dma_time2;
};

void do_the_interesting_thing(struct f2h_bridge_s *, struct uio_map_s *,
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
	struct uio_map_s f2h_bridge_uio_map;
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

	/* configure struct for f2h-bridge device */
	f2h_bridge_uio_map.uio_name = "f2h-bridge-uio";
	f2h_bridge_uio_map.uio_length = (F2H_OCRAM_32K_SPAN * 2);
	f2h_bridge_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	f2h_bridge_uio_map.uio_flags = MAP_SHARED;
	f2h_bridge_uio_map.uio_offset = 0;

	/* find the f2h-bridge device */
	result = find_uio_index(&f2h_bridge_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the f2h-bridge device */
	result = mmap_uio(&f2h_bridge_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&f2h_bridge, &hps_gp_uio_map,
				&f2h_bridge_uio_map);

	/* print the results */
	puts("");
	printf ("F2H Demo - UIO write streaming test\n");
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
	void *base_ptr = f2h_bridge_uio_map.uio_mmap_addr +
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
				struct uio_map_s *f2h_bridge_map) {

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
	sysid_id = *((volatile uint32_t *)(f2h_bridge_map->uio_mmap_addr +
		((F2H_SYSID_ID_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))));

	f2h_bridge->sysid_id = sysid_id;

	if(sysid_id != F2H_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(f2h_bridge_map->uio_mmap_addr +
		((F2H_SYSID_TS_BASE) &
		((F2H_OCRAM_32K_SPAN * 2) - 1))));
	f2h_bridge->sysid_ts = sysid_ts;

	f2h_bridge->error = 0;
}

