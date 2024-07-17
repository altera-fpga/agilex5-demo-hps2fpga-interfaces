/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <termios.h>
#include <errno.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>
#include "uio_helpers.h"
#include "standalone_common.h"

/* I2C specific defines */
#define I2C_SLAVE_ADDR	(0x55)

struct hps_i2c_s {
	uint32_t gp_sig_value;
	uint64_t i2c_write_reg32_time;
	uint64_t i2c_write_reg32_error;
	uint64_t i2c_write_reg32_value;
	uint64_t i2c_read_reg32_time;
	uint64_t i2c_read_reg32_error;
	uint64_t i2c_read_reg32_value;
	uint64_t i2c_write_image_time;
	uint64_t i2c_write_image_error;
	uint64_t i2c_read_image_time;
	uint64_t i2c_read_image_error;
	uint64_t i2c_image_compare_error;
};

void do_the_interesting_thing(struct hps_i2c_s *, struct uio_map_s *);

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
	struct hps_i2c_s hps_i2c = {0};
	struct uio_map_s hps_gp_uio_map;
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

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&hps_i2c, &hps_gp_uio_map);

	/* print the results */
	puts("");
	printf ("HPS I2C Bridge Demo\n");
	puts("");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
					hps_i2c.gp_sig_value,
					(hps_i2c.gp_sig_value >>  0) & 0xFF,
					(hps_i2c.gp_sig_value >>  8) & 0xFF,
					(hps_i2c.gp_sig_value >> 16) & 0xFF,
					(hps_i2c.gp_sig_value >> 24) & 0xFF);
	puts("");
	printf("I2C Write reg32 Operation\n");
	printf("         Operation: %13s\n",
		(hps_i2c.i2c_write_reg32_error == 0) ?
			"SUCCESSFUL" : "FAILED");
	printf("              Time: ");
	ns_time = (hps_i2c.i2c_write_reg32_time * 1000000000) / cntfrq_el0;
	ps_time = (hps_i2c.i2c_write_reg32_time * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9ld.%03ldns\n", ns_time, ps_time);
	printf("             Value:    0x%08X\n",
		(uint32_t)(hps_i2c.i2c_write_reg32_value));

	puts("");
	printf("I2C Read reg32 Operation\n");
	printf("         Operation: %13s\n",
		(hps_i2c.i2c_read_reg32_error == 0) ? "SUCCESSFUL" : "FAILED");
	printf("              Time: ");
	ns_time = (hps_i2c.i2c_read_reg32_time * 1000000000) / cntfrq_el0;
	ps_time = (hps_i2c.i2c_read_reg32_time * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9ld.%03ldns\n", ns_time, ps_time);
	printf("             Value:    0x%08X\n",
		(uint32_t)(hps_i2c.i2c_read_reg32_value));

	puts("");
	printf("I2C 4KB Write Read Operation\n");
	printf("   Write Operation: %13s\n",
		(hps_i2c.i2c_write_image_error == 0) ?
			"SUCCESSFUL" : "FAILED");
	printf("        Write Time: ");
	ns_time = (hps_i2c.i2c_write_image_time * 1000000000) / cntfrq_el0;
	ps_time = (hps_i2c.i2c_write_image_time * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9ld.%03ldns\n", ns_time, ps_time);

	printf("    Read Operation: %13s\n",
		(hps_i2c.i2c_read_image_error == 0) ? "SUCCESSFUL" : "FAILED");
	printf("         Read Time: ");
	ns_time = (hps_i2c.i2c_read_image_time * 1000000000) / cntfrq_el0;
	ps_time = (hps_i2c.i2c_read_image_time * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9ld.%03ldns\n", ns_time, ps_time);

	printf("   Data Comparison: %13s\n",
		(hps_i2c.i2c_image_compare_error == 0) ?
			"SUCCESSFUL" : "FAILED");

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

int i2c_write_image(uint32_t write_addr, uint8_t *write_data,
					uint32_t write_size, int i2c0_fd);
int i2c_write_reg32(uint32_t write_addr, uint32_t write_data, int i2c0_fd);
int i2c_read_reg32(uint32_t read_addr, uint32_t *read_data, int i2c0_fd);

void do_the_interesting_thing(struct hps_i2c_s *hps_i2c,
					struct uio_map_s *map) {

	int i;
	int result;
	uint32_t gp_in;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t tx_value_64;
	uint32_t tx_value;
	uint32_t rx_value;
	uint8_t tx_pattern[4 * 1024] = {0};
	uint8_t rx_pattern[4 * 1024] = {0};
	int i2c0_fd;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	hps_i2c->gp_sig_value = gp_in;

	if(gp_in != IAMB_SIG)
		return;

/* configure the i2c controller */
	/* open the non-console UART */
	i2c0_fd = open("/dev/i2c-0", O_RDWR | O_SYNC);
	if(i2c0_fd < 0) {
		puts("ERROR: opening /dev/i2c-0");
		return;
	}



/* perform a 32-bit write and read back through i2c bridge hardware */

	/* capture current time and create a unique value with it */
	asm volatile (
		"mrs %[tx_value_64], cntvct_el0\n"
		: [tx_value_64] "=r" (tx_value_64)
	);
	tx_value_64 = tx_value_64 ^ (tx_value_64 << 32);
	tx_value_64 ^= 0x1122334455667788;
	tx_value = (uint32_t)(tx_value_64);

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	result = i2c_write_reg32(0, tx_value, i2c0_fd);

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_i2c->i2c_write_reg32_time = end_time - start_time;
	if(result == 0)
		hps_i2c->i2c_write_reg32_error = 0;
	else
		hps_i2c->i2c_write_reg32_error = 1;

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	result = i2c_read_reg32(0, &rx_value, i2c0_fd);

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_i2c->i2c_read_reg32_time = end_time - start_time;
	if(result == 0)
		hps_i2c->i2c_read_reg32_error = 0;
	else
		hps_i2c->i2c_read_reg32_error = 1;

	hps_i2c->i2c_write_reg32_value = tx_value;
	hps_i2c->i2c_read_reg32_value  = rx_value;

/* write 4KB and read back through the i2c bridge hardware */

	for(i = 0 ; i < 4048 ; i += 8) {
		tx_value_64 += 0x0305070B0D111317;
		*(volatile uint64_t*)(&tx_pattern[i]) = tx_value_64;
	}

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	result = i2c_write_image(0x0, &tx_pattern[0], 4 * 1024, i2c0_fd);

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_i2c->i2c_write_image_time = end_time - start_time;
	if(result == 0)
		hps_i2c->i2c_write_image_error = 0;
	else
		hps_i2c->i2c_write_image_error = 1;

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	for(i = 0 ; i < 4096 ; i += 4) {
		result = i2c_read_reg32(i, &rx_value, i2c0_fd);
		if(result != 0)
			break;

		*(volatile uint32_t*)(&rx_pattern[i]) = rx_value;
	}

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_i2c->i2c_read_image_time = end_time - start_time;
	if(result == 0)
		hps_i2c->i2c_read_image_error = 0;
	else
		hps_i2c->i2c_read_image_error = 1;

	result = memcmp(rx_pattern, tx_pattern, 4 * 1024);
	if(result != 0)
		hps_i2c->i2c_image_compare_error = 1;
	else
		hps_i2c->i2c_image_compare_error = 0;

	if(close(i2c0_fd) != 0) {
		puts("ERROR: close i2c0_fd");
		exit(EXIT_FAILURE);
	}
}

/* This routine writes an arbitrary amount of data to a 32-bit aligned address.
 */
int i2c_write_image(uint32_t write_addr, uint8_t *write_data,
					uint32_t write_size, int i2c0_fd) {

	int result;
	uint32_t i;
	uint8_t i2c_message[(2 * 1024) + 4];
	struct i2c_rdwr_ioctl_data transaction;
	struct i2c_msg message;

	uint32_t cur_addr;
	uint8_t *cur_data;
	uint32_t cur_size;
	uint32_t rem_size;

	/* validate input address */
	if((write_addr & 0x3) != 0)
		return 1;

	cur_addr = write_addr;
	cur_data = write_data;
	rem_size = write_size;

	while(rem_size > 0) {

		if(rem_size >= (2 * 1024))
			cur_size = 2 * 1024;
		else
			cur_size = rem_size;

		rem_size -= cur_size;

		/* create i2c message */
		i2c_message[0] = (cur_addr >> 24) & 0xFF;	// addr[3]
		i2c_message[1] = (cur_addr >> 16) & 0xFF;	// addr[2]
		i2c_message[2] = (cur_addr >>  8) & 0xFF;	// addr[1]
		i2c_message[3] = (cur_addr >>  0) & 0xFF;	// addr[0]

		cur_addr += cur_size;

		for(i = 0 ; i < cur_size ; i++) {
			i2c_message[4 + i]  = *cur_data++;
		}

		/* run I2C transaction */
		message.addr  = I2C_SLAVE_ADDR;
		message.flags = 0;
		message.len   = cur_size + 4;
		message.buf   = i2c_message;

		transaction.msgs  = &message;
		transaction.nmsgs = 1;

		result = ioctl(i2c0_fd, I2C_RDWR, &transaction);
		if(result < 0) {
			printf("i2c_write_image I2C_RDWR - %d\n", errno);
			return 1;
		}
	}
	return 0;
}

/* This routine writes one 32-bit word of data to a 32-bit aligned address.
 */
int i2c_write_reg32(uint32_t write_addr, uint32_t write_data,int i2c0_fd) {

	int result;
	struct i2c_rdwr_ioctl_data transaction;
	struct i2c_msg message;

	uint8_t i2c_message[8];

	/* validate input address */
	if((write_addr & 0x3) != 0)
		return 1;

	/* create i2c message */
	i2c_message[0] = (write_addr >> 24) & 0xFF;	// addr[3]
	i2c_message[1] = (write_addr >> 16) & 0xFF;	// addr[2]
	i2c_message[2] = (write_addr >>  8) & 0xFF;	// addr[1]
	i2c_message[3] = (write_addr >>  0) & 0xFF;	// addr[0]

	i2c_message[4] = (write_data >>  0) & 0xFF;	// data[0]
	i2c_message[5] = (write_data >>  8) & 0xFF;	// data[1]
	i2c_message[6] = (write_data >> 16) & 0xFF;	// data[2]
	i2c_message[7] = (write_data >> 24) & 0xFF;	// data[3]

	/* run I2C transaction */
	message.addr  = I2C_SLAVE_ADDR;
	message.flags = 0;
	message.len   = 8;
	message.buf   = i2c_message;

	transaction.msgs  = &message;
	transaction.nmsgs = 1;

	result = ioctl(i2c0_fd, I2C_RDWR, &transaction);
	if(result < 0) {
		printf("i2c_write_reg32 I2C_RDWR - %d\n", errno);
		return 1;
	}

	return 0;
}

/* This routine reads one 32-bit word of data from a 32-bit aligned address.
 */
int i2c_read_reg32(uint32_t read_addr, uint32_t *read_data, int i2c0_fd) {

	int result;
	struct i2c_rdwr_ioctl_data transaction;
	struct i2c_msg message[2];

	uint8_t i2c_message[4];
	uint32_t the_read_data;

	/* validate input address */
	if((read_addr & 0x3) != 0)
		return 1;

	/* create i2c message */
	i2c_message[0] = (read_addr >> 24) & 0xFF;	// addr[3]
	i2c_message[1] = (read_addr >> 16) & 0xFF;	// addr[2]
	i2c_message[2] = (read_addr >>  8) & 0xFF;	// addr[1]
	i2c_message[3] = (read_addr >>  0) & 0xFF;	// addr[0]

	/* run I2C transaction */
	message[0].addr  = I2C_SLAVE_ADDR;
	message[0].flags = 0;
	message[0].len   = 4;
	message[0].buf   = i2c_message;

	message[1].addr  = I2C_SLAVE_ADDR;
	message[1].flags = I2C_M_RD;
	message[1].len   = 4;
	message[1].buf   = (void*)(&the_read_data);

	transaction.msgs  = message;
	transaction.nmsgs = 2;

	result = ioctl(i2c0_fd, I2C_RDWR, &transaction);
	if(result < 0) {
		printf("i2c_read_reg32 I2C_RDWR - %d\n", errno);
		return 1;
	}

	*read_data = the_read_data;

	return 0;
}

