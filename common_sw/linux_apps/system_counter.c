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

struct results_s {
	uint64_t cntfrq_el0;
	uint64_t reg[10];
	uint64_t mmap[10];
};

void do_the_interesting_thing(struct results_s *, struct uio_map_s *);

int main(void)
{
	int i;
	char c;
	int result;
	int the_fd;
	char *next_app_name;
	ssize_t next_app_name_len;
	struct results_s results;
	uint64_t delta;
	uint64_t ns_time;
	uint64_t ps_time;
	struct uio_map_s sys_cntr_uio_map;
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

	/* configure struct for sys-cntr-uio device */
	sys_cntr_uio_map.uio_name = "sys-cntr-uio";
	sys_cntr_uio_map.uio_length = getpagesize();
	sys_cntr_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	sys_cntr_uio_map.uio_flags = MAP_SHARED;
	sys_cntr_uio_map.uio_offset = 0;

	/* find the sys-cntr-uio device */
	result = find_uio_index(&sys_cntr_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the sys-cntr-uio device */
	result = mmap_uio(&sys_cntr_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&results, &sys_cntr_uio_map);

	/* print the results */
	puts("");
	printf ("System Counter / Generic Timer Demo\n");

	puts("");
	printf(	"Results using an assembly instruction "
		"to read the system counter register 10\n"
		"times in a row. The system counter values "
		"are printed along with the counter\n"
		"deltas between each read of the register.\n");
	puts("");
	printf("    reg[0] = 0x%016lX\n", results.reg[0]);
	for( i = 1 ; i < 10 ; i++) {
		delta = results.reg[i] - results.reg[i - 1];
		ns_time = delta * 1000000000 / results.cntfrq_el0;
		ps_time = delta * 1000000000 % results.cntfrq_el0;
		ps_time *= 1000;
		ps_time /= results.cntfrq_el0;
		printf("    reg[%d] = 0x%016lX : "
			"delta = 0x%016lX : "
			"%ld.%03ld ns\n",
			i, results.reg[i], delta, ns_time, ps_time);
	}

	puts("");
	printf(	"Results using a load instruction to read "
		"the system counter register from the\n"
		"memory map 10 times in a row. The system "
		"counter values are printed along with\n"
		"the counter deltas between each read of "
		"the register.\n");

	puts("");
	printf("    mmap[0] = 0x%016lX\n", results.mmap[0]);
	for( i = 1 ; i < 10 ; i++) {
		delta = results.mmap[i] - results.mmap[i - 1];
		ns_time = delta * 1000000000 / results.cntfrq_el0;
		ps_time = delta * 1000000000 % results.cntfrq_el0;
		ps_time *= 1000;
		ps_time /= results.cntfrq_el0;
		printf("    mmap[%d] = 0x%016lX : "
			"delta = 0x%016lX : "
			"%ld.%03ld ns\n",
			i, results.mmap[i], delta, ns_time, ps_time);
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

	/* unmap and close the sys-cntr-uio device */
	result = munmap_uio(&sys_cntr_uio_map);
	if(result != 0) {
		printf("ERROR: munmap_uio : %d\n", result);
		return 1;
	}

	return 0;
}

void do_the_interesting_thing(struct results_s *results,
							struct uio_map_s *map) {

	uint64_t temp_0, temp_1, temp_2, temp_3, temp_4;
	uint64_t temp_5, temp_6, temp_7, temp_8, temp_9;

	/*
	 * the current CPU configuration does not allow us to read the
	 * cntpct_el0 status register from user space EL0 privilege state, but
	 * we can read the cntvct_el0 status register which is equivalent
	 */

	/* read the cntvct_el0 cpu register 10 times in a row */
	asm volatile (
		"mrs %[temp_0], cntvct_el0\n"
		"mrs %[temp_1], cntvct_el0\n"
		"mrs %[temp_2], cntvct_el0\n"
		"mrs %[temp_3], cntvct_el0\n"
		"mrs %[temp_4], cntvct_el0\n"
		"mrs %[temp_5], cntvct_el0\n"
		"mrs %[temp_6], cntvct_el0\n"
		"mrs %[temp_7], cntvct_el0\n"
		"mrs %[temp_8], cntvct_el0\n"
		"mrs %[temp_9], cntvct_el0\n"
		:
		[temp_0] "=r" (temp_0), [temp_1] "=r" (temp_1),
		[temp_2] "=r" (temp_2), [temp_3] "=r" (temp_3),
		[temp_4] "=r" (temp_4), [temp_5] "=r" (temp_5),
		[temp_6] "=r" (temp_6), [temp_7] "=r" (temp_7),
		[temp_8] "=r" (temp_8), [temp_9] "=r" (temp_9)
	);

	/* save the results */
	results->reg[0] = temp_0;
	results->reg[1] = temp_1;
	results->reg[2] = temp_2;
	results->reg[3] = temp_3;
	results->reg[4] = temp_4;
	results->reg[5] = temp_5;
	results->reg[6] = temp_6;
	results->reg[7] = temp_7;
	results->reg[8] = temp_8;
	results->reg[9] = temp_9;

	/* read the cntpct_el0 memory mapped location 10 times in a row */
	temp_0 = *((volatile uint64_t *)(map->uio_mmap_addr));
	temp_1 = *((volatile uint64_t *)(map->uio_mmap_addr));
	temp_2 = *((volatile uint64_t *)(map->uio_mmap_addr));
	temp_3 = *((volatile uint64_t *)(map->uio_mmap_addr));
	temp_4 = *((volatile uint64_t *)(map->uio_mmap_addr));
	temp_5 = *((volatile uint64_t *)(map->uio_mmap_addr));
	temp_6 = *((volatile uint64_t *)(map->uio_mmap_addr));
	temp_7 = *((volatile uint64_t *)(map->uio_mmap_addr));
	temp_8 = *((volatile uint64_t *)(map->uio_mmap_addr));
	temp_9 = *((volatile uint64_t *)(map->uio_mmap_addr));

	/* save the results */
	results->mmap[0] = temp_0;
	results->mmap[1] = temp_1;
	results->mmap[2] = temp_2;
	results->mmap[3] = temp_3;
	results->mmap[4] = temp_4;
	results->mmap[5] = temp_5;
	results->mmap[6] = temp_6;
	results->mmap[7] = temp_7;
	results->mmap[8] = temp_8;
	results->mmap[9] = temp_9;

	/* read the cntfrq_el0 cpu register */
	asm volatile (
		"mrs %[temp_0], cntfrq_el0\n"
		: [temp_0] "=r" (temp_0)
	);

	/* save the result */
	results->cntfrq_el0 = temp_0;
}

