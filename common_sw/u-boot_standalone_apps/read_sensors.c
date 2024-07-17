/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct sensors_s {
	char *name;
	uint32_t sensor_type;	/* 0 = volt : 1 = temp */
	uint32_t sensor_loc;
	uint32_t sensor_val;
	uint64_t read_time_delta;
};

#define VOLT_SENSOR	(0)
#define TEMP_SENSOR	(1)

void do_the_interesting_thing(struct sensors_s *sensors);

int read_sensors(int argc, char *const argv[])
{
	int i;
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	struct sensors_s sensors[] = {
		{              "VSIGP", VOLT_SENSOR, 0x00000001, 0, 0 },
		{              "VSIGN", VOLT_SENSOR, 0x00000002, 0, 0 },
		{                "VCC", VOLT_SENSOR, 0x00000004, 0, 0 },
		{          "VCCIO_SDM", VOLT_SENSOR, 0x00000008, 0, 0 },
		{              "VCCPT", VOLT_SENSOR, 0x00000010, 0, 0 },
		{           "VCCRCORE", VOLT_SENSOR, 0x00000020, 0, 0 },
		{           "VCCH_SDM", VOLT_SENSOR, 0x00000040, 0, 0 },
		{           "VCCL_SDM", VOLT_SENSOR, 0x00000080, 0, 0 },
		{             "VCCADC", VOLT_SENSOR, 0x00000200, 0, 0 },
		{                "SDM", TEMP_SENSOR, 0x00000001, 0, 0 },
		{     "LOWER LEFT MAX", TEMP_SENSOR, 0x00010001, 0, 0 },
		{  "LOWER LEFT CORNER", TEMP_SENSOR, 0x00010002, 0, 0 },
		{  "LOWER LEFT XCVR 2", TEMP_SENSOR, 0x00010004, 0, 0 },
		{  "LOWER LEFT XCVR 3", TEMP_SENSOR, 0x00010008, 0, 0 },
		{  "LOWER LEFT CENTER", TEMP_SENSOR, 0x00010010, 0, 0 },
		{    "LOWER RIGHT MAX", TEMP_SENSOR, 0x00030001, 0, 0 },
		{ "LOWER RIGHT CORNER", TEMP_SENSOR, 0x00030002, 0, 0 },
		{ "LOWER RIGHT XCVR 2", TEMP_SENSOR, 0x00030004, 0, 0 },
		{ "LOWER RIGHT XCVR 3", TEMP_SENSOR, 0x00030008, 0, 0 },
		{    "UPPER RIGHT MAX", TEMP_SENSOR, 0x00040001, 0, 0 },
		{ "UPPER RIGHT CORNER", TEMP_SENSOR, 0x00040002, 0, 0 },
		{ "UPPER RIGHT XCVR 2", TEMP_SENSOR, 0x00040004, 0, 0 },
		{ "UPPER RIGHT XCVR 3", TEMP_SENSOR, 0x00040008, 0, 0 },
		{ "UPPER RIGHT CENTER", TEMP_SENSOR, 0x00040010, 0, 0 },
		{                "HPS", TEMP_SENSOR, 0x00040020, 0, 0 },
		{                 NULL, 0, 0, 0, 0 }
	};

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
	do_the_interesting_thing(sensors);

	/* print the results */
	puts("\n");
	printf ("Reading Sensors Demo\n");
	puts("\n");
	puts("    Sensor Name     |    Value   |  Value   |   Access Time\n");
	puts("--------------------+------------+----------+----------------\n");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	i = 0;
	while(sensors[i].name != NULL) {
		printf("%20s: ", sensors[i].name);
		if(sensors[i].sensor_type == VOLT_SENSOR) {

			printf("0x%08X : ", sensors[i].sensor_val);

			printf("%3d.%03d V: ",
				sensors[i].sensor_val / 0x00010000,
				((sensors[i].sensor_val % 0x00010000) * 1000)
								/ 0x00010000);

			ns_time = (sensors[i].read_time_delta * 1000000000)
								/ cntfrq_el0;
			ps_time = (sensors[i].read_time_delta * 1000000000)
								% cntfrq_el0;
			ps_time *= 1000;
			ps_time /= cntfrq_el0;
			printf("%lld.%03lld ns\n", ns_time, ps_time);

		} else if(sensors[i].sensor_type == TEMP_SENSOR) {

			printf("0x%08X : ", sensors[i].sensor_val);

			if(
				(sensors[i].sensor_val >= 0x80000000) &&
				(sensors[i].sensor_val <= 0x800000FF)
			  ) {
				puts(" ERROR   : ");
			} else {
				printf("%3d.%03d C: ",
					sensors[i].sensor_val / 0x00000100,
					((sensors[i].sensor_val % 0x00000100)
							* 1000) / 0x00000100);
			}

			ns_time = (sensors[i].read_time_delta * 1000000000)
								/ cntfrq_el0;
			ps_time = (sensors[i].read_time_delta * 1000000000)
								% cntfrq_el0;
			ps_time *= 1000;
			ps_time /= cntfrq_el0;
			printf("%lld.%03lld ns\n", ns_time, ps_time);

		} else {
			puts("ERROR: bad sensor type");
		}

		i++;
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

void do_the_interesting_thing(struct sensors_s *sensors) {

	int i;
	uint32_t cmd;
	uint32_t sensor_loc;
	uint32_t result;
	uint32_t sensor_val;
	uint64_t start_time;
	uint64_t end_time;

	i = 0;
	while(sensors[i].name != NULL) {

		/* select the command to issue */
		if(sensors[i].sensor_type == VOLT_SENSOR)
			cmd = SMC_CMD_HWMON_READVOLT;
		else if(sensors[i].sensor_type == TEMP_SENSOR)
			cmd = SMC_CMD_HWMON_READTEMP;
		else {
			sensors[i].sensor_val = 0;
			sensors[i].read_time_delta = 0;
			i++;
			continue;
		}
		sensor_loc = sensors[i].sensor_loc;

		/* mark the time */
		asm volatile (
			"mrs %[start_time], cntpct_el0\n"
			: [start_time] "=r" (start_time)
		);

		/* read sensor value from sdm */
		asm volatile (
			"mov x0, %[cmd]\n"
			"mov x1, %[sensor_loc]\n"
			"mov x2, #0\n"
			"mov x3, #0\n"
			"mov x4, #0\n"
			"mov x5, #0\n"
			"mov x6, #0\n"
			"smc #0\n"
			"mov %[result], x0\n"
			"mov %[sensor_val], x1\n"
			:
			[result]     "=r" (result),
			[sensor_val] "=r" (sensor_val)
			:
			[cmd]        "r" (cmd),
			[sensor_loc] "r" (sensor_loc)
			: "x0", "x1", "x2", "x3", "x4", "x5", "x6"
		);

		/* mark the time */
		asm volatile (
			"mrs %[end_time], cntpct_el0\n"
			: [end_time] "=r" (end_time)
		);

		/* save the results */
		if(result != 0) {
			sensors[i].sensor_val = 0;
			sensors[i].read_time_delta = 0;
		} else {
			sensors[i].sensor_val = sensor_val;
			sensors[i].read_time_delta = end_time - start_time;
		}
		i++;
	}
}

