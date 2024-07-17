/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct hps_gp_s {
	uint32_t gp_sig_value;
	uint32_t gp_in_value[32];
	uint64_t gp_out_access_time[32];
	uint64_t gp_in_access_time[32];
};

void do_the_interesting_thing(struct hps_gp_s *hps_gp);

int hps_gp(int argc, char *const argv[])
{
	int i;
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	struct hps_gp_s hps_gp = {0};

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
	do_the_interesting_thing(&hps_gp);

	/* print the results */
	puts("\n");
	printf ("HPS GP Demo\n");
	puts("\n");

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
	puts("\n");

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
		printf("%3lld.%03lldns : ", ns_time, ps_time);

		ns_time = (hps_gp.gp_in_access_time[i] * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_gp.gp_in_access_time[i] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%3lld.%03lldns", ns_time, ps_time);

		puts("  | ");

		/* print second column */
		printf(" %2d: %08X : ", i + 16, hps_gp.gp_in_value[i + 16]);

		ns_time = (hps_gp.gp_out_access_time[i + 16] * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_gp.gp_out_access_time[i + 16] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%3lld.%03lldns : ", ns_time, ps_time);

		ns_time = (hps_gp.gp_in_access_time[i + 16] * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_gp.gp_in_access_time[i + 16] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%3lld.%03lldns", ns_time, ps_time);

		puts("\n");
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

void do_the_interesting_thing(struct hps_gp_s *hps_gp) {

	int i;
	uint32_t gp_in;
	uint64_t start_time;
	uint64_t end_time;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0;
	gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	hps_gp->gp_sig_value = gp_in;

	if(gp_in != GPIO_SIG)
		return;

	/* verify each bit in the 32-bit vector */
	for(i = 0 ; i < 32 ; i++) {

		/* mark the time */
		asm volatile (
			"mrs %[start_time], cntpct_el0\n"
			: [start_time] "=r" (start_time)
		);

		/* write the gp_out register */
		*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 1 << i;

		/* mark the time */
		asm volatile (
			"mrs %[end_time], cntpct_el0\n"
			: [end_time] "=r" (end_time)
		);

		hps_gp->gp_out_access_time[i] = end_time - start_time;

		/* mark the time */
		asm volatile (
			"mrs %[start_time], cntpct_el0\n"
			: [start_time] "=r" (start_time)
		);

		/* read the gp_in register */
		gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

		/* mark the time */
		asm volatile (
			"mrs %[end_time], cntpct_el0\n"
			: [end_time] "=r" (end_time)
		);

		/* save the results */
		hps_gp->gp_in_access_time[i] = end_time - start_time;
		hps_gp->gp_in_value[i] = gp_in;
	}
}

