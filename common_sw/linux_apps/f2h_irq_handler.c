/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <termios.h>
#include "uio_helpers.h"
#include "standalone_common.h"

struct f2h_irq_hndlr_s {
	uint32_t gp_sig_value;
	uint64_t irq_time[64];
	uint64_t dtbo_id[64];
	uint64_t gic_id[64];
};

void do_the_interesting_thing(struct f2h_irq_hndlr_s *, struct uio_map_s *,
							struct uio_map_s *);

int main(void)
{
	int i;
	char c;
	int result;
	int the_fd;
	char *next_app_name;
	ssize_t next_app_name_len;
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	struct f2h_irq_hndlr_s f2h_irq_hndlr = {0};
	struct uio_map_s hps_gp_uio_map;
	struct uio_map_s f2h_irq_uio[64];
	char f2h_irq_name[64][32];
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

	/* configure struct for hps-gp-uio device */
	hps_gp_uio_map.uio_name = "hps-gp-uio";
	hps_gp_uio_map.uio_length = getpagesize();
	hps_gp_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	hps_gp_uio_map.uio_flags = MAP_SHARED;
	hps_gp_uio_map.uio_offset = 0;

	/* find the hps-gp-uio device */
	result = find_uio_index(&hps_gp_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the hps-gp-uio device */
	result = mmap_uio(&hps_gp_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* verify HPS GPOUT port is zero on entry */
	if(*((volatile uint32_t *)(hps_gp_uio_map.uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) != 0) {

		asm volatile ("dsb sy\n");
		*((volatile uint32_t *)(hps_gp_uio_map.uio_mmap_addr +
						(HPS_GP_OUT_BASE & 0xFFF))) = 0;
		asm volatile ("dsb sy\n");

		puts("");
		puts("HPS_GP_OUT register is non-zero on entry,"
			" it has been cleared...");
		puts("please restart the demo");
		goto exit_app;
	}

	/* open all the irq uio devices */
	for(i = 0 ; i < 64 ; i++) {

		snprintf(f2h_irq_name[i], 32, "f2h-irq-%d-uio", i);

		/* configure struct for f2h-irq-0-uio device */
		f2h_irq_uio[i].uio_name = f2h_irq_name[i];
		f2h_irq_uio[i].uio_length = getpagesize();
		f2h_irq_uio[i].uio_prot = PROT_READ | PROT_WRITE;
		f2h_irq_uio[i].uio_flags = MAP_SHARED;
		f2h_irq_uio[i].uio_offset = 0;

		/* find the f2h-irq-0-uio device */
		result = find_uio_index(&f2h_irq_uio[i]);
		if(result != 0) {
			printf("ERROR: find_uio_index : %d\n", result);
			return 1;
		}

		/* open the f2h-irq-0-uio device */
		result = open_only_uio(&f2h_irq_uio[i]);
		if(result != 0) {
			printf("ERROR: open_only_uio : %d\n", result);
			return 1;
		}
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&f2h_irq_hndlr, &hps_gp_uio_map, f2h_irq_uio);

	/* print the results */
	puts("");
	printf ("F2H IRQ Handler Demo\n");
	puts("");

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
	puts("");

	printf("  FPGA : DTBO :  GIC  :    IRQ    ");
	printf("   FPGA : DTBO :  GIC  :    IRQ");
	puts("");
	printf("  IRQ  : INT  : INTID :    TIME   ");
	printf("   IRQ  : INT  : INTID :    TIME");
	puts("");
	printf(" ------+------+-------+-----------");
	printf("  ------+------+-------+-----------");
	puts("");

	for(i = 0 ; i < 32 ; i++ ) {
		/* column one */
		printf("    %2d :", i);

		printf(" %4lu :", f2h_irq_hndlr.dtbo_id[i]);

		printf("  %4lu :", f2h_irq_hndlr.gic_id[i]);

		ns_time = (f2h_irq_hndlr.irq_time[i] * 1000000000)
								/ cntfrq_el0;
		printf(" %6ld ns", ns_time);

		/* column two */
		printf("      %2d :", i + 32);

		printf(" %4lu :", f2h_irq_hndlr.dtbo_id[i + 32]);

		printf("  %4lu :", f2h_irq_hndlr.gic_id[i + 32]);

		ns_time = (f2h_irq_hndlr.irq_time[i + 16] * 1000000000)
								/ cntfrq_el0;
		printf(" %6ld ns", ns_time);

		puts("");
	}

exit_app:
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

void do_the_interesting_thing(struct f2h_irq_hndlr_s *f2h_irq_hndlr,
					struct uio_map_s *map,
					struct uio_map_s *f2h_irq_0_uio) {

	int      i;
	int      result;
	int      response;
	uint32_t gp_in;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t temp_time;
	pid_t    child_pid;
	int      child_status;
	uint32_t temp_32;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	f2h_irq_hndlr->gp_sig_value = gp_in;

	if(gp_in != IRQ_SIG)
		return;

	/* acquire the cntfrq_el0 to create timeout counts  later */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	for(i = 0 ; i < 64 ; i++) {

		/* enable the uio interrupt */
		temp_32 = 1;
		result = write((&f2h_irq_0_uio[i])->uio_fd , &temp_32, 4);
		if(result != 4) {
			perror("enabling uio irq");
			exit(EXIT_FAILURE);
		}

		/* fork a child process to wait for the interrupt */
		child_pid = fork();
		if(child_pid == -1) {
			perror("fork failed");
			exit(EXIT_FAILURE);
		}

		if(child_pid == 0) {	/* 0 passed to child process */

			/* wait for the interrupt */
			result = read((&f2h_irq_0_uio[i])->uio_fd,
								&response, 4);

			if((result != 4) || (response != 1)) {
				printf("bad irq response %d - %d - %d\n",
							i, result, response);
				exit(EXIT_FAILURE);
			}

			/* clear the interrupt */
			asm volatile ("dsb sy\n");
			*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;

			exit(EXIT_SUCCESS);

		} else {		/* child pid passed to parent process */

			/* mark the time */
			asm volatile (
				"dsb sy\n"
				"mrs %[start_time], cntvct_el0\n"
				: [start_time] "=r" (start_time)
			);

			/* wait for 20ms */
			end_time = start_time + (cntfrq_el0 / 50);
			while(1) {
				asm volatile (
					"mrs %[temp_time], cntvct_el0\n"
					: [temp_time] "=r" (temp_time)
				);
				if(temp_time > end_time)
					break;
			}

			/* mark the time */
			asm volatile (
				"dsb sy\n"
				"mrs %[start_time], cntvct_el0\n"
				: [start_time] "=r" (start_time)
			);

			/* trigger interrupt */
			asm volatile ("dsb sy\n");
			*((volatile uint32_t *)(map->uio_mmap_addr +
				(HPS_GP_OUT_BASE & 0xFFF))) = 0xFFFFFFC0 | i;

			/* timeout in 1ms */
			end_time = start_time + (cntfrq_el0 / 1000);
			asm volatile ("dsb sy\n");
			while(*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) != 0) {
				asm volatile (
					"mrs %[temp_time], cntvct_el0\n"
					: [temp_time] "=r" (temp_time)
				);
				if(temp_time > end_time) {
					perror("timeout waiting for irq clear");
					exit(EXIT_FAILURE);
				}
				asm volatile ("dsb sy\n");
			}

			/* mark the time */
			asm volatile (
				"dsb sy\n"
				"mrs %[end_time], cntvct_el0\n"
				: [end_time] "=r" (end_time)
			);

			/* store the results */
			f2h_irq_hndlr->dtbo_id[i] = 17 + i;
			f2h_irq_hndlr->gic_id[i] = 32 +
						f2h_irq_hndlr->dtbo_id[i];
			f2h_irq_hndlr->irq_time[i] = end_time - start_time;

			/* clean up the child process */
			waitpid(child_pid, &child_status, 0);
			if(WIFEXITED(child_status)) {
				if(WEXITSTATUS(child_status) != EXIT_SUCCESS) {
					perror("child exited with failure");
					exit(EXIT_FAILURE);
				}
			} else {
				perror("child exited abnormally");
				exit(EXIT_FAILURE);
			}
		}
	}
}
