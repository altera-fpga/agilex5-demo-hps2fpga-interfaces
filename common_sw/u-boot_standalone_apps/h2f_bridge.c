/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct h2f_bridge_s {
	uint32_t gp_sig_value;
	uint32_t sysid_id;
	uint32_t sysid_ts;

	uint64_t lo_1g_readback[2];
	uint64_t hi_1g_readback[2];
	uint64_t write_lo_1g_access_time[2];
	uint64_t write_hi_1g_access_time[2];
	uint64_t read_lo_1g_access_time[2];
	uint64_t read_hi_1g_access_time[2];

	uint64_t lo_15g_readback[2];
	uint64_t hi_15g_readback[2];
	uint64_t write_lo_15g_access_time[2];
	uint64_t write_hi_15g_access_time[2];
	uint64_t read_lo_15g_access_time[2];
	uint64_t read_hi_15g_access_time[2];

	uint64_t lo_240g_readback[2];
	uint64_t hi_240g_readback[2];
	uint64_t write_lo_240g_access_time[2];
	uint64_t write_hi_240g_access_time[2];
	uint64_t read_lo_240g_access_time[2];
	uint64_t read_hi_240g_access_time[2];
};

void do_the_interesting_thing(struct h2f_bridge_s *h2f_bridge);

int h2f_bridge(int argc, char *const argv[])
{
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	struct h2f_bridge_s h2f_bridge = {0};

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
	do_the_interesting_thing(&h2f_bridge);

	/* print the results */
	puts("\n");
	printf ("H2F Demo\n");
	puts("\n");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
				h2f_bridge.gp_sig_value,
				(h2f_bridge.gp_sig_value >>  0) & 0xFF,
				(h2f_bridge.gp_sig_value >>  8) & 0xFF,
				(h2f_bridge.gp_sig_value >> 16) & 0xFF,
				(h2f_bridge.gp_sig_value >> 24) & 0xFF);
	puts("\n");

	printf("SYSID_ID: 0x%08X\n", h2f_bridge.sysid_id);
	printf("SYSID_TS: 0x%08X\n", h2f_bridge.sysid_ts);

	puts("\n");
	printf("     ---1GB SPAN--- :     ---PASS 1---   :     ---PASS 2---\n");

	printf("LO WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_lo_1g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_1g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_lo_1g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_1g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf("HI WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_hi_1g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_1g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_hi_1g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_1g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf(" LO READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_lo_1g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_1g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_lo_1g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_1g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf(" HI READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_hi_1g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_1g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_hi_1g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_1g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf("        LO READ BACK: 0x%016llX : 0x%016llX\n",
		h2f_bridge.lo_1g_readback[0], h2f_bridge.lo_1g_readback[1]);
	printf("        HI READ BACK: 0x%016llX : 0x%016llX\n",
		h2f_bridge.hi_1g_readback[0], h2f_bridge.hi_1g_readback[1]);

	puts("\n");
	printf("    ---15GB SPAN--- :     ---PASS 1---   :     ---PASS 2---\n");

	printf("LO WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_lo_15g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_15g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_lo_15g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_15g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf("HI WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_hi_15g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_15g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_hi_15g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_15g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf(" LO READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_lo_15g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_15g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_lo_15g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_15g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf(" HI READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_hi_15g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_15g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_hi_15g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_15g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf("        LO READ BACK: 0x%016llX : 0x%016llX\n",
		h2f_bridge.lo_15g_readback[0], h2f_bridge.lo_15g_readback[1]);
	printf("        HI READ BACK: 0x%016llX : 0x%016llX\n",
		h2f_bridge.hi_15g_readback[0], h2f_bridge.hi_15g_readback[1]);

	puts("\n");
	printf("   ---240GB SPAN--- :     ---PASS 1---   :     ---PASS 2---\n");

	printf("LO WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_lo_240g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_240g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_lo_240g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_240g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf("HI WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_hi_240g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_240g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_hi_240g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_240g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf(" LO READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_lo_240g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_240g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_lo_240g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_240g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf(" HI READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_hi_240g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_240g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_hi_240g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_240g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf("        LO READ BACK: 0x%016llX : 0x%016llX\n",
		h2f_bridge.lo_240g_readback[0], h2f_bridge.lo_240g_readback[1]);
	printf("        HI READ BACK: 0x%016llX : 0x%016llX\n",
		h2f_bridge.hi_240g_readback[0], h2f_bridge.hi_240g_readback[1]);

	puts("\n");
	printf ("Press any key to exit this demo.");

	/* wait for console input */
	while (!tstc());

	/* discard the input */
	(void) getc();

	printf ("\n\n");
	return 0;
}

void do_the_interesting_thing(struct h2f_bridge_s *h2f_bridge) {

	int i;
	int j;
	uint32_t gp_in;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t *first_word_ptr[3];
	uint64_t *last_word_ptr[3];
	uint64_t first_word_write_time[3][2];
	uint64_t last_word_write_time[3][2];
	uint64_t first_word_read_time[3][2];
	uint64_t last_word_read_time[3][2];
	uint64_t first_word_write_value[3][2];
	uint64_t last_word_write_value[3][2];
	uint64_t first_word_read_value[3][2];
	uint64_t last_word_read_value[3][2];

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0;
	gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	h2f_bridge->gp_sig_value = gp_in;

	if(gp_in != H2F_SIG)
		return;

	/* validate the sysid signature */
	sysid_id = *((volatile uint32_t *)(H2F_SYSID_ID_BASE));

	h2f_bridge->sysid_id = sysid_id;

	if(sysid_id != H2F_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(H2F_SYSID_TS_BASE));
	h2f_bridge->sysid_ts = sysid_ts;

	/* initialize pointers to first and last word of spans */
	first_word_ptr[0] = (uint64_t *)(H2F_1G_BASE);
	last_word_ptr[0] = (uint64_t *)(H2F_1G_BASE + H2F_1G_SPAN -
							sizeof(uint64_t));
	first_word_ptr[1] = (uint64_t *)(H2F_15G_BASE);
	last_word_ptr[1] = (uint64_t *)(H2F_15G_BASE + H2F_15G_SPAN -
							sizeof(uint64_t));
	first_word_ptr[2] = (uint64_t *)(H2F_240G_BASE);
	last_word_ptr[2] = (uint64_t *)(H2F_240G_BASE + H2F_240G_SPAN -
							sizeof(uint64_t));

	/* initialize write data patterns */
	first_word_write_value[0][0] = 0x1111111111111111;
	 last_word_write_value[0][0] = 0x2222222222222222;
	first_word_write_value[1][0] = 0x3333333333333333;
	 last_word_write_value[1][0] = 0x4444444444444444;
	first_word_write_value[2][0] = 0x5555555555555555;
	 last_word_write_value[2][0] = 0x6666666666666666;

	first_word_write_value[0][1] = ~0x1111111111111111;
	 last_word_write_value[0][1] = ~0x2222222222222222;
	first_word_write_value[1][1] = ~0x3333333333333333;
	 last_word_write_value[1][1] = ~0x4444444444444444;
	first_word_write_value[2][1] = ~0x5555555555555555;
	 last_word_write_value[2][1] = ~0x6666666666666666;

	/* write values to first and last word of each span and read back */
	for(j = 0 ; j < 2 ; j++) {
		for(i = 0 ; i < 3 ; i++) {
			/* write to first word */
			/* mark the time */
			asm volatile (
				"mrs %[start_time], cntpct_el0\n"
				: [start_time] "=r" (start_time)
			);

			*first_word_ptr[i] = first_word_write_value[i][j];

			/* mark the time */
			asm volatile (
				"mrs %[end_time], cntpct_el0\n"
				: [end_time] "=r" (end_time)
			);

			first_word_write_time[i][j] = end_time - start_time;

			/* write to last word */
			/* mark the time */
			asm volatile (
				"mrs %[start_time], cntpct_el0\n"
				: [start_time] "=r" (start_time)
			);

			*last_word_ptr[i] = last_word_write_value[i][j];

			/* mark the time */
			asm volatile (
				"mrs %[end_time], cntpct_el0\n"
				: [end_time] "=r" (end_time)
			);

			last_word_write_time[i][j] = end_time - start_time;
		}

		for(i = 0 ; i < 3 ; i++) {
			/* read from first word */
			/* mark the time */
			asm volatile (
				"mrs %[start_time], cntpct_el0\n"
				: [start_time] "=r" (start_time)
			);

			first_word_read_value[i][j] = *first_word_ptr[i];

			/* mark the time */
			asm volatile (
				"mrs %[end_time], cntpct_el0\n"
				: [end_time] "=r" (end_time)
			);

			first_word_read_time[i][j] = end_time - start_time;

			/* read from last word */
			/* mark the time */
			asm volatile (
				"mrs %[start_time], cntpct_el0\n"
				: [start_time] "=r" (start_time)
			);

			last_word_read_value[i][j] = *last_word_ptr[i];

			/* mark the time */
			asm volatile (
				"mrs %[end_time], cntpct_el0\n"
				: [end_time] "=r" (end_time)
			);

			last_word_read_time[i][j] = end_time - start_time;
		}
	}

	/* save the results */
	for(i = 0 ; i < 2 ; i++) {
		h2f_bridge->lo_1g_readback[i] =
						first_word_read_value[0][i];
		h2f_bridge->hi_1g_readback[i] =
						last_word_read_value[0][i];
		h2f_bridge->write_lo_1g_access_time[i] =
						first_word_write_time[0][i];
		h2f_bridge->write_hi_1g_access_time[i] =
						last_word_write_time[0][i];
		h2f_bridge->read_lo_1g_access_time[i] =
						first_word_read_time[0][i];
		h2f_bridge->read_hi_1g_access_time[i] =
						last_word_read_time[0][i];

		h2f_bridge->lo_15g_readback[i] =
						first_word_read_value[1][i];
		h2f_bridge->hi_15g_readback[i] =
						last_word_read_value[1][i];
		h2f_bridge->write_lo_15g_access_time[i] =
						first_word_write_time[1][i];
		h2f_bridge->write_hi_15g_access_time[i] =
						last_word_write_time[1][i];
		h2f_bridge->read_lo_15g_access_time[i] =
						first_word_read_time[1][i];
		h2f_bridge->read_hi_15g_access_time[i] =
						last_word_read_time[1][i];

		h2f_bridge->lo_240g_readback[i] =
						first_word_read_value[2][i];
		h2f_bridge->hi_240g_readback[i] =
						last_word_read_value[2][i];
		h2f_bridge->write_lo_240g_access_time[i] =
						first_word_write_time[2][i];;
		h2f_bridge->write_hi_240g_access_time[i] =
						last_word_write_time[2][i];
		h2f_bridge->read_lo_240g_access_time[i] =
						first_word_read_time[2][i];
		h2f_bridge->read_hi_240g_access_time[i] =
						last_word_read_time[2][i];
	}
}

