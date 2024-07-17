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
#include <termios.h>
#include "uio_helpers.h"
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

void do_the_interesting_thing(struct f2h_irq_s *, struct uio_map_s *,
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
	uint64_t ps_time;
	struct f2h_irq_s f2h_irq = {0};
	struct uio_map_s hps_gp_uio_map;
	struct uio_map_s gicd_base_uio_map;
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

	/* configure struct for gicd-base-uio device */
	gicd_base_uio_map.uio_name = "gicd-base-uio";
	gicd_base_uio_map.uio_length = getpagesize();
	gicd_base_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	gicd_base_uio_map.uio_flags = MAP_SHARED;
	gicd_base_uio_map.uio_offset = 0;

	/* find the gicd-base-uio device */
	result = find_uio_index(&gicd_base_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the gicd-base-uio device */
	result = mmap_uio(&gicd_base_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&f2h_irq, &hps_gp_uio_map, &gicd_base_uio_map);

	/* print the results */
	puts("");
	printf ("F2H IRQ Demo\n");
	puts("");

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
	puts("");

	printf("f2h_irq mappings: "
		"ISPENDR1[17]=f2s_fpga_irq0 thru "
		"ISPENDR3[16]=f2s_fpga_irq63\n");
	puts("");
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

	puts("");
	puts("GIC access times in nanoseconds for each index above.");
	for(i = 0 ; i < 8 ; i++) {

		/* print first column */
		ns_time = (f2h_irq.gic_ispend_access_time[i] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4ld | ", i, ns_time);

		/* print second column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 8] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 8] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4ld | ", i + 8, ns_time);

		/* print third column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 16] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 16] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4ld | ", i + 16, ns_time);

		/* print fourth column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 24] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 24] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4ld | ", i + 24, ns_time);

		/* print fifth column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 32] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 32] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4ld | ", i + 32, ns_time);

		/* print sixth column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 40] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 40] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4ld | ", i + 40, ns_time);

		/* print seventh column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 48] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 48] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4ld | ", i + 48, ns_time);

		/* print eigth column */
		ns_time = (f2h_irq.gic_ispend_access_time[i + 56] * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_irq.gic_ispend_access_time[i + 56] * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%2d:%4ld |", i + 56, ns_time);

		puts("");
	}

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

void do_the_interesting_thing(struct f2h_irq_s *f2h_irq,
					struct uio_map_s *hps_gp_map,
					struct uio_map_s *gicd_map) {

	int i;
	uint32_t gp_in;
	uint32_t ispendr1;
	uint32_t ispendr2;
	uint32_t ispendr3;
	uint64_t start_time;
	uint64_t end_time;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(hps_gp_map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(hps_gp_map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	f2h_irq->gp_sig_value = gp_in;

	if(gp_in != IRQ_SIG)
		return;

	ispendr1 = *((volatile uint32_t *)(gicd_map->uio_mmap_addr +
						(GIC_ISPENDR1_BASE & 0xFFF)));
	ispendr2 = *((volatile uint32_t *)(gicd_map->uio_mmap_addr +
						(GIC_ISPENDR2_BASE & 0xFFF)));
	ispendr3 = *((volatile uint32_t *)(gicd_map->uio_mmap_addr +
						(GIC_ISPENDR3_BASE & 0xFFF)));

	f2h_irq->gic_ispendr1_value_init = ispendr1;
	f2h_irq->gic_ispendr2_value_init = ispendr2;
	f2h_irq->gic_ispendr3_value_init = ispendr3;

	/* verify 64-bits of the 64-bit irq vector */
	for(i = 0 ; i < 64 ; i++) {

		/* write the gp_out register */
		*((volatile uint32_t *)(hps_gp_map->uio_mmap_addr +
				(HPS_GP_OUT_BASE & 0xFFF))) = 0xFFFFFFC0 | i;

		/* mark the time */
		asm volatile (
			"mrs %[start_time], cntvct_el0\n"
			: [start_time] "=r" (start_time)
		);

		/* read the gic ispendr registers */
		ispendr1 = *((volatile uint32_t *)(gicd_map->uio_mmap_addr +
						(GIC_ISPENDR1_BASE & 0xFFF)));
		ispendr2 = *((volatile uint32_t *)(gicd_map->uio_mmap_addr +
						(GIC_ISPENDR2_BASE & 0xFFF)));
		ispendr3 = *((volatile uint32_t *)(gicd_map->uio_mmap_addr +
						(GIC_ISPENDR3_BASE & 0xFFF)));

		/* mark the time */
		asm volatile (
			"mrs %[end_time], cntvct_el0\n"
			: [end_time] "=r" (end_time)
		);

		/* save the results */
		f2h_irq->gic_ispend_access_time[i] = end_time - start_time;
		f2h_irq->gic_ispendr1_value[i] = ispendr1;
		f2h_irq->gic_ispendr2_value[i] = ispendr2;
		f2h_irq->gic_ispendr3_value[i] = ispendr3;
	}
}

