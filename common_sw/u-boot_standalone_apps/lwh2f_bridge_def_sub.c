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
	uint64_t start_time;
	uint64_t abort_time;
	uint64_t end_time;
};

void do_the_interesting_thing(struct lwh2f_bridge_s *lwh2f_bridge);

int lwh2f_bridge_def_sub(int argc, char *const argv[])
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
	printf ("LWH2F Default Subordinate Demo\n");
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

	printf("start time: 0x%016llX\n", lwh2f_bridge.start_time);
	printf("abort time: 0x%016llX\n", lwh2f_bridge.abort_time);
	printf("  end time: 0x%016llX\n", lwh2f_bridge.end_time);
	puts("\n");

	if(lwh2f_bridge.abort_time == 0) {

		puts("ERROR: "
			"abort handler did not execute...\n");
		puts("ERROR: "
			"default subordinate was not triggered...\n");

	} else if((lwh2f_bridge.abort_time > lwh2f_bridge.end_time) ||
		(lwh2f_bridge.abort_time < lwh2f_bridge.start_time)) {

		puts("ERROR: "
			"time sequencing is not correct...\n");
		puts("ERROR: "
			"expecting start, then abort, then end...\n");

	} else {
		puts("Abort handler did execute...\n");
		puts("Default subordinate was triggered...\n");
		puts("\n");

		/* start to abort time */
		ns_time = ((lwh2f_bridge.abort_time - lwh2f_bridge.start_time) *
						1000000000) / cntfrq_el0;
		ps_time = ((lwh2f_bridge.abort_time - lwh2f_bridge.start_time) *
						1000000000) % cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("    time from start to abort = %3lld.%03lldns\n",
							ns_time, ps_time);

		/* abort to end time */
		ns_time = ((lwh2f_bridge.end_time - lwh2f_bridge.abort_time) *
						1000000000) / cntfrq_el0;
		ps_time = ((lwh2f_bridge.end_time - lwh2f_bridge.abort_time) *
						1000000000) % cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("      time from abort to end = %3lld.%03lldns\n",
							ns_time, ps_time);

		/* start to end time */
		ns_time = ((lwh2f_bridge.end_time - lwh2f_bridge.start_time) *
						1000000000) / cntfrq_el0;
		ps_time = ((lwh2f_bridge.end_time - lwh2f_bridge.start_time) *
						1000000000) % cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("total time from start to end = %3lld.%03lldns\n",
							ns_time, ps_time);
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

void do_the_interesting_thing(struct lwh2f_bridge_s *lwh2f_bridge) {

	uint32_t gp_in;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t start_time;
	uint64_t end_time;
	volatile uint64_t *bad_word_ptr;
	uint64_t temp;
	void *current_vbar;
	void *my_vector_table;

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

	/* get the current vector table base */
	asm volatile (
		"mrs %[current_vbar], vbar_el2\n"
		: [current_vbar] "=r" (current_vbar)
	);

	/* get my vector table base */
	asm volatile (
		"adr %[my_vector_table], Vector_table_el3\n"
		: [my_vector_table] "=r" (my_vector_table)
	);

	/* zero the location for abort handler to store the system counter */
	*(uint64_t *)(my_vector_table + 8) = 0;

	/* install my vector table */
	asm volatile (
		"isb\n"
		"dsb sy\n"
		"msr vbar_el2, %[my_vector_table]\n"
		"isb\n"
		"dsb sy\n"
		:
		: [my_vector_table] "r" (my_vector_table)
	);

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* access an undecoded location in the lwh2f span */
	bad_word_ptr = (uint64_t *)(LWH2F_512M_BASE + 4096);
	temp = *bad_word_ptr;

	/*
	 * sync barrier so A76 does not read the timer before the abort event
	 * the A55 does not require this sync barrier but it doesn't hurt
	 */
	asm volatile (
		"dsb sy\n"
	);

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* restore the original vector table */
	asm volatile (
		"isb\n"
		"dsb sy\n"
		"msr vbar_el2, %[current_vbar]\n"
		"isb\n"
		"dsb sy\n"
		:
		: [current_vbar] "r" (current_vbar)
	);

	/* store the results */
	lwh2f_bridge->start_time = start_time;
	lwh2f_bridge->abort_time = *(uint64_t *)(my_vector_table + 8);
	lwh2f_bridge->end_time = end_time;
}

void my_exception_vectors(void) {

	asm volatile (
		".global Vector_table_el3\n"
		".balign 0x800\n"
		"Vector_table_el3:\n"
		"curr_el_sp0_sync:\n"
			"bl curr_el_sp0_sync\n"
		".balign 0x80\n"
		"curr_el_sp0_irq:\n"
			"bl curr_el_sp0_irq\n"
		".balign 0x80\n"
		"curr_el_sp0_fiq:\n"
			"bl curr_el_sp0_fiq\n"
		".balign 0x80\n"
		"curr_el_sp0_serror:\n"
			"bl curr_el_sp0_serror\n"
		".balign 0x80\n"
		"curr_el_spx_sync:\n"	// this will be executed on Cortex A55
			"stp x0, x1, [sp, #-16]!\n"
			"mrs x0, elr_el2\n"
			"add x0, x0, #4\n"
			"msr elr_el2, x0\n"
			"adr x0, Vector_table_el3\n"
			"mrs x1, cntpct_el0\n"
			"str x1, [x0, #8]!\n"
			"ldp x0, x1, [sp], #16\n"
			"eret\n"
		".balign 0x80\n"
		"curr_el_spx_irq:\n"
			"bl curr_el_spx_irq\n"
		".balign 0x80\n"
		"curr_el_spx_fiq:\n"
			"bl curr_el_spx_fiq\n"
		".balign 0x80\n"
		"curr_el_spx_serror:\n"	// this will be executed on Cortex A76
			"stp x0, x1, [sp, #-16]!\n"
			"mrs x0, elr_el2\n"
			"add x0, x0, #4\n"
			"msr elr_el2, x0\n"
			"adr x0, Vector_table_el3\n"
			"mrs x1, cntpct_el0\n"
			"str x1, [x0, #8]!\n"
			"ldp x0, x1, [sp], #16\n"
			"eret\n"
		".balign 0x80\n"
		"lower_el_aarch64_sync:\n"
			"bl lower_el_aarch64_sync\n"
		".balign 0x80\n"
		"lower_el_aarch64_irq:\n"
			"bl lower_el_aarch64_irq\n"
		".balign 0x80\n"
		"lower_el_aarch64_fiq:\n"
			"bl lower_el_aarch64_fiq\n"
		".balign 0x80\n"
		"lower_el_aarch64_serror:\n"
			"bl lower_el_aarch64_serror\n"
		".balign 0x80\n"
		"lower_el_aarch32_sync:\n"
			"bl lower_el_aarch32_sync\n"
		".balign 0x80\n"
		"lower_el_aarch32_irq:\n"
			"bl lower_el_aarch32_irq\n"
		".balign 0x80\n"
		"lower_el_aarch32_fiq:\n"
			"bl lower_el_aarch32_fiq\n"
		".balign 0x80\n"
		"lower_el_aarch32_serror:\n"
			"bl lower_el_aarch32_serror\n"
	);
}

