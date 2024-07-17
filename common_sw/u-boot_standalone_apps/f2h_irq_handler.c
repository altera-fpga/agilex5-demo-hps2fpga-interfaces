/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct f2h_irq_hndlr_s {
	uint32_t gp_sig_value;
	uint64_t to_irq_time[64];
	uint64_t from_irq_time[64];
	uint64_t irq_id[64];
};

void do_the_interesting_thing(struct f2h_irq_hndlr_s *f2h_irq_hndlr);

int f2h_irq_handler(int argc, char *const argv[])
{
	int i;
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	struct f2h_irq_hndlr_s f2h_irq_hndlr = {0};

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
	do_the_interesting_thing(&f2h_irq_hndlr);

	/* print the results */
	puts("\n");
	printf ("F2H IRQ Handler Demo\n");
	puts("\n");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
				f2h_irq_hndlr.gp_sig_value,
				(f2h_irq_hndlr.gp_sig_value >>  0) & 0xFF,
				(f2h_irq_hndlr.gp_sig_value >>  8) & 0xFF,
				(f2h_irq_hndlr.gp_sig_value >> 16) & 0xFF,
				(f2h_irq_hndlr.gp_sig_value >> 24) & 0xFF);
	puts("\n");

	puts("  FPGA :  TIME TO  : TIME FROM :  GIC  ");
	puts("   FPGA :  TIME TO  : TIME FROM :  GIC");
	puts("\n");
	puts("  IRQ  :    ISR    :    ISR    : INTID ");
	puts("   IRQ  :    ISR    :    ISR    : INTID");
	puts("\n");
	puts(" ------+-----------+-----------+-------");
	puts("  ------+-----------+-----------+-------");
	puts("\n");

	for(i = 0 ; i < 32 ; i++ ) {
		/* column one */
		printf("    %2d :", i);
		ns_time = (f2h_irq_hndlr.to_irq_time[i] * 1000000000)
								/ cntfrq_el0;
		printf(" %6lld ns :", ns_time);

		ns_time = (f2h_irq_hndlr.from_irq_time[i] * 1000000000)
								/ cntfrq_el0;
		printf(" %6lld ns :", ns_time);

		printf("  %4llu ", f2h_irq_hndlr.irq_id[i]);

		/* column two */
		printf("     %2d :", i + 32);
		ns_time = (f2h_irq_hndlr.to_irq_time[i + 32] * 1000000000)
								/ cntfrq_el0;
		printf(" %6lld ns :", ns_time);

		ns_time = (f2h_irq_hndlr.from_irq_time[i + 32] * 1000000000)
								/ cntfrq_el0;
		printf(" %6lld ns :", ns_time);

		printf("  %4llu", f2h_irq_hndlr.irq_id[i + 32]);

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

void do_the_interesting_thing(struct f2h_irq_hndlr_s *f2h_irq_hndlr) {

	int      i;
	uint32_t gp_in;
	uint32_t orig_gicd_ctlr;
	uint32_t my_gicd_ctlr;
	uint64_t orig_icc_igrpen1_el1;
	uint64_t my_icc_igrpen1_el1;
	uint64_t orig_hcr_el2;
	uint64_t my_hcr_el2;
	uint64_t orig_daif;
	uint64_t my_daif;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t temp_time;
	void     *orig_vbar;
	void     *my_vector_table;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0;
	gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	f2h_irq_hndlr->gp_sig_value = gp_in;

	if(gp_in != IRQ_SIG)
		return;

	/* acquire the cntfrq_el0 to create timeout counts  later */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* set the TGE bit in hcr_el2 */
    	asm volatile (
		"mrs %[orig_hcr_el2], hcr_el2\n"
		: [orig_hcr_el2] "=r" (orig_hcr_el2)
	);
	my_hcr_el2 = orig_hcr_el2 | (1 << 27);
    	asm volatile (
		"msr hcr_el2, %[my_hcr_el2]\n"
		:
		: [my_hcr_el2] "r" (my_hcr_el2)
	);

	/* enable group 1 non-secure interrupts in the GID distributor */
	orig_gicd_ctlr = *((volatile uint32_t *)(GICD_CTLR_BASE));
	my_gicd_ctlr = orig_gicd_ctlr | GICD_CTLR_EN_GRP1NS;
	*((volatile uint32_t *)(GICD_CTLR_BASE)) = my_gicd_ctlr;

	/* enable group 1 interrupts in the CPU interface */
    	asm volatile (
		"mrs %[orig_icc_igrpen1_el1], S3_0_C12_C12_7\n"
		: [orig_icc_igrpen1_el1] "=r" (orig_icc_igrpen1_el1)
	);
	my_icc_igrpen1_el1 = orig_icc_igrpen1_el1 | 0x01;
    	asm volatile (
		"msr S3_0_C12_C12_7, %[my_icc_igrpen1_el1]\n"
		:
		: [my_icc_igrpen1_el1] "r" (my_icc_igrpen1_el1)
	);

	/* enable our interrupts in the distributor */
	*((volatile uint32_t *)(GICD_ISENABLER1_BASE)) = 0xFFFE0000;
	*((volatile uint32_t *)(GICD_ISENABLER2_BASE)) = 0xFFFFFFFF;
	*((volatile uint32_t *)(GICD_ISENABLER3_BASE)) = 0x0001FFFF;

	/* clear the CPU interrupt mask */
    	asm volatile (
		"mrs %[orig_daif], daif\n"
		: [orig_daif] "=r" (orig_daif)
	);
	my_daif = orig_daif & ~DAIF_I_MASK;
    	asm volatile (
		"msr daif, %[my_daif]\n"
		:
		: [my_daif] "r" (my_daif)
	);

	/* get the current vector table base */
	asm volatile (
		"mrs %[orig_vbar], vbar_el2\n"
		: [orig_vbar] "=r" (orig_vbar)
	);

	/* get my vector table base */
	asm volatile (
		"adr %[my_vector_table], Vector_table_el3\n"
		: [my_vector_table] "=r" (my_vector_table)
	);

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

	for(i = 0 ; i < 64 ; i++) {

		/* zero the locations for irq handler to store results */
		*(volatile uint64_t *)(my_vector_table + 8) = 0;
		*(volatile uint64_t *)(my_vector_table + 16) = 0;

		/* mark the time */
		asm volatile (
			"dsb sy\n"
			"mrs %[start_time], cntpct_el0\n"
			: [start_time] "=r" (start_time)
		);

		/* trigger interrupt */
		*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0xFFFFFFC0 | i;

		end_time = start_time + (cntfrq_el0 / 1000);
		while(*((volatile uint32_t *)(HPS_GP_OUT_BASE)) != 0) {
			asm volatile (
				"mrs %[temp_time], cntpct_el0\n"
				: [temp_time] "=r" (temp_time)
			);
			if(temp_time > end_time)
				break;
		}

		/* mark the time */
		asm volatile (
			"dsb sy\n"
			"mrs %[end_time], cntpct_el0\n"
			: [end_time] "=r" (end_time)
		);

		/* store the results */
		temp_time = *(volatile uint64_t *)(my_vector_table + 8);
		f2h_irq_hndlr->to_irq_time[i] = temp_time - start_time;
		f2h_irq_hndlr->from_irq_time[i] = end_time - temp_time;
		f2h_irq_hndlr->irq_id[i] =
				*(volatile uint64_t *)(my_vector_table + 16);
	}

	/* restore the original vector table */
	asm volatile (
		"isb\n"
		"dsb sy\n"
		"msr vbar_el2, %[orig_vbar]\n"
		"isb\n"
		"dsb sy\n"
		:
		: [orig_vbar] "r" (orig_vbar)
	);

	/* restore the original CPU interrupt mask */
    	asm volatile (
		"msr daif, %[orig_daif]\n"
		:
		: [orig_daif] "r" (orig_daif)
	);

	/* disable our interrupts in the distributor */
	*((volatile uint32_t *)(GICD_ICENABLER1_BASE)) = 0xFFFE0000;
	*((volatile uint32_t *)(GICD_ICENABLER2_BASE)) = 0xFFFFFFFF;
	*((volatile uint32_t *)(GICD_ICENABLER3_BASE)) = 0x0001FFFF;

	/* restore the original icc_igrpen1_el1 */
    	asm volatile (
		"msr S3_0_C12_C12_7, %[orig_icc_igrpen1_el1]\n"
		:
		: [orig_icc_igrpen1_el1] "r" (orig_icc_igrpen1_el1)
	);

	/* restore the original gicd_ctlr */
	*((volatile uint32_t *)(GICD_CTLR_BASE)) = orig_gicd_ctlr;

	/* restore the original hcr_el2 */
    	asm volatile (
		"msr hcr_el2, %[orig_hcr_el2]\n"
		:
		: [orig_hcr_el2] "r" (orig_hcr_el2)
	);
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
		"curr_el_spx_sync:\n"
			"bl curr_el_spx_sync\n"
		".balign 0x80\n"
		"curr_el_spx_irq:\n"
			"stp x0, x1, [sp, #-16]!\n"
			"adr x0, Vector_table_el3\n"
			"mrs x1, cntpct_el0\n"
			"str x1, [x0, #8]!\n"
			"mrs x1, S3_0_C12_C12_0\n" // icc_iar1_el1
			"str x1, [x0, #8]!\n"
			"ldr x0, =0x10D120E4\n"
			"str wzr, [x0]\n"
			"isb\n"
			"dsb sy\n"
			"msr S3_0_C12_C12_1, x1\n" // icc_eoir1_el1
			"ldp x0, x1, [sp], #16\n"
			"eret\n"
		".balign 0x80\n"
		"curr_el_spx_fiq:\n"
			"bl curr_el_spx_fiq\n"
		".balign 0x80\n"
		"curr_el_spx_serror:\n"
			"bl curr_el_spx_serror\n"
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

