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

void do_the_interesting_thing(struct lwh2f_bridge_s *, struct uio_map_s *,
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
	struct lwh2f_bridge_s lwh2f_bridge = {0};
	struct uio_map_s hps_gp_uio_map;
	struct uio_map_s lwh2f_bridge_uio_map;
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

	/* configure struct for lwh2f-bridge device */
	lwh2f_bridge_uio_map.uio_name = "lwh2f-bridge-uio";
	lwh2f_bridge_uio_map.uio_length = 0x20000000;
	lwh2f_bridge_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	lwh2f_bridge_uio_map.uio_flags = MAP_SHARED;
	lwh2f_bridge_uio_map.uio_offset = 0;

	/* find the lwh2f-bridge device */
	result = find_uio_index(&lwh2f_bridge_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the lwh2f-bridge device */
	result = mmap_uio(&lwh2f_bridge_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&lwh2f_bridge, &hps_gp_uio_map,
							&lwh2f_bridge_uio_map);

	/* print the results */
	puts("");
	printf ("LWH2F Demo\n");
	puts("");

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
	puts("");

	printf("SYSID_ID: 0x%08X\n", lwh2f_bridge.sysid_id);
	printf("SYSID_TS: 0x%08X\n", lwh2f_bridge.sysid_ts);

	puts("");
	printf("   ---512MB SPAN--- :     ---PASS 1---   :     ---PASS 2---\n");

	printf("LO WRITE ACCESS TIME:");
	ns_time = (lwh2f_bridge.write_lo_512m_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.write_lo_512m_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (lwh2f_bridge.write_lo_512m_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.write_lo_512m_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf("HI WRITE ACCESS TIME:");
	ns_time = (lwh2f_bridge.write_hi_512m_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.write_hi_512m_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (lwh2f_bridge.write_hi_512m_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.write_hi_512m_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf(" LO READ ACCESS TIME:");
	ns_time = (lwh2f_bridge.read_lo_512m_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.read_lo_512m_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (lwh2f_bridge.read_lo_512m_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.read_lo_512m_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf(" HI READ ACCESS TIME:");
	ns_time = (lwh2f_bridge.read_hi_512m_access_time[0] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.read_hi_512m_access_time[0] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns :", ns_time, ps_time);

	ns_time = (lwh2f_bridge.read_hi_512m_access_time[1] * 1000000000)
							/ cntfrq_el0;
	ps_time = (lwh2f_bridge.read_hi_512m_access_time[1] * 1000000000)
							% cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("       %6ld.%03ldns\n", ns_time, ps_time);

	printf("        LO READ BACK: 0x%016lX : 0x%016lX\n",
					lwh2f_bridge.lo_512m_readback[0],
					lwh2f_bridge.lo_512m_readback[1]);
	printf("        HI READ BACK: 0x%016lX : 0x%016lX\n",
					lwh2f_bridge.hi_512m_readback[0],
					lwh2f_bridge.hi_512m_readback[1]);

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

void do_the_interesting_thing(struct lwh2f_bridge_s *lwh2f_bridge,
				struct uio_map_s *map,
				struct uio_map_s *lwh2f_map) {

	uint32_t gp_in;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t *first_word_ptr;
	uint64_t *last_word_ptr;
	uint64_t temp;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
					(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	lwh2f_bridge->gp_sig_value = gp_in;

	if(gp_in != LWH2_SIG)
		return;

	/* validate the sysid signature */
	sysid_id = *((volatile uint32_t *)(lwh2f_map->uio_mmap_addr +
			((LWH2F_SYSID_ID_BASE) & (LWH2F_512M_SPAN - 1))));

	lwh2f_bridge->sysid_id = sysid_id;

	if(sysid_id != LWH2_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(lwh2f_map->uio_mmap_addr +
			((LWH2F_SYSID_TS_BASE) & (LWH2F_512M_SPAN - 1))));
	lwh2f_bridge->sysid_ts = sysid_ts;

	/* write and read the memories in the FPGA fabric */
	first_word_ptr = (uint64_t *)(lwh2f_map->uio_mmap_addr +
				((LWH2F_512M_BASE) & (LWH2F_512M_SPAN - 1)));
	last_word_ptr = (uint64_t *)(lwh2f_map->uio_mmap_addr +
			((LWH2F_512M_BASE + LWH2F_512M_SPAN - sizeof(uint64_t))
			& (LWH2F_512M_SPAN - 1)));

/* write to first word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	*first_word_ptr = 0x1111111111111111;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->write_lo_512m_access_time[0] = end_time - start_time;

/* write to last word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	*last_word_ptr = 0x2222222222222222;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->write_hi_512m_access_time[0] = end_time - start_time;

/* read from first word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	temp = *first_word_ptr;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->read_lo_512m_access_time[0] = end_time - start_time;
	lwh2f_bridge->lo_512m_readback[0] = temp;

/* read from last word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	temp = *last_word_ptr;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->read_hi_512m_access_time[0] = end_time - start_time;
	lwh2f_bridge->hi_512m_readback[0] = temp;

/* change the patterns and do it again */
/* write to first word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	*first_word_ptr = ~0x1111111111111111;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->write_lo_512m_access_time[1] = end_time - start_time;

/* write to last word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	*last_word_ptr = ~0x2222222222222222;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->write_hi_512m_access_time[1] = end_time - start_time;

/* read from first word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	temp = *first_word_ptr;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->read_lo_512m_access_time[1] = end_time - start_time;
	lwh2f_bridge->lo_512m_readback[1] = temp;

/* read from last word */
	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	temp = *last_word_ptr;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	lwh2f_bridge->read_hi_512m_access_time[1] = end_time - start_time;
	lwh2f_bridge->hi_512m_readback[1] = temp;
}

