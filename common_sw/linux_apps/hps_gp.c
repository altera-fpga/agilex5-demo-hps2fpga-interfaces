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

struct hps_gp_s {
	uint32_t gp_sig_value;
	uint32_t gp_in_value[32];
	uint64_t gp_out_access_time[32];
	uint64_t gp_in_access_time[32];
};

void do_the_interesting_thing(struct hps_gp_s *, struct uio_map_s *);

int main(void)
{
	int i;
	char c;
	int result;
	int the_fd;
	char *next_app_name;
	ssize_t next_app_name_len;
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	struct hps_gp_s hps_gp = {0};
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
	do_the_interesting_thing(&hps_gp, &hps_gp_uio_map);

	/* print the results */
	puts("");
	printf ("HPS GP Demo\n");
	puts("");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
					hps_gp.gp_sig_value,
					(hps_gp.gp_sig_value >>  0) & 0xFF,
					(hps_gp.gp_sig_value >>  8) & 0xFF,
					(hps_gp.gp_sig_value >> 16) & 0xFF,
					(hps_gp.gp_sig_value >> 24) & 0xFF);
	puts("");

	printf("IDX: GPIN VAL : GPOUT WR  : GPIN RD   "
		" | IDX: GPIN VAL : GPOUT WR  : GPIN RD\n");
	printf("---+----------+-----------+-----------"
		"-+---------------+-----------+----------\n");

	for(i = 0 ; i < 16 ; i++) {

		/* print first column */
		printf(" %2d: %08X : ", i, hps_gp.gp_in_value[i]);

		ns_time = (hps_gp.gp_out_access_time[i] * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_gp.gp_out_access_time[i] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%3ld.%03ldns : ", ns_time, ps_time);

		ns_time = (hps_gp.gp_in_access_time[i] * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_gp.gp_in_access_time[i] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%3ld.%03ldns", ns_time, ps_time);

		printf("  | ");

		/* print second column */
		printf(" %2d: %08X : ", i + 16, hps_gp.gp_in_value[i + 16]);

		ns_time = (hps_gp.gp_out_access_time[i + 16] * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_gp.gp_out_access_time[i + 16] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%3ld.%03ldns : ", ns_time, ps_time);

		ns_time = (hps_gp.gp_in_access_time[i + 16] * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_gp.gp_in_access_time[i + 16] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%3ld.%03ldns", ns_time, ps_time);

		puts("");
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

	/* unmap and close the hps-gp-uio device */
	result = munmap_uio(&hps_gp_uio_map);
	if(result != 0) {
		printf("ERROR: munmap_uio : %d\n", result);
		return 1;
	}

	return 0;
}

void do_the_interesting_thing(struct hps_gp_s *hps_gp,
					struct uio_map_s *map) {

	int i;
	uint32_t gp_in;
	uint64_t start_time;
	uint64_t end_time;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	hps_gp->gp_sig_value = gp_in;

	if(gp_in != GPIO_SIG)
		return;

	/* verify each bit in the 32-bit vector */
	for(i = 0 ; i < 32 ; i++) {

		/* mark the time */
		asm volatile (
			"mrs %[start_time], cntvct_el0\n"
			: [start_time] "=r" (start_time)
		);

		/* write the gp_out register */
		*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 1 << i;

		/* mark the time */
		asm volatile (
			"mrs %[end_time], cntvct_el0\n"
			: [end_time] "=r" (end_time)
		);

		hps_gp->gp_out_access_time[i] = end_time - start_time;

		/* mark the time */
		asm volatile (
			"mrs %[start_time], cntvct_el0\n"
			: [start_time] "=r" (start_time)
		);

		/* read the gp_in register */
		gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

		/* mark the time */
		asm volatile (
			"mrs %[end_time], cntvct_el0\n"
			: [end_time] "=r" (end_time)
		);

		/* save the results */
		hps_gp->gp_in_access_time[i] = end_time - start_time;
		hps_gp->gp_in_value[i] = gp_in;
	}
}

