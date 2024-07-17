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
#include <errno.h>
#include "uio_helpers.h"
#include "standalone_common.h"
#include "select_uart.h"

struct hps_uart_s {
	uint32_t gp_sig_value;
	uint64_t uart_time_fpga;
	uint64_t tx_value_fpga;
	uint64_t rx_value_fpga;
};

void do_the_interesting_thing(struct hps_uart_s *, struct uio_map_s *);

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
	struct hps_uart_s hps_uart = {0};
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
	do_the_interesting_thing(&hps_uart, &hps_gp_uio_map);

	/* print the results */
	puts("");
	printf ("HPS UART Demo\n");
	puts("");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
					hps_uart.gp_sig_value,
					(hps_uart.gp_sig_value >>  0) & 0xFF,
					(hps_uart.gp_sig_value >>  8) & 0xFF,
					(hps_uart.gp_sig_value >> 16) & 0xFF,
					(hps_uart.gp_sig_value >> 24) & 0xFF);
	puts("");

	printf("uart_time_fpga = ");
	ns_time = (hps_uart.uart_time_fpga * 1000000000) / cntfrq_el0;
	ps_time = (hps_uart.uart_time_fpga * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9ld.%03ldns\n", ns_time, ps_time);

	printf(" tx_value_fpga = 0x%016lX\n", hps_uart.tx_value_fpga);
	printf(" rx_value_fpga = 0x%016lX\n", hps_uart.rx_value_fpga);
	printf("xor_value_fpga = 0x%016lX\n", hps_uart.tx_value_fpga ^
							hps_uart.rx_value_fpga);

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

void do_the_interesting_thing(struct hps_uart_s *hps_uart,
					struct uio_map_s *map) {

	uint32_t gp_in;
	uint64_t tx_value;
	uint64_t rx_value;
	uint8_t *tx_value_ptr;
	uint8_t *rx_value_ptr;
	int tx_value_index;
	int rx_value_index;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t timeout;
	uint64_t temp;
	int result;
	int uart_fd;
	struct termios orig_attr;
	struct termios new_attr;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_OUT_BASE & 0xFFF))) = 0;
	gp_in = *((volatile uint32_t *)(map->uio_mmap_addr +
						(HPS_GP_IN_BASE & 0xFFF)));

	hps_uart->gp_sig_value = gp_in;

	if(gp_in != UART_SIG)
		return;

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* capture current time and configure the tx/rx pointer and index */
	asm volatile (
		"mrs %[tx_value], cntvct_el0\n"
		: [tx_value] "=r" (tx_value)
	);
	tx_value = tx_value ^ (tx_value << 32);
	tx_value ^= 0x1122334455667788;
	rx_value  = 0x0000000000000000;
	tx_value_ptr = (uint8_t*)(&tx_value);
	rx_value_ptr = (uint8_t*)(&rx_value);
	tx_value_index = 0;
	rx_value_index = 0;

	/* open the non-console UART */
	uart_fd = open("/dev/ttyS1", O_RDWR | O_SYNC | O_NONBLOCK);
	if(uart_fd < 0) {
		puts("ERROR: opening /dev/ttyS1");
		exit(EXIT_FAILURE);
	}

	/* adjust termios so we see each character input and no echo */
	tcgetattr(uart_fd, &orig_attr);
	cfmakeraw(&new_attr);
	cfsetospeed(&new_attr, B115200);
	cfsetispeed(&new_attr, B115200);
	new_attr.c_cflag |= CREAD | CLOCAL;
	new_attr.c_cflag &= ~(CRTSCTS);
	new_attr.c_iflag &= ~(IXOFF);
	new_attr.c_cc[VTIME] = 0;
	new_attr.c_cc[VMIN] = 0;
	if(tcsetattr(uart_fd, TCSANOW, &new_attr) != 0) {
		puts("ERROR: tcsetattr");
		exit(EXIT_FAILURE);
	}

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* create a timeout after 100ms */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 10);

	/* transmit and receive 8 characters */
	while((tx_value_index < 8) || (rx_value_index < 8)) {

		if(tx_value_index < 8) {
			result = write(uart_fd, &tx_value_ptr[tx_value_index],
							(8 - tx_value_index));
			if(result < 0) {
				if((errno != EAGAIN) ||
						(errno != EWOULDBLOCK)) {
					perror("ERROR: writing /dev/ttyS1");
					exit(EXIT_FAILURE);
				}
			} else {
				tx_value_index += result;
				if(tcdrain(uart_fd) != 0) {
					puts("ERROR: tcdrain");
					exit(EXIT_FAILURE);
				}
			}
		}

		if(rx_value_index < 8) {
			result = read(uart_fd, &rx_value_ptr[rx_value_index],
							(8 - rx_value_index));
			if(result < 0) {
				if((errno != EAGAIN) ||
						(errno != EWOULDBLOCK)) {
					perror("ERROR: reading /dev/ttyS1");
					exit(EXIT_FAILURE);
				}
			} else {
				rx_value_index += result;
			}
		}

		asm volatile (
			"mrs %[temp], cntvct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout)
			break;
	}

	asm volatile (
		"dsb sy\n"
	);

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntvct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* restore termios */
	tcsetattr(uart_fd, TCSANOW, &orig_attr);

	/* save the results */
	hps_uart->uart_time_fpga = end_time - start_time;
	hps_uart->tx_value_fpga = tx_value;
	hps_uart->rx_value_fpga = rx_value;

	if(close(uart_fd) != 0) {
		puts("ERROR: close uart_fd");
		exit(EXIT_FAILURE);
	}
}
