/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct results_s {
	uint64_t cntfrq_el0;
	uint64_t reg[10];
	uint64_t mmap[10];
};

void do_the_interesting_thing(struct results_s *);

int system_counter(int argc, char *const argv[])
{
	int i;
	struct results_s results;
	uint64_t delta;
	uint64_t ns_time;
	uint64_t ps_time;

	/* initialize u-boot standalone application environment */
	app_startup(argv);

	/* set NEXTPROG env var to run sw_boot_app upon our exit */
	env_set("NEXTPROG", "sw_boot_app");

	/* validate the u-boot API version */
	if(get_version() != XF_VERSION) {
		puts("\n");
		puts("Unexpected U-Boot ABI version\n");
		printf("EXPECT: %d\n", XF_VERSION);
		printf("ACTUAL: %d\n", (int)get_version());
		puts("\n");
		return 1;
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&results);

	/* print the results */
	puts("\n");
	printf ("System Counter / Generic Timer Demo\n");

	puts("\n");
	printf(	"Results using an assembly instruction "
		"to read the system counter register 10\n"
		"times in a row. The system counter values "
		"are printed along with the counter\n"
		"deltas between each read of the register.\n");
	puts("\n");
	printf("    reg[0] = 0x%016llX\n", results.reg[0]);
	for( i = 1 ; i < 10 ; i++) {
		delta = results.reg[i] - results.reg[i - 1];
		ns_time = delta * 1000000000 / results.cntfrq_el0;
		ps_time = delta * 1000000000 % results.cntfrq_el0;
		ps_time *= 1000;
		ps_time /= results.cntfrq_el0;
		printf("    reg[%d] = 0x%016llX : "
			"delta = 0x%016llX : "
			"%lld.%03lld ns\n",
			i, results.reg[i], delta, ns_time, ps_time);
	}

	puts("\n");
	printf(	"Results using a load instruction to read "
		"the system counter register from the\n"
		"memory map 10 times in a row. The system "
		"counter values are printed along with\n"
		"the counter deltas between each read of "
		"the register.\n");

	puts("\n");
	printf("    mmap[0] = 0x%016llX\n", results.mmap[0]);
	for( i = 1 ; i < 10 ; i++) {
		delta = results.mmap[i] - results.mmap[i - 1];
		ns_time = delta * 1000000000 / results.cntfrq_el0;
		ps_time = delta * 1000000000 % results.cntfrq_el0;
		ps_time *= 1000;
		ps_time /= results.cntfrq_el0;
		printf("    mmap[%d] = 0x%016llX : "
			"delta = 0x%016llX : "
			"%lld.%03lld ns\n",
			i, results.mmap[i], delta, ns_time, ps_time);
	}

	puts("\n");
	printf ("Press any key to exit this demo.");

	/* wait for console input */
	while (!tstc());

	/* discard the input */
	(void) getc();

	printf ("\n\n");
	return 0;
}

void do_the_interesting_thing(struct results_s *results) {

	uint64_t temp_0, temp_1, temp_2, temp_3, temp_4;
	uint64_t temp_5, temp_6, temp_7, temp_8, temp_9;

	/* read the cntpct_el0 cpu register 10 times in a row */
	asm volatile (
		"mrs %[temp_0], cntpct_el0\n"
		"mrs %[temp_1], cntpct_el0\n"
		"mrs %[temp_2], cntpct_el0\n"
		"mrs %[temp_3], cntpct_el0\n"
		"mrs %[temp_4], cntpct_el0\n"
		"mrs %[temp_5], cntpct_el0\n"
		"mrs %[temp_6], cntpct_el0\n"
		"mrs %[temp_7], cntpct_el0\n"
		"mrs %[temp_8], cntpct_el0\n"
		"mrs %[temp_9], cntpct_el0\n"
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
	temp_0 = *((volatile uint64_t *)(SYSTEM_COUNTER_BASE));
	temp_1 = *((volatile uint64_t *)(SYSTEM_COUNTER_BASE));
	temp_2 = *((volatile uint64_t *)(SYSTEM_COUNTER_BASE));
	temp_3 = *((volatile uint64_t *)(SYSTEM_COUNTER_BASE));
	temp_4 = *((volatile uint64_t *)(SYSTEM_COUNTER_BASE));
	temp_5 = *((volatile uint64_t *)(SYSTEM_COUNTER_BASE));
	temp_6 = *((volatile uint64_t *)(SYSTEM_COUNTER_BASE));
	temp_7 = *((volatile uint64_t *)(SYSTEM_COUNTER_BASE));
	temp_8 = *((volatile uint64_t *)(SYSTEM_COUNTER_BASE));
	temp_9 = *((volatile uint64_t *)(SYSTEM_COUNTER_BASE));

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

