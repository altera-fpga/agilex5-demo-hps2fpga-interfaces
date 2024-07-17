/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct sdm_query_s {
	uint32_t firm_ver_result;
	uint32_t firm_ver_value;
	uint64_t firm_ver_time_delta;
	uint32_t usercode_result;
	uint32_t usercode_value;
	uint64_t usercode_time_delta;
	uint32_t chipid_result;
	uint32_t chipid_mbox_err;
	uint32_t chipid_id_lo;
	uint32_t chipid_id_hi;
	uint64_t chipid_time_delta;
};

void do_the_interesting_thing(struct sdm_query_s *sdm_query);

int sdm_query(int argc, char *const argv[])
{
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	struct sdm_query_s sdm_query = {0};

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
	do_the_interesting_thing(&sdm_query);

	/* print the results */
	puts("\n");
	printf ("SDM Query Demo\n");
	puts("\n");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("  SDM FIRMWARE VERSION = 0x%08X\n", sdm_query.firm_ver_value);
	printf("    Query Result: 0x%08X\n", sdm_query.firm_ver_result);
	printf("     Query Value: 0x%08X\n", sdm_query.firm_ver_value);
	ns_time = (sdm_query.firm_ver_time_delta * 1000000000) / cntfrq_el0;
	ps_time = (sdm_query.firm_ver_time_delta * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("     Access Time: %lld.%03lld ns\n", ns_time, ps_time);
	puts("\n");

	printf("  JTAG USERCODE = 0x%08X\n", sdm_query.usercode_value);
	printf("    Query Result: 0x%08X\n", sdm_query.usercode_result);
	printf("     Query Value: 0x%08X\n", sdm_query.usercode_value);
	ns_time = (sdm_query.usercode_time_delta * 1000000000) / cntfrq_el0;
	ps_time = (sdm_query.usercode_time_delta * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("     Access Time: %lld.%03lld ns\n", ns_time, ps_time);
	puts("\n");

	printf("  CHIP ID = 0x%08X%08X\n", sdm_query.chipid_id_hi,
							sdm_query.chipid_id_lo);
	printf("    Query Result: 0x%08X\n", sdm_query.chipid_result);
	printf("      MBOX Error: 0x%08X\n", sdm_query.chipid_mbox_err);
	printf("     ID Lo Value: 0x%08X\n", sdm_query.chipid_id_lo);
	printf("     ID Hi Value: 0x%08X\n", sdm_query.chipid_id_hi);
	ns_time = (sdm_query.chipid_time_delta * 1000000000) / cntfrq_el0;
	ps_time = (sdm_query.chipid_time_delta * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("     Access Time: %lld.%03lld ns\n", ns_time, ps_time);
	puts("\n");

	puts("\n");
	printf ("Press any key to exit this demo.");

	/* wait for console input */
	while (!tstc());

	/* discard the input */
	(void) getc();

	printf ("\n\n");
	return 0;
}

#define FIRMWARE_VERSION	(0)
#define JTAG_USERCODE		(1)
#define CHIP_ID			(2)

void do_the_interesting_thing(struct sdm_query_s *sdm_query) {

	int i;
	uint32_t cmd;
	uint32_t result;
	uint32_t ret_x1;
	uint32_t ret_x2;
	uint32_t ret_x3;
	uint64_t start_time;
	uint64_t end_time;

	for(i = 0 ; i < 3 ; i++) {

		/* select the command to issue */
		switch(i) {
			case FIRMWARE_VERSION :
				cmd = SMC_CMD_SDM_FIRM_VER;
				break;
			case JTAG_USERCODE :
				cmd = SMC_CMD_GET_USERCODE;
				break;
			case CHIP_ID :
				cmd = SMC_CMD_GET_CHIPID;
				break;
		}

		/* mark the time */
		asm volatile (
			"mrs %[start_time], cntpct_el0\n"
			: [start_time] "=r" (start_time)
		);

		/* read value from sdm */
		asm volatile (
			"mov x0, %[cmd]\n"
			"mov x1, #0\n"
			"mov x2, #0\n"
			"mov x3, #0\n"
			"mov x4, #0\n"
			"mov x5, #0\n"
			"mov x6, #0\n"
			"smc #0\n"
			"mov %[result], x0\n"
			"mov %[ret_x1], x1\n"
			"mov %[ret_x2], x2\n"
			"mov %[ret_x3], x3\n"
			:
			[result] "=r" (result),
			[ret_x1] "=r" (ret_x1),
			[ret_x2] "=r" (ret_x2),
			[ret_x3] "=r" (ret_x3)
			:
			[cmd]    "r" (cmd)
			: "x0", "x1", "x2", "x3", "x4", "x5", "x6"
		);

		/* mark the time */
		asm volatile (
			"mrs %[end_time], cntpct_el0\n"
			: [end_time] "=r" (end_time)
		);

		/* save the results */
		switch(i) {
			case FIRMWARE_VERSION :
				sdm_query->firm_ver_result = result;
				sdm_query->firm_ver_value = ret_x1;
				sdm_query->firm_ver_time_delta =
							end_time - start_time;
				break;
			case JTAG_USERCODE :
				sdm_query->usercode_result = result;
				sdm_query->usercode_value = ret_x1;
				sdm_query->usercode_time_delta =
							end_time - start_time;
				break;
			case CHIP_ID :
				sdm_query->chipid_result = result;
				sdm_query->chipid_mbox_err = ret_x1;
				sdm_query->chipid_id_lo = ret_x2;
				sdm_query->chipid_id_hi = ret_x3;
				sdm_query->chipid_time_delta =
							end_time - start_time;
				break;
		}
	}
}

