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

void do_the_interesting_thing(struct h2f_bridge_s *, struct uio_map_s *,
							struct uio_map_s *,
							struct uio_map_s *,
							struct uio_map_s *);

int main(void)
{
	char c;
	int result;
	int the_fd;
	char *next_app_name;
	ssize_t next_app_name_len;
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	struct h2f_bridge_s h2f_bridge = {0};
	struct uio_map_s hps_gp_uio_map;
	struct uio_map_s h2f_bridge_1g_uio_map;
	struct uio_map_s h2f_bridge_15g_uio_map;
	struct uio_map_s h2f_bridge_240g_uio_map;
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

	/* configure struct for h2f-bridge-1g device */
	h2f_bridge_1g_uio_map.uio_name = "h2f-bridge-1g-uio";
	h2f_bridge_1g_uio_map.uio_length = 0x40000000;
	h2f_bridge_1g_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	h2f_bridge_1g_uio_map.uio_flags = MAP_SHARED;
	h2f_bridge_1g_uio_map.uio_offset = 0;

	/* find the h2f-bridge-1g device */
	result = find_uio_index(&h2f_bridge_1g_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the h2f-bridge-1g device */
	result = mmap_uio(&h2f_bridge_1g_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* configure struct for h2f-bridge-15g device */
	h2f_bridge_15g_uio_map.uio_name = "h2f-bridge-15g-uio";
	h2f_bridge_15g_uio_map.uio_length = 0x3C0000000;
	h2f_bridge_15g_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	h2f_bridge_15g_uio_map.uio_flags = MAP_SHARED;
	h2f_bridge_15g_uio_map.uio_offset = 0;

	/* find the h2f-bridge-15g device */
	result = find_uio_index(&h2f_bridge_15g_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the h2f-bridge-15g device */
	result = mmap_uio(&h2f_bridge_15g_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* configure struct for h2f-bridge-240g device */
	h2f_bridge_240g_uio_map.uio_name = "h2f-bridge-240g-uio";
	h2f_bridge_240g_uio_map.uio_length = 0x3C00000000;
	h2f_bridge_240g_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	h2f_bridge_240g_uio_map.uio_flags = MAP_SHARED;
	h2f_bridge_240g_uio_map.uio_offset = 0;

	/* find the h2f-bridge-240g device */
	result = find_uio_index(&h2f_bridge_240g_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the h2f-bridge-240g device */
	result = mmap_uio(&h2f_bridge_240g_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&h2f_bridge, &hps_gp_uio_map,
						&h2f_bridge_1g_uio_map,
						&h2f_bridge_15g_uio_map,
						&h2f_bridge_240g_uio_map);

	/* print the results */
	puts("");
	printf ("H2F Demo\n");
	puts("");

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
	puts("");

	printf("SYSID_ID: 0x%08X\n", h2f_bridge.sysid_id);
	printf("SYSID_TS: 0x%08X\n", h2f_bridge.sysid_ts);

	puts("");
	printf("     ---1GB SPAN--- :     ---PASS 1---   :     ---PASS 2---\n");

	printf("LO WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_lo_1g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_1g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_lo_1g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_1g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf("HI WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_hi_1g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_1g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_hi_1g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_1g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf(" LO READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_lo_1g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_1g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_lo_1g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_1g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf(" HI READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_hi_1g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_1g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_hi_1g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_1g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf("        LO READ BACK: 0x%016lX : 0x%016lX\n",
		h2f_bridge.lo_1g_readback[0], h2f_bridge.lo_1g_readback[1]);
	printf("        HI READ BACK: 0x%016lX : 0x%016lX\n",
		h2f_bridge.hi_1g_readback[0], h2f_bridge.hi_1g_readback[1]);

	puts("");
	printf("    ---15GB SPAN--- :     ---PASS 1---   :     ---PASS 2---\n");

	printf("LO WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_lo_15g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_15g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_lo_15g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_15g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf("HI WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_hi_15g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_15g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_hi_15g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_15g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf(" LO READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_lo_15g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_15g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_lo_15g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_15g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf(" HI READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_hi_15g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_15g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_hi_15g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_15g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf("        LO READ BACK: 0x%016lX : 0x%016lX\n",
		h2f_bridge.lo_15g_readback[0], h2f_bridge.lo_15g_readback[1]);
	printf("        HI READ BACK: 0x%016lX : 0x%016lX\n",
		h2f_bridge.hi_15g_readback[0], h2f_bridge.hi_15g_readback[1]);

	puts("");
	printf("   ---240GB SPAN--- :     ---PASS 1---   :     ---PASS 2---\n");

	printf("LO WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_lo_240g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_240g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_lo_240g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_lo_240g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf("HI WRITE ACCESS TIME:");
	ns_time = (h2f_bridge.write_hi_240g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_240g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.write_hi_240g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.write_hi_240g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf(" LO READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_lo_240g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_240g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_lo_240g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_lo_240g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf(" HI READ ACCESS TIME:");
	ns_time = (h2f_bridge.read_hi_240g_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_240g_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (h2f_bridge.read_hi_240g_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (h2f_bridge.read_hi_240g_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf("        LO READ BACK: 0x%016lX : 0x%016lX\n",
		h2f_bridge.lo_240g_readback[0], h2f_bridge.lo_240g_readback[1]);
	printf("        HI READ BACK: 0x%016lX : 0x%016lX\n",
		h2f_bridge.hi_240g_readback[0], h2f_bridge.hi_240g_readback[1]);

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

void do_the_interesting_thing(struct h2f_bridge_s *h2f_bridge,
				struct uio_map_s *map,
				struct uio_map_s *h2f_1g_map,
				struct uio_map_s *h2f_15g_map,
				struct uio_map_s *h2f_240g_map) {

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
	*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	h2f_bridge->gp_sig_value = gp_in;

	if(gp_in != H2F_SIG)
		return;

	/* validate the sysid signature */
	sysid_id = *((volatile uint32_t *)(h2f_1g_map->uio_mmap_addr +
			((H2F_SYSID_ID_BASE) & (H2F_1G_SPAN - 1))));

	h2f_bridge->sysid_id = sysid_id;

	if(sysid_id != H2F_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(h2f_1g_map->uio_mmap_addr +
			((H2F_SYSID_TS_BASE) & (H2F_1G_SPAN - 1))));
	h2f_bridge->sysid_ts = sysid_ts;

	/* initialize pointers to first and last word of spans */
	first_word_ptr[0] = (uint64_t *)(h2f_1g_map->uio_mmap_addr +
			((H2F_1G_BASE) & (H2F_1G_SPAN - 1)));
	last_word_ptr[0] = (uint64_t *)(h2f_1g_map->uio_mmap_addr +
			((H2F_1G_BASE + H2F_1G_SPAN - sizeof(uint64_t))
			& (H2F_1G_SPAN - 1)));
	first_word_ptr[1] = (uint64_t *)(h2f_15g_map->uio_mmap_addr +
			((H2F_15G_BASE) & (H2F_15G_SPAN - 1)));
	last_word_ptr[1] = (uint64_t *)(h2f_15g_map->uio_mmap_addr +
			((H2F_15G_BASE + H2F_15G_SPAN - sizeof(uint64_t))
			& (H2F_15G_SPAN - 1)));
	first_word_ptr[2] = (uint64_t *)(h2f_240g_map->uio_mmap_addr +
				((H2F_240G_BASE) & (H2F_240G_SPAN - 1)));
	last_word_ptr[2] = (uint64_t *)(h2f_240g_map->uio_mmap_addr +
			((H2F_240G_BASE + H2F_240G_SPAN - sizeof(uint64_t))
			& (H2F_240G_SPAN - 1)));

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
				"mrs %[start_time], cntvct_el0\n"
				: [start_time] "=r" (start_time)
			);

			*first_word_ptr[i] = first_word_write_value[i][j];

			/* mark the time */
			asm volatile (
				"mrs %[end_time], cntvct_el0\n"
				: [end_time] "=r" (end_time)
			);

			first_word_write_time[i][j] = end_time - start_time;

			/* write to last word */
			/* mark the time */
			asm volatile (
				"mrs %[start_time], cntvct_el0\n"
				: [start_time] "=r" (start_time)
			);

			*last_word_ptr[i] = last_word_write_value[i][j];

			/* mark the time */
			asm volatile (
				"mrs %[end_time], cntvct_el0\n"
				: [end_time] "=r" (end_time)
			);

			last_word_write_time[i][j] = end_time - start_time;
		}

		for(i = 0 ; i < 3 ; i++) {
			/* read from first word */
			/* mark the time */
			asm volatile (
				"mrs %[start_time], cntvct_el0\n"
				: [start_time] "=r" (start_time)
			);

			first_word_read_value[i][j] = *first_word_ptr[i];

			/* mark the time */
			asm volatile (
				"mrs %[end_time], cntvct_el0\n"
				: [end_time] "=r" (end_time)
			);

			first_word_read_time[i][j] = end_time - start_time;

			/* read from last word */
			/* mark the time */
			asm volatile (
				"mrs %[start_time], cntvct_el0\n"
				: [start_time] "=r" (start_time)
			);

			last_word_read_value[i][j] = *last_word_ptr[i];

			/* mark the time */
			asm volatile (
				"mrs %[end_time], cntvct_el0\n"
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

