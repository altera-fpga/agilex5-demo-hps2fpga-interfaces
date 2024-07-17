/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct results_s {
	uint64_t cntpct_el0;
	uint64_t cntfrq_el0;
	uint64_t midr_el1;
	uint64_t mpidr_el1;
	uint64_t revidr_el1;
	uint64_t currentel;
	uint64_t daif;
};

void do_the_interesting_thing(struct results_s *);

int armv8_regs(int argc, char *const argv[])
{
	struct results_s results;
	uint64_t cntpct_copy;
	uint64_t days;
	uint64_t hours;
	uint64_t minutes;
	uint64_t seconds;
	uint64_t milliseconds;
	uint64_t microseconds;
	uint64_t nanoseconds;

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
	printf ("Armv8 Registers Demo - Current CPU Status\n");
	puts("\n");
	printf("    CNTFRQ_EL0 = 0x%016llX", results.cntfrq_el0);
	printf("        CNTPCT_EL0 = 0x%016llX\n", results.cntpct_el0);
	printf("      MIDR_EL1 = 0x%016llX", results.midr_el1);
	printf("         MPIDR_EL1 = 0x%016llX\n", results.mpidr_el1);
	printf("    REVIDR_EL1 = 0x%016llX", results.revidr_el1);
	printf("         CURRENTEL = 0x%016llX\n", results.currentel);
	printf("          DAIF = 0x%016llX\n", results.daif);

	puts("\n");
	printf("CNTFRQ_EL0 shows system counter frequency:\n");
	printf("  %lld HZ\n", results.cntfrq_el0);

	puts("\n");
	puts("CNTPCT_EL0 shows current system counter value:\n");
	cntpct_copy = results.cntpct_el0;
	seconds = cntpct_copy / results.cntfrq_el0;
	days = seconds / (60 * 60 * 24);
	seconds = seconds % (60 * 60 * 24);
	hours = seconds / (60 * 60);
	seconds = seconds % (60 * 60);
	minutes = seconds / 60;
	seconds = seconds % 60;
	cntpct_copy %= results.cntfrq_el0;
	cntpct_copy *= 1000;
	milliseconds = cntpct_copy / results.cntfrq_el0;
	cntpct_copy %= results.cntfrq_el0;
	cntpct_copy *= 1000;
	microseconds = cntpct_copy / results.cntfrq_el0;
	cntpct_copy %= results.cntfrq_el0;
	cntpct_copy *= 1000;
	nanoseconds = cntpct_copy / results.cntfrq_el0;
	printf("  %04lldd'%02lldh'%02lldm'%02llds'%03lldms'%03lldus'%03lldns\n",
	days, hours, minutes, seconds, milliseconds, microseconds, nanoseconds);

	puts("\n");
	puts("MIDR_EL1 shows core identification information:\n");
	if (((results.midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A55_VAL)
		puts("  Indicates a Cortex A55 ");
	else if (((results.midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A76_VAL)
		puts("  Indicates a Cortex A76 ");
	else
		puts("  Indicates an UNKNOWN ");

	printf("r%lldp%lld core\n",
		(results.midr_el1 & MIDR_EL1_VAR_MASK) >> MIDR_EL1_VAR_OFST,
		(results.midr_el1 & MIDR_EL1_REV_MASK) >> MIDR_EL1_REV_OFST);

	printf("        Implementer = 0x%02llX",
		(results.midr_el1 & MIDR_EL1_IMP_MASK) >> MIDR_EL1_IMP_OFST);
	printf("      Variant = 0x%01llX",
		(results.midr_el1 & MIDR_EL1_VAR_MASK) >> MIDR_EL1_VAR_OFST);
	printf("    Architecture = 0x%01llX\n",
		(results.midr_el1 & MIDR_EL1_ARCH_MASK) >> MIDR_EL1_ARCH_OFST);
	printf("            PartNum = 0x%03llX",
		(results.midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST);
	printf("    Revision = 0x%01llX\n",
		(results.midr_el1 & MIDR_EL1_REV_MASK) >> MIDR_EL1_REV_OFST);

	puts("\n");
	puts("MPIDR_EL1 shows core affinity information:\n");
	printf("  Running on core %lld\n",
		(results.mpidr_el1 & MPIDR_EL1_AFF1_MASK) >>
							MPIDR_EL1_AFF1_OFST);

	puts("\n");
	puts("REVIDR_EL1 shows an implementation specific value.\n");

	puts("\n");
	puts("CURRENTEL shows the current exception level for this core:\n");
	printf("  Current Exception Level is EL%lld\n",
		( results.currentel & CURRENTEL_MASK ) >> CURRENTEL_OFST);

	puts("\n");
	puts("DAIF shows the current interrupt mask values:\n");
	printf("  D:%s masked    A:%s masked    I:%s masked    F:%s masked\n",
		(results.daif & DAIF_D_MASK) ? "" : " NOT",
		(results.daif & DAIF_A_MASK) ? "" : " NOT",
		(results.daif & DAIF_I_MASK) ? "" : " NOT",
		(results.daif & DAIF_F_MASK) ? "" : " NOT");

	puts("\n");
	puts("HPS clocks:\n");
	printf("        MPU CLOCK = %ld HZ", cm_get_mpu_clk_hz());
	printf("        L4 SYS FREE CLOCK = %d HZ\n", cm_get_l4_sys_free_clk_hz());

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

	uint64_t cntpct_el0;
	uint64_t cntfrq_el0;
	uint64_t midr_el1;
	uint64_t mpidr_el1;
	uint64_t revidr_el1;
	uint64_t currentel;
	uint64_t daif;

	/* read the registers of interest */
	asm volatile (
		"mrs %[cntpct_el0], cntpct_el0\n"
		: [cntpct_el0] "=r" (cntpct_el0)
	);

	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	asm volatile (
		"mrs %[midr_el1], midr_el1\n"
		: [midr_el1] "=r" (midr_el1)
	);

	asm volatile (
		"mrs %[mpidr_el1], mpidr_el1\n"
		: [mpidr_el1] "=r" (mpidr_el1)
	);

	asm volatile (
		"mrs %[revidr_el1], revidr_el1\n"
		: [revidr_el1] "=r" (revidr_el1)
	);

	asm volatile (
		"mrs %[currentel], currentel\n"
		: [currentel] "=r" (currentel)
	);

	asm volatile (
		"mrs %[daif], daif\n"
		: [daif] "=r" (daif)
	);

	/* save the results */
	results->cntpct_el0 = cntpct_el0;
	results->cntfrq_el0 = cntfrq_el0;
	results->midr_el1   = midr_el1;
	results->mpidr_el1  = mpidr_el1;
	results->revidr_el1 = revidr_el1;
	results->currentel  = currentel;
	results->daif       = daif;
}

