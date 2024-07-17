/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct lwh2f_bridge_s {
	uint32_t gp_sig_value;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t lo_512m_readback[2];
	uint64_t hi_512m_readback[2];
	uint64_t write_lo_512m_access_time[2];
	uint64_t write_hi_512m_access_time[2];
	uint64_t read_lo_512m_access_time[2];
	uint64_t read_hi_512m_access_time[2];
};

void do_the_interesting_thing(struct lwh2f_bridge_s *lwh2f_bridge);

int lwh2f_bridge(int argc, char *const argv[])
{
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	struct lwh2f_bridge_s lwh2f_bridge = {0};

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
	do_the_interesting_thing(&lwh2f_bridge);

	/* print the results */
	puts("\n");
	printf ("LWH2F Demo\n");
	puts("\n");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
				lwh2f_bridge.gp_sig_value,
				(lwh2f_bridge.gp_sig_value >>  0) & 0xFF,
				(lwh2f_bridge.gp_sig_value >>  8) & 0xFF,
				(lwh2f_bridge.gp_sig_value >> 16) & 0xFF,
				(lwh2f_bridge.gp_sig_value >> 24) & 0xFF);
	puts("\n");

	printf("SYSID_ID: 0x%08X\n", lwh2f_bridge.sysid_id);
	printf("SYSID_TS: 0x%08X\n", lwh2f_bridge.sysid_ts);

	puts("\n");
	printf("   ---512MB SPAN--- :     ---PASS 1---   :     ---PASS 2---\n");

	printf("LO WRITE ACCESS TIME:");
	ns_time = (lwh2f_bridge.write_lo_512m_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.write_lo_512m_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (lwh2f_bridge.write_lo_512m_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.write_lo_512m_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf("HI WRITE ACCESS TIME:");
	ns_time = (lwh2f_bridge.write_hi_512m_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.write_hi_512m_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (lwh2f_bridge.write_hi_512m_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.write_hi_512m_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf(" LO READ ACCESS TIME:");
	ns_time = (lwh2f_bridge.read_lo_512m_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.read_lo_512m_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (lwh2f_bridge.read_lo_512m_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.read_lo_512m_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf(" HI READ ACCESS TIME:");
	ns_time = (lwh2f_bridge.read_hi_512m_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.read_hi_512m_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns :", ns_time, ps_time);

	ns_time = (lwh2f_bridge.read_hi_512m_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.read_hi_512m_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6lld.%03lldns\n", ns_time, ps_time);

	printf("        LO READ BACK: 0x%016llX : 0x%016llX\n",
					lwh2f_bridge.lo_512m_readback[0],
					lwh2f_bridge.lo_512m_readback[1]);
	printf("        HI READ BACK: 0x%016llX : 0x%016llX\n",
					lwh2f_bridge.hi_512m_readback[0],
					lwh2f_bridge.hi_512m_readback[1]);

	puts("\n");
	printf ("Press any key to exit this demo.");

	/* wait for console input */
	while (!tstc());

	/* discard the input */
	(void) getc();

	printf ("\n\n");
	return 0;
}

void do_the_interesting_thing(struct lwh2f_bridge_s *lwh2f_bridge) {

	uint32_t gp_in;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t *first_word_ptr;
	uint64_t *last_word_ptr;
	uint64_t temp;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0;
	gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	lwh2f_bridge->gp_sig_value = gp_in;

	if(gp_in != LWH2_SIG)
		return;

	/* validate the sysid signature */
	sysid_id = *((volatile uint32_t *)(LWH2F_SYSID_ID_BASE));

	lwh2f_bridge->sysid_id = sysid_id;

	if(sysid_id != LWH2_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(LWH2F_SYSID_TS_BASE));
	lwh2f_bridge->sysid_ts = sysid_ts;

	/* write and read the memories in the FPGA fabric */
	first_word_ptr = (uint64_t *)(LWH2F_512M_BASE);
	last_word_ptr = (uint64_t *)(LWH2F_512M_BASE + LWH2F_512M_SPAN -
							sizeof(uint64_t));

/* write to first word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	*first_word_ptr = 0x1111111111111111;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->write_lo_512m_access_time[0] = end_time - start_time;

/* write to last word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	*last_word_ptr = 0x2222222222222222;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->write_hi_512m_access_time[0] = end_time - start_time;

/* read from first word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	temp = *first_word_ptr;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->read_lo_512m_access_time[0] = end_time - start_time;
	lwh2f_bridge->lo_512m_readback[0] = temp;

/* read from last word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	temp = *last_word_ptr;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->read_hi_512m_access_time[0] = end_time - start_time;
	lwh2f_bridge->hi_512m_readback[0] = temp;

/* change the patterns and do it again */
/* write to first word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	*first_word_ptr = ~0x1111111111111111;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->write_lo_512m_access_time[1] = end_time - start_time;

/* write to last word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	*last_word_ptr = ~0x2222222222222222;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->write_hi_512m_access_time[1] = end_time - start_time;

/* read from first word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	temp = *first_word_ptr;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->read_lo_512m_access_time[1] = end_time - start_time;
	lwh2f_bridge->lo_512m_readback[1] = temp;

/* read from last word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	temp = *last_word_ptr;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->read_hi_512m_access_time[1] = end_time - start_time;
	lwh2f_bridge->hi_512m_readback[1] = temp;
}

