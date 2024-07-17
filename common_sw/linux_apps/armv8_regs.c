/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <termios.h>
#include <sched.h>
#include "standalone_common.h"

struct results_s {
	uint64_t cpu0_cntvct_el0;
	uint64_t cpu0_cntfrq_el0;
	uint64_t cpu0_midr_el1;
	uint64_t cpu0_revidr_el1;
	uint64_t cpu1_midr_el1;
	uint64_t cpu2_midr_el1;
	uint64_t cpu3_midr_el1;
};

void do_the_interesting_thing(struct results_s *);

int main(void)
{
	char c;
	int result;
	int the_fd;
	char *next_app_name;
	ssize_t next_app_name_len;
	struct results_s results;
	uint64_t cntpct_copy;
	uint64_t days;
	uint64_t hours;
	uint64_t minutes;
	uint64_t seconds;
	uint64_t milliseconds;
	uint64_t microseconds;
	uint64_t nanoseconds;
	struct termios orig_attr;
	struct termios new_attr;

	/* set NEXTPROG file to run boot_app upon our exit */
	the_fd = open("/NEXTPROG", O_WRONLY | O_TRUNC | O_CREAT,
		S_IRWXU | S_IRUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
	if(the_fd < 0) {
		puts("ERROR: opening NEXTPROG file");
		return 1;
	}
	next_app_name = "boot_app";
	next_app_name_len = strnlen(next_app_name, 32);
	result = write(the_fd, next_app_name, next_app_name_len);
	if((result < 0) || (result != next_app_name_len)) {
		puts("ERROR: writing NEXTPROG file");
		return 1;
	}
	result = close(the_fd);
	if(result < 0) {
		puts("ERROR: closing NEXTPROG file");
		return 1;
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&results);

	/* print the results */
	puts("");
	printf ("Armv8 Registers Demo - Current CPU Status\n");
	puts("");
	printf(" CPU0 MIDR_EL1 = 0x%016lX :", results.cpu0_midr_el1);
	if (((results.cpu0_midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A55_VAL)
		printf("  Cortex A55\n");
	else if (((results.cpu0_midr_el1 & MIDR_EL1_PN_MASK) >>
					MIDR_EL1_PN_OFST) == MIDR_EL1_A76_VAL)
		printf("  Cortex A76\n");
	else
		printf("  UNKNOWN\n");
	printf(" CPU1 MIDR_EL1 = 0x%016lX :", results.cpu1_midr_el1);
	if (((results.cpu1_midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A55_VAL)
		printf("  Cortex A55\n");
	else if (((results.cpu1_midr_el1 & MIDR_EL1_PN_MASK) >>
					MIDR_EL1_PN_OFST) == MIDR_EL1_A76_VAL)
		printf("  Cortex A76\n");
	else
		printf("  UNKNOWN \n");
	printf(" CPU2 MIDR_EL1 = 0x%016lX :", results.cpu2_midr_el1);
	if (((results.cpu2_midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A55_VAL)
		printf("  Cortex A55\n");
	else if (((results.cpu2_midr_el1 & MIDR_EL1_PN_MASK) >>
					MIDR_EL1_PN_OFST) == MIDR_EL1_A76_VAL)
		printf("  Cortex A76\n");
	else
		printf("  UNKNOWN\n");
	printf(" CPU3 MIDR_EL1 = 0x%016lX :", results.cpu3_midr_el1);
	if (((results.cpu3_midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A55_VAL)
		printf("  Cortex A55\n");
	else if (((results.cpu3_midr_el1 & MIDR_EL1_PN_MASK) >>
					MIDR_EL1_PN_OFST) == MIDR_EL1_A76_VAL)
		printf("  Cortex A76\n");
	else
		printf("  UNKNOWN\n");
	puts("");
	printf("CPU0 register details:\n");
	printf("    CNTFRQ_EL0 = 0x%016lX", results.cpu0_cntfrq_el0);
	printf("        CNTVCT_EL0 = 0x%016lX\n", results.cpu0_cntvct_el0);
	printf("      MIDR_EL1 = 0x%016lX", results.cpu0_midr_el1);
	printf("        REVIDR_EL1 = 0x%016lX\n", results.cpu0_revidr_el1);

	puts("");
	printf("CNTFRQ_EL0 shows system counter frequency:\n");
	printf("  %ld HZ\n", results.cpu0_cntfrq_el0);

	puts("");
	puts("CNTVCT_EL0 shows current system counter value:");
	cntpct_copy = results.cpu0_cntvct_el0;
	seconds = cntpct_copy / results.cpu0_cntfrq_el0;
	days = seconds / (60 * 60 * 24);
	seconds = seconds % (60 * 60 * 24);
	hours = seconds / (60 * 60);
	seconds = seconds % (60 * 60);
	minutes = seconds / 60;
	seconds = seconds % 60;
	cntpct_copy %= results.cpu0_cntfrq_el0;
	cntpct_copy *= 1000;
	milliseconds = cntpct_copy / results.cpu0_cntfrq_el0;
	cntpct_copy %= results.cpu0_cntfrq_el0;
	cntpct_copy *= 1000;
	microseconds = cntpct_copy / results.cpu0_cntfrq_el0;
	cntpct_copy %= results.cpu0_cntfrq_el0;
	cntpct_copy *= 1000;
	nanoseconds = cntpct_copy / results.cpu0_cntfrq_el0;
	printf("  %04ldd'%02ldh'%02ldm'%02lds'%03ldms'%03ldus'%03ldns\n",
	days, hours, minutes, seconds, milliseconds, microseconds, nanoseconds);

	puts("");
	puts("MIDR_EL1 shows core identification information:");
	if (((results.cpu0_midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A55_VAL)
		printf("  Indicates a Cortex A55 ");
	else if (((results.cpu0_midr_el1 & MIDR_EL1_PN_MASK) >>
					MIDR_EL1_PN_OFST) == MIDR_EL1_A76_VAL)
		printf("  Indicates a Cortex A76 ");
	else
		printf("  Indicates an UNKNOWN ");

	printf("r%ldp%ld core\n",
		(results.cpu0_midr_el1 & MIDR_EL1_VAR_MASK) >> MIDR_EL1_VAR_OFST,
		(results.cpu0_midr_el1 & MIDR_EL1_REV_MASK) >> MIDR_EL1_REV_OFST);

	printf("        Implementer = 0x%02lX",
		(results.cpu0_midr_el1 & MIDR_EL1_IMP_MASK) >>
							MIDR_EL1_IMP_OFST);
	printf("      Variant = 0x%01lX",
		(results.cpu0_midr_el1 & MIDR_EL1_VAR_MASK) >>
							MIDR_EL1_VAR_OFST);
	printf("    Architecture = 0x%01lX\n",
		(results.cpu0_midr_el1 & MIDR_EL1_ARCH_MASK) >>
							MIDR_EL1_ARCH_OFST);
	printf("            PartNum = 0x%03lX",
		(results.cpu0_midr_el1 & MIDR_EL1_PN_MASK) >>
							MIDR_EL1_PN_OFST);
	printf("    Revision = 0x%01lX\n",
		(results.cpu0_midr_el1 & MIDR_EL1_REV_MASK) >>
							MIDR_EL1_REV_OFST);

	puts("");
	puts("REVIDR_EL1 shows an implementation specific value.");

	puts("");
	printf ("Press any key to exit this demo.");
	fflush(stdout);

	/* adjust termios so we see each character input and no echo */
	tcgetattr(STDIN_FILENO, &orig_attr);
	new_attr = orig_attr;
	new_attr.c_lflag &= ~(ICANON | ECHO);
	tcsetattr(STDIN_FILENO, TCSANOW, &new_attr);

	/* wait for console input */
	do {
		result = read(STDIN_FILENO, &c, 1);
	} while(result == 0);

	/* restore termios */
	tcsetattr(STDIN_FILENO, TCSANOW, &orig_attr);

	printf ("\n\n");
	return 0;
}

void do_the_interesting_thing(struct results_s *results) {

	uint64_t cntvct_el0;
	uint64_t cntfrq_el0;
	uint64_t midr_el1;
	uint64_t revidr_el1;
	cpu_set_t cpu_mask;
	int result;

	/* move this thread to core 0 */
	CPU_ZERO(&cpu_mask);
	CPU_SET(0, &cpu_mask);
	result = sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask);
	if(result != 0) {
		perror("sched_setaffinity");
		exit(EXIT_FAILURE);
	}


	/* read the registers of interest */
	asm volatile (
		"mrs %[cntvct_el0], cntvct_el0\n"
		: [cntvct_el0] "=r" (cntvct_el0)
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
		"mrs %[revidr_el1], revidr_el1\n"
		: [revidr_el1] "=r" (revidr_el1)
	);

	/* save the results */
	results->cpu0_cntvct_el0 = cntvct_el0;
	results->cpu0_cntfrq_el0 = cntfrq_el0;
	results->cpu0_midr_el1   = midr_el1;
	results->cpu0_revidr_el1 = revidr_el1;

	/* move this thread to core 1 */
	CPU_ZERO(&cpu_mask);
	CPU_SET(1, &cpu_mask);
	result = sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask);
	if(result != 0) {
		perror("sched_setaffinity");
		exit(EXIT_FAILURE);
	}


	/* read the registers of interest */
	asm volatile (
		"mrs %[midr_el1], midr_el1\n"
		: [midr_el1] "=r" (midr_el1)
	);

	/* save the results */
	results->cpu1_midr_el1   = midr_el1;

	/* move this thread to core 2 */
	CPU_ZERO(&cpu_mask);
	CPU_SET(2, &cpu_mask);
	result = sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask);
	if(result != 0) {
		perror("sched_setaffinity");
		exit(EXIT_FAILURE);
	}


	/* read the registers of interest */
	asm volatile (
		"mrs %[midr_el1], midr_el1\n"
		: [midr_el1] "=r" (midr_el1)
	);

	/* save the results */
	results->cpu2_midr_el1   = midr_el1;

	/* move this thread to core 3 */
	CPU_ZERO(&cpu_mask);
	CPU_SET(3, &cpu_mask);
	result = sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask);
	if(result != 0) {
		perror("sched_setaffinity");
		exit(EXIT_FAILURE);
	}


	/* read the registers of interest */
	asm volatile (
		"mrs %[midr_el1], midr_el1\n"
		: [midr_el1] "=r" (midr_el1)
	);

	/* save the results */
	results->cpu3_midr_el1   = midr_el1;
}
