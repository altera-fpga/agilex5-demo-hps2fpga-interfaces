/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct results_s {
	uint32_t clidr_el1;
	uint32_t ccsidr_el1_l1i;
	uint32_t ccsidr_el1_l1d;
	uint32_t ccsidr_el1_l2d;
	uint32_t ccsidr_el1_l3d;
};

void do_the_interesting_thing(struct results_s *);

int cache_regs(int argc, char *const argv[])
{
	int i;
	int column;
	struct results_s results;
	uint32_t temp1;
	uint32_t temp2;

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
	printf ("Cache Registers Demo - Current Cache Sizes\n");
	puts("\n");
	printf("         CLIDR_EL1 = 0x%08X\n", results.clidr_el1);
	printf("    L1I-CCSIDR_EL1 = 0x%08X\n", results.ccsidr_el1_l1i);
	printf("    L1D-CCSIDR_EL1 = 0x%08X\n", results.ccsidr_el1_l1d);
	printf("    L2D-CCSIDR_EL1 = 0x%08X\n", results.ccsidr_el1_l2d);
	printf("    L3D-CCSIDR_EL1 = 0x%08X\n", results.ccsidr_el1_l3d);

	puts("\n");
	puts("CLIDR Details:\n");
	printf("  L1 cache type: 0x%02X    ",
		(results.clidr_el1 & CLIDR_CTYPE1_MASK) >> CLIDR_CTYPE1_OFST);
	printf("Level of Unification Inner Shareable: 0x%02X\n",
		(results.clidr_el1 & CLIDR_LOUIS_MASK) >> CLIDR_LOUIS_OFST);
	printf("  L2 cache type: 0x%02X    ",
		(results.clidr_el1 & CLIDR_CTYPE2_MASK) >> CLIDR_CTYPE2_OFST);
	printf("                  Level of Coherency: 0x%02X\n",
		(results.clidr_el1 & CLIDR_LOC_MASK) >> CLIDR_LOC_OFST);
	printf("  L3 cache type: 0x%02X    ",
		(results.clidr_el1 & CLIDR_CTYPE3_MASK) >> CLIDR_CTYPE3_OFST);
	printf("   Level of Unification Uniprocessor: 0x%02X\n",
		(results.clidr_el1 & CLIDR_LOUU_MASK) >> CLIDR_LOUU_OFST);
	puts("                         ");
	printf("                Inner Cache Boundary: 0x%02X\n",
		(results.clidr_el1 & CLIDR_ICB_MASK) >> CLIDR_ICB_OFST);

	for(i = 0 ; i < 2 ; i++) {
		switch(i) {
		case(0) :
			puts("\n");
			column = printf("L1 Instruction Cache Details:");
			temp1 = results.ccsidr_el1_l1i;
			printf("%*s", 40 - column, " ");
			puts("L1 Data Cache Details:\n");
			temp2 = results.ccsidr_el1_l1d;
			break;
		case(1) :
			puts("\n");
			puts("L2 Data Cache Details:");
			temp1 = results.ccsidr_el1_l2d;
			printf("%*s", 40 - column, " ");
			puts("L3 Data Cache Details:\n");
			temp2 = results.ccsidr_el1_l3d;
			break;
		}

		column = printf("          FLAGS: %s|%s|%s|%s",
			(temp1 & CCSIDR_WT_MASK) ? "WT" : "wt",
			(temp1 & CCSIDR_WB_MASK) ? "WB" : "wb",
			(temp1 & CCSIDR_RA_MASK) ? "RA" : "ra",
			(temp1 & CCSIDR_WA_MASK) ? "WA" : "wa");
		printf("%*s", 40 - column, " ");
		printf("          FLAGS: %s|%s|%s|%s\n",
			(temp2 & CCSIDR_WT_MASK) ? "WT" : "wt",
			(temp2 & CCSIDR_WB_MASK) ? "WB" : "wb",
			(temp2 & CCSIDR_RA_MASK) ? "RA" : "ra",
			(temp2 & CCSIDR_WA_MASK) ? "WA" : "wa");

		column = printf("           SETS: 0x%04X | %d sets",
			(temp1 & CCSIDR_SETS_MASK) >> CCSIDR_SETS_OFST,
			CACHE_SETS((temp1 & CCSIDR_SETS_MASK) >>
							CCSIDR_SETS_OFST));
		printf("%*s", 40 - column, " ");
		printf("           SETS: 0x%04X | %d sets\n",
			(temp2 & CCSIDR_SETS_MASK) >> CCSIDR_SETS_OFST,
			CACHE_SETS((temp2 & CCSIDR_SETS_MASK) >>
							CCSIDR_SETS_OFST));

		column = printf("  ASSOCIATIVITY: 0x%04X | %d ways",
			(temp1 & CCSIDR_ASSOC_MASK) >> CCSIDR_ASSOC_OFST,
			CACHE_ASSOC((temp1 & CCSIDR_ASSOC_MASK) >>
							CCSIDR_ASSOC_OFST));
		printf("%*s", 40 - column, " ");
		printf("  ASSOCIATIVITY: 0x%04X | %d ways\n",
			(temp2 & CCSIDR_ASSOC_MASK) >> CCSIDR_ASSOC_OFST,
			CACHE_ASSOC((temp2 & CCSIDR_ASSOC_MASK) >>
							CCSIDR_ASSOC_OFST));

		column = printf("      LINE SIZE: 0x%04X | %d bytes",
			(temp1 & CCSIDR_LINE_SIZE_MASK) >> CCSIDR_LINE_SIZE_OFST,
			CACHE_LINE_SIZE((temp1 & CCSIDR_LINE_SIZE_MASK) >>
							CCSIDR_LINE_SIZE_OFST));
		printf("%*s", 40 - column, " ");
		printf("      LINE SIZE: 0x%04X | %d bytes\n",
			(temp2 & CCSIDR_LINE_SIZE_MASK) >> CCSIDR_LINE_SIZE_OFST,
			CACHE_LINE_SIZE((temp2 & CCSIDR_LINE_SIZE_MASK) >>
							CCSIDR_LINE_SIZE_OFST));

		column = printf("     CACHE SIZE: %d KB",
			(
			CACHE_SETS((temp1 & CCSIDR_SETS_MASK) >>
							CCSIDR_SETS_OFST) *
			CACHE_ASSOC((temp1 & CCSIDR_ASSOC_MASK) >>
							CCSIDR_ASSOC_OFST) *
			CACHE_LINE_SIZE((temp1 & CCSIDR_LINE_SIZE_MASK) >>
							CCSIDR_LINE_SIZE_OFST)
			) / 1024);
		printf("%*s", 40 - column, " ");
		printf("     CACHE SIZE: %d KB\n",
			(
			CACHE_SETS((temp2 & CCSIDR_SETS_MASK) >>
							CCSIDR_SETS_OFST) *
			CACHE_ASSOC((temp2 & CCSIDR_ASSOC_MASK) >>
							CCSIDR_ASSOC_OFST) *
			CACHE_LINE_SIZE((temp2 & CCSIDR_LINE_SIZE_MASK) >>
							CCSIDR_LINE_SIZE_OFST)
			) / 1024);
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

	uint32_t csselr_el1;
	uint32_t clidr_el1;
	uint32_t ccsidr_el1_l1i;
	uint32_t ccsidr_el1_l1d;
	uint32_t ccsidr_el1_l2d;
	uint32_t ccsidr_el1_l3d;

	/* read the cache registers */
	asm volatile (
		"mrs %[clidr_el1], clidr_el1\n"
		: [clidr_el1] "=r" (clidr_el1)
	);

	/* select l1 instruction cache */
	csselr_el1 = 0x00000001;
	asm volatile (
		"msr csselr_el1, %[csselr_el1]\n"
		:
		: [csselr_el1] "r" (csselr_el1)
	);
	asm volatile (
		"mrs %[ccsidr_el1_l1i], ccsidr_el1\n"
		: [ccsidr_el1_l1i] "=r" (ccsidr_el1_l1i)
	);

	/* select l1 data cache */
	csselr_el1 = 0x00000000;
	asm volatile (
		"msr csselr_el1, %[csselr_el1]\n"
		:
		: [csselr_el1] "r" (csselr_el1)
	);
	asm volatile (
		"mrs %[ccsidr_el1_l1d], ccsidr_el1\n"
		: [ccsidr_el1_l1d] "=r" (ccsidr_el1_l1d)
	);

	/* select l2 data cache */
	csselr_el1 = 0x00000002;
	asm volatile (
		"msr csselr_el1, %[csselr_el1]\n"
		:
		: [csselr_el1] "r" (csselr_el1)
	);
	asm volatile (
		"mrs %[ccsidr_el1_l2d], ccsidr_el1\n"
		: [ccsidr_el1_l2d] "=r" (ccsidr_el1_l2d)
	);

	/* select l3 data cache */
	csselr_el1 = 0x00000004;
	asm volatile (
		"msr csselr_el1, %[csselr_el1]\n"
		:
		: [csselr_el1] "r" (csselr_el1)
	);
	asm volatile (
		"mrs %[ccsidr_el1_l3d], ccsidr_el1\n"
		: [ccsidr_el1_l3d] "=r" (ccsidr_el1_l3d)
	);

	/* save the results */
	results->clidr_el1 = clidr_el1;
	results->ccsidr_el1_l1i = ccsidr_el1_l1i;
	results->ccsidr_el1_l1d = ccsidr_el1_l1d;
	results->ccsidr_el1_l2d = ccsidr_el1_l2d;
	results->ccsidr_el1_l3d = ccsidr_el1_l3d;
}

