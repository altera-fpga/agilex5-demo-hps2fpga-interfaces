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
#include "uio_helpers.h"
#include "standalone_common.h"

struct config_clk_s {
	uint32_t gp_sig_value;
	uint32_t config_clk_start;
	uint32_t config_clk_end;
};

void do_the_interesting_thing(struct config_clk_s *, struct uio_map_s *);

int main(void)
{
	char c;
	int result;
	int the_fd;
	char *next_app_name;
	ssize_t next_app_name_len;
	uint64_t counter_delta;
	struct config_clk_s config_clk = {0};
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

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&config_clk, &hps_gp_uio_map);

	/* print the results */
	puts("");
	printf ("Configuration Clock Demo\n");
	puts("");

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
					config_clk.gp_sig_value,
					(config_clk.gp_sig_value >>  0) & 0xFF,
					(config_clk.gp_sig_value >>  8) & 0xFF,
					(config_clk.gp_sig_value >> 16) & 0xFF,
					(config_clk.gp_sig_value >> 24) & 0xFF);
	puts("");

	puts("  Configuration Clock Stats:");
	printf("      Counter Start = 0x%08X\n", config_clk.config_clk_start);
	printf("        Counter End = 0x%08X\n", config_clk.config_clk_end);

	/* detect counter rollover and calculate delta */
	if(config_clk.config_clk_start > config_clk.config_clk_end) {

		counter_delta = config_clk.config_clk_end + 0x100000000;
		counter_delta -= config_clk.config_clk_start;

	} else {

		counter_delta = config_clk.config_clk_end -
						config_clk.config_clk_start;
	}

	printf("      Counter Delta = 0x%08X\n", (uint32_t)counter_delta);
	printf("          Frequency = %d MHz\n", (uint32_t)counter_delta);

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

void do_the_interesting_thing(struct config_clk_s *config_clk,
					struct uio_map_s *map) {

	uint32_t gp_in;
	uint32_t config_clk_start;
	uint32_t config_clk_end;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t cur_time;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	config_clk->gp_sig_value = gp_in;

	if(gp_in != CCLK_SIG)
		return;

	/* switch mux to config clock input */
	*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0x02;

	/* get the generic timer frequency */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* aquire generic timer value and config clock counter */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);
	config_clk_start = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	/* calculate 1 second delay and wait */
	end_time = start_time + cntfrq_el0;
	do {
		/* aquire generic timer value and config clock counter */
		asm volatile (
			"mrs %[cur_time], cntvct_el0\n"
			: [cur_time] "=r" (cur_time)
		);
		config_clk_end = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	} while(cur_time < end_time);

	/* save the results */
	config_clk->config_clk_start = config_clk_start;
	config_clk->config_clk_end = config_clk_end;
}

