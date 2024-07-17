/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct f2h_irq_s {
	uint32_t gp_sig_value;
	uint32_t gic_ispendr1_value_init;
	uint32_t gic_ispendr2_value_init;
	uint32_t gic_ispendr3_value_init;
	uint32_t gic_ispendr1_value[64];
	uint32_t gic_ispendr2_value[64];
	uint32_t gic_ispendr3_value[64];
	uint64_t gic_ispend_access_time[64];
};

void do_the_interesting_thing(struct f2h_irq_s *f2h_irq);

int f2h_irq(int argc, char *const argv[])
{
	int i;
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	struct f2h_irq_s f2h_irq = {0};

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
	do_the_interesting_thing(&f2h_irq);

	/* print the results */
	puts("\n");
	printf ("F2H IRQ Demo\n");
	puts("\n");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
					f2h_irq.gp_sig_value,
					(f2h_irq.gp_sig_value >>  0) & 0xFF,
					(f2h_irq.gp_sig_value >>  8) & 0xFF,
					(f2h_irq.gp_sig_value >> 16) & 0xFF,
					(f2h_irq.gp_sig_value >> 24) & 0xFF);
	puts("\n");

	printf("f2h_irq mappings: "
		"ISPENDR1[17]=f2s_fpga_irq0 thru "
		"ISPENDR3[16]=f2s_fpga_irq63\n");
	puts("\n");
	printf("  IDX: ISPENDR3 | ISPENDR2 | ISPENDR1 |"
		"  IDX: ISPENDR3 | ISPENDR2 | ISPENDR1 |\n");
	printf("-----+----------+----------+----------+"
		"-----+----------+----------+----------+\n");

	printf(" INIT: %08X : %08X : %08X :\n",
		f2h_irq.gic_ispendr3_value_init,
		f2h_irq.gic_ispendr2_value_init,
		f2h_irq.gic_ispendr1_value_init);

	for(i = 0 ; i < 32 ; i++) {

		/* print first column */
		printf(" %4d: %08X : %08X : %08X |",
			i,
			f2h_irq.gic_ispendr3_value[i],
			f2h_irq.gic_ispendr2_value[i],
			f2h_irq.gic_ispendr1_value[i]);

		/* print second column */
		printf(" %4d: %08X : %08X : %08X\n",
			i + 32,
			f2h_irq.gic_ispendr3_value[i + 32],
			f2h_irq.gic_ispendr2_value[i + 32],
			f2h_irq.gic_ispendr1_value[i + 32]);
	}

	puts("\n");
	puts("GIC access times in nanoseconds for each index above.\n");
	for(i = 0 ; i < 8 ; i++) {

		/* print first column */
		ns_time = (f2h_irq.gic_ispend_access_time[i] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4lld | ", i, ns_time);

		/* print second column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 8] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 8] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4lld | ", i + 8, ns_time);

		/* print third column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 16] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 16] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4lld | ", i + 16, ns_time);

		/* print fourth column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 24] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 24] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4lld | ", i + 24, ns_time);

		/* print fifth column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 32] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 32] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4lld | ", i + 32, ns_time);

		/* print sixth column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 40] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 40] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4lld | ", i + 40, ns_time);

		/* print seventh column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 48] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 48] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4lld | ", i + 48, ns_time);

		/* print eigth column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 56] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 56] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4lld |", i + 56, ns_time);

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

void do_the_interesting_thing(struct f2h_irq_s *f2h_irq) {

	int i;
	uint32_t gp_in;
	uint32_t ispendr1;
	uint32_t ispendr2;
	uint32_t ispendr3;
	uint64_t start_time;
	uint64_t end_time;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0;
	gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	f2h_irq->gp_sig_value = gp_in;

	if(gp_in != IRQ_SIG)
		return;

	ispendr1 = *((volatile uint32_t *)(GIC_ISPENDR1_BASE));
	ispendr2 = *((volatile uint32_t *)(GIC_ISPENDR2_BASE));
	ispendr3 = *((volatile uint32_t *)(GIC_ISPENDR3_BASE));

	f2h_irq->gic_ispendr1_value_init = ispendr1;
	f2h_irq->gic_ispendr2_value_init = ispendr2;
	f2h_irq->gic_ispendr3_value_init = ispendr3;

	/* verify 64-bits of the 64-bit irq vector */
	for(i = 0 ; i < 64 ; i++) {

		/* write the gp_out register */
		*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0xFFFFFFC0 | i;

		/* mark the time */
		asm volatile (
			"mrs %[start_time], cntpct_el0\n"
			: [start_time] "=r" (start_time)
		);

		/* read the gic ispendr registers */
		ispendr1 = *((volatile uint32_t *)(GIC_ISPENDR1_BASE));
		ispendr2 = *((volatile uint32_t *)(GIC_ISPENDR2_BASE));
		ispendr3 = *((volatile uint32_t *)(GIC_ISPENDR3_BASE));

		/* mark the time */
		asm volatile (
			"mrs %[end_time], cntpct_el0\n"
			: [end_time] "=r" (end_time)
		);

		/* save the results */
		f2h_irq->gic_ispend_access_time[i] = end_time - start_time;
		f2h_irq->gic_ispendr1_value[i] = ispendr1;
		f2h_irq->gic_ispendr2_value[i] = ispendr2;
		f2h_irq->gic_ispendr3_value[i] = ispendr3;
	}
}

