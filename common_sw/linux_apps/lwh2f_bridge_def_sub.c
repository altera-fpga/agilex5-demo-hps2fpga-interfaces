/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <termios.h>
#include <errno.h>
#include <signal.h>
#include <setjmp.h>
#include <sched.h>
#include "uio_helpers.h"
#include "standalone_common.h"

struct lwh2f_bridge_s {
	uint32_t gp_sig_value;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t start_time;
	uint64_t abort_time;
	uint64_t end_time;
};

sigjmp_buf g_sigbus_jmp_buf;
sigjmp_buf *g_sigbus_jmp_buf_ptr = NULL;
uint64_t g_abort_time = 0;

void my_sigbus_handler(int signal_number) {
	(void)signal_number;
	uint64_t abort_time;

	/* mark the time */
	asm volatile (
		"mrs %[abort_time], cntvct_el0\n"
		: [abort_time] "=r" (abort_time)
	);
	g_abort_time = abort_time;

	/* jump back to the sigsetjmp point */
	if(g_sigbus_jmp_buf_ptr != NULL) {
		siglongjmp(*g_sigbus_jmp_buf_ptr, 1);
	}

	printf("SIGBUS not handled\n");
	fflush(stdout);
	abort();
}

void do_the_interesting_thing(struct lwh2f_bridge_s *, struct uio_map_s *,
							struct uio_map_s *);

int main(int argc, char *const argv[])
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
	struct sigaction new_action;
	struct sigaction old_action;
	cpu_set_t cpu_mask;

	/* move this thread to core 1 so we can capture the SIGBUS fault */
	CPU_ZERO(&cpu_mask);
	/* allow user to pass alternate core selection for test to use */
	if(argc == 2) {
		if(argv[1][0] == '0') {
			puts("using manual override core 0 affinity");
			CPU_SET(0, &cpu_mask);
		}
		else if(argv[1][0] == '1') {
			puts("using manual override core 1 affinity");
			CPU_SET(1, &cpu_mask);
		}
		else if(argv[1][0] == '2') {
			puts("using manual override core 2 affinity");
			CPU_SET(2, &cpu_mask);
		}
		else if(argv[1][0] == '3') {
			puts("using manual override core 3 affinity");
			CPU_SET(3, &cpu_mask);
		} else {
			puts("using default core 1 affinity");
			CPU_SET(1, &cpu_mask);
		}
	} else
		CPU_SET(1, &cpu_mask);
	result = sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask);
	if(result != 0) {
		perror("sched_setaffinity");
		exit(EXIT_FAILURE);
	}

	/* register a SIGBUS handler */
	new_action.sa_handler = my_sigbus_handler;
	sigemptyset(&new_action.sa_mask);
	new_action.sa_flags = 0;

	result = sigaction(SIGBUS, NULL, &old_action);
	if(result < 0) {
		perror("sigaction");
		exit(EXIT_FAILURE);
	}

	if(old_action.sa_handler != SIG_IGN) {
		result = sigaction(SIGBUS, &new_action, NULL);
		if(result < 0) {
			perror("sigaction");
			exit(EXIT_FAILURE);
		}
	}
	else
		perror("SIGBUS handler already installed");

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
	printf ("LWH2F Default Subordinate Demo\n");
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

	printf("start time: 0x%016lX\n", lwh2f_bridge.start_time);
	printf("abort time: 0x%016lX\n", lwh2f_bridge.abort_time);
	printf("  end time: 0x%016lX\n", lwh2f_bridge.end_time);
	puts("");

	if(lwh2f_bridge.abort_time == 0) {

		puts("ERROR: "
			"abort handler did not execute...");
		puts("ERROR: "
			"default subordinate was not triggered...");

	} else if((lwh2f_bridge.abort_time > lwh2f_bridge.end_time) ||
		(lwh2f_bridge.abort_time < lwh2f_bridge.start_time)) {

		puts("ERROR: "
			"time sequencing is not correct...");
		puts("ERROR: "
			"expecting start, then abort, then end...");

	} else {
		puts("Abort handler did execute...");
		puts("Default subordinate was triggered...");
		puts("");

		/* start to abort time */
		ns_time = ((lwh2f_bridge.abort_time - lwh2f_bridge.start_time) *
						1000000000) / cntfrq_el0;
		ps_time = ((lwh2f_bridge.abort_time - lwh2f_bridge.start_time) *
						1000000000) % cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("    time from start to abort = %3ld.%03ldns\n",
							ns_time, ps_time);

		/* abort to end time */
		ns_time = ((lwh2f_bridge.end_time - lwh2f_bridge.abort_time) *
						1000000000) / cntfrq_el0;
		ps_time = ((lwh2f_bridge.end_time - lwh2f_bridge.abort_time) *
						1000000000) % cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("      time from abort to end = %3ld.%03ldns\n",
							ns_time, ps_time);

		/* start to end time */
		ns_time = ((lwh2f_bridge.end_time - lwh2f_bridge.start_time) *
						1000000000) / cntfrq_el0;
		ps_time = ((lwh2f_bridge.end_time - lwh2f_bridge.start_time) *
						1000000000) % cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("total time from start to end = %3ld.%03ldns\n",
							ns_time, ps_time);
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

#define USE_DEV_MEM_MAPPING (1)

void do_the_interesting_thing(struct lwh2f_bridge_s *lwh2f_bridge,
				struct uio_map_s *map,
				struct uio_map_s *lwh2f_map) {

#if USE_DEV_MEM_MAPPING
	int the_fd;
	int result;
	void *mmap_addr;
#endif
	int saw_bus_error;
	uint32_t gp_in;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t start_time = 0;
	uint64_t end_time;
	volatile uint64_t *bad_word_ptr;
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

	/* access an undecoded location in the lwh2f span */
	bad_word_ptr = (uint64_t *)(lwh2f_map->uio_mmap_addr +
			((LWH2F_512M_BASE + 4096) & (LWH2F_512M_SPAN - 1)));

/* --------------------------------------------------------------------------
   When developing this application, we ran into an issue that prevented us from
   cleanly capturing the SIGBUS signal from the bus error that we generate
   below. At one point it seemed like we were witnessing different behavior
   between when we mapped the access to the bad address we were accessing via
   the uio mapping versus a /dev/mem mapping. It now appears that this
   difference in how we map the address has nothing to do with the inconsistent
   behavior. Since this code was already instrumented into the example, we
   figured we would leave it in place as it's the only place where we mmap an
   address through /dev/mem instead of through a uio mapping.

   The original issue we were debugging was that when we tried to capture the
   SIGBUS signal from user space, we often got an asychronous SError that was
   unrecoverable and caused a kernel panic. Sometimes we captured the SIGBUS
   signal as we expected to and the program operated as desired. More often than
   not, we would experience the panic. What it seems like we've determined is
   that if we force our thread onto core 1 or core 2, then we consistently
   capture the SIGBUS signal generated from the bus error event. When we force
   our thread onto core 0 or 3, then we consistently witness the panic from the
   unrecoverable SError.

   If you'd like to witness the behavior of the UIO mapping just comment out
   the following code. You can change the value of the USE_DEV_MEM_MAPPING
   macro from 1 to 0 to comment out the following block and the variables it
   references above.
   -------------------------------------------------------------------------- */
#if USE_DEV_MEM_MAPPING
	the_fd = open("/dev/mem", O_RDWR | O_SYNC);
	if(the_fd < 0) {
		puts("ERROR: open /dev/mem");
		exit(EXIT_FAILURE);
	}
	mmap_addr = mmap(	NULL,
				LWH2F_512M_SPAN,
				PROT_READ | PROT_WRITE,
				MAP_SHARED,
				the_fd,
				LWH2F_512M_BASE);
	if(mmap_addr == MAP_FAILED) {
		puts("ERROR: mmap /dev/mem");
		exit(EXIT_FAILURE);
	}

	/* access an undecoded location in the h2f span */
	bad_word_ptr = (uint64_t *)(mmap_addr +
			((LWH2F_512M_BASE + 4096) & (LWH2F_512M_SPAN - 1)));
#endif

	saw_bus_error = 0;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);
	if(sigsetjmp(g_sigbus_jmp_buf, 1) == 0) {

		g_sigbus_jmp_buf_ptr = &g_sigbus_jmp_buf;
		asm volatile (
			"dsb sy\n"
		);

		/* this should cause a bus error */
		temp = *bad_word_ptr;
		(void)temp;

		asm volatile (
			"dsb sy\n"
		);
	} else {
		saw_bus_error = 1;
		(void)saw_bus_error;
	}
	g_sigbus_jmp_buf_ptr = NULL;

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* store the results */
	lwh2f_bridge->start_time = start_time;
	lwh2f_bridge->abort_time = g_abort_time;
	lwh2f_bridge->end_time = end_time;

#if USE_DEV_MEM_MAPPING
	result = munmap(mmap_addr, LWH2F_512M_SPAN);
	if(result != 0) {
		puts("ERROR: munmap");
		exit(EXIT_FAILURE);
	}
	result = close(the_fd);
	if(result != 0) {
		puts("ERROR: close the_fd");
		exit(EXIT_FAILURE);
	}
#endif
}
