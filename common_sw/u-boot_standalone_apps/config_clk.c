/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct config_clk_s {
	uint32_t gp_sig_value;
	uint32_t config_clk_start;
	uint32_t config_clk_end;
};

void do_the_interesting_thing(struct config_clk_s *config_clk);

int config_clk(int argc, char *const argv[])
{
	uint64_t counter_delta;
	struct config_clk_s config_clk = {0};

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
	do_the_interesting_thing(&config_clk);

	/* print the results */
	puts("\n");
	printf ("Configuration Clock Demo\n");
	puts("\n");

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
					config_clk.gp_sig_value,
					(config_clk.gp_sig_value >>  0) & 0xFF,
					(config_clk.gp_sig_value >>  8) & 0xFF,
					(config_clk.gp_sig_value >> 16) & 0xFF,
					(config_clk.gp_sig_value >> 24) & 0xFF);
	puts("\n");

	puts("  Configuration Clock Stats:\n");
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

	puts("\n");
	printf ("Press any key to exit this demo.");

	/* wait for console input */
	while (!tstc());

	/* discard the input */
	(void) getc();

	printf ("\n\n");
	return 0;
}

void do_the_interesting_thing(struct config_clk_s *config_clk) {

	uint32_t gp_in;
	uint32_t config_clk_start;
	uint32_t config_clk_end;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t cur_time;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0;
	gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	config_clk->gp_sig_value = gp_in;

	if(gp_in != CCLK_SIG)
		return;

	/* switch mux to config clock input */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0x02;

	/* get the generic timer frequency */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* aquire generic timer value and config clock counter */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);
	config_clk_start = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	/* calculate 1 second delay and wait */
	end_time = start_time + cntfrq_el0;
	do {
		/* aquire generic timer value and config clock counter */
		asm volatile (
			"mrs %[cur_time], cntpct_el0\n"
			: [cur_time] "=r" (cur_time)
		);
		config_clk_end = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	} while(cur_time < end_time);

	/* save the results */
	config_clk->config_clk_start = config_clk_start;
	config_clk->config_clk_end = config_clk_end;
}

