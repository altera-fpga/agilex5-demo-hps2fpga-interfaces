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
#include "select_uart.h"

struct hps_uart_s {
	uint32_t gp_sig_value;
	uint64_t uart_time_loop;
	uint64_t tx_value_loop;
	uint64_t rx_value_loop;
	uint64_t uart_time_fpga;
	uint64_t tx_value_fpga;
	uint64_t rx_value_fpga;
};

void do_the_interesting_thing(struct hps_uart_s *, struct uio_map_s *,
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
	struct hps_uart_s hps_uart = {0};
	struct uio_map_s hps_gp_uio_map;
	struct uio_map_s rst_mgr_uio_map;
	struct uio_map_s uart_uio_map;
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

	/* configure struct for rst-mgr-uio device */
	rst_mgr_uio_map.uio_name = "rst-mgr-uio";
	rst_mgr_uio_map.uio_length = getpagesize();
	rst_mgr_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	rst_mgr_uio_map.uio_flags = MAP_SHARED;
	rst_mgr_uio_map.uio_offset = 0;

	/* find the rst-mgr-uio device */
	result = find_uio_index(&rst_mgr_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the rst-mgr-uio device */
	result = mmap_uio(&rst_mgr_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* configure struct for uart-uio device */
	uart_uio_map.uio_name = "uart-uio";
	uart_uio_map.uio_length = getpagesize();
	uart_uio_map.uio_prot = PROT_READ | PROT_WRITE;
	uart_uio_map.uio_flags = MAP_SHARED;
	uart_uio_map.uio_offset = 0;

	/* find the uart-uio device */
	result = find_uio_index(&uart_uio_map);
	if(result != 0) {
		printf("ERROR: find_uio_index : %d\n", result);
		return 1;
	}

	/* open and map the uart-uio device */
	result = mmap_uio(&uart_uio_map);
	if(result != 0) {
		printf("ERROR: mmap_uio : %d\n", result);
		return 1;
	}

	/* do the interesting thing that this example demonstrates */
	do_the_interesting_thing(&hps_uart, &hps_gp_uio_map, &rst_mgr_uio_map,
								&uart_uio_map);

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

	printf("uart_time_loop = ");
	ns_time = (hps_uart.uart_time_loop * 1000000000) / cntfrq_el0;
	ps_time = (hps_uart.uart_time_loop * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9ld.%03ldns\n", ns_time, ps_time);

	printf(" tx_value_loop = 0x%016lX\n", hps_uart.tx_value_loop);
	printf(" rx_value_loop = 0x%016lX\n", hps_uart.rx_value_loop);
	printf("xor_value_loop = 0x%016lX\n", hps_uart.tx_value_loop ^
							hps_uart.rx_value_loop);

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
					struct uio_map_s *map,
					struct uio_map_s *rst_mgr_map,
					struct uio_map_s *uart_map) {

	uint32_t gp_in;
	uint32_t lsr;
	uint32_t per1modrst;
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
	void *per1modrst_base = (rst_mgr_map->uio_mmap_addr +
					(PER1MODRST_BASE & 0xFFF));
	void *the_uart_base = (uart_map->uio_mmap_addr +
					(THE_UART_BASE & 0xFFF));

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

	/* release uart1 from reset */
	per1modrst = *((volatile uint32_t *)(per1modrst_base));
	*((volatile uint32_t *)(per1modrst_base)) =
					per1modrst & (~PER1MODRST_THE_UART);

	asm volatile (
		"dsb sy\n"
	);

	/* set srr */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_SRR_OFST)) = 0x01;

	/* create a timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	do {
		asm volatile (
			"mrs %[temp], cntvct_el0\n"
			: [temp] "=r" (temp)
		);
	} while(temp < timeout);

	/* set dlab in lcr */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_LCR_OFST)) = 0x83;
	/* set dll - 115200 baud */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_RBR_OFST)) = 0x36;
	/* set dlh - 115200 baud */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_IER_OFST)) = 0x00;
	/* set lcr */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_LCR_OFST)) = 0x03;
	/* set mcr */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_MCR_OFST)) = 0x13;

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* create a timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	/* transmit and receive 8 characters */
	while((tx_value_index < 8) || (rx_value_index < 8)) {

		asm volatile (
			"dsb sy\n"
		);

		lsr = *((volatile uint32_t *)(the_uart_base +
							HPS_UART_LSR_OFST));

		if(((lsr & HPS_UART_LSR_THRE) == HPS_UART_LSR_THRE) &&
							(tx_value_index < 8))
			*((volatile uint32_t *)(the_uart_base +
			HPS_UART_RBR_OFST)) = tx_value_ptr[tx_value_index++];

		if(((lsr & HPS_UART_LSR_DR) == HPS_UART_LSR_DR) &&
							(rx_value_index < 8))
			rx_value_ptr[rx_value_index++] =
				(*((volatile uint32_t *)(the_uart_base +
							HPS_UART_RBR_OFST)));

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

	/* save the results */
	hps_uart->uart_time_loop = end_time - start_time;
	hps_uart->tx_value_loop = tx_value;
	hps_uart->rx_value_loop = rx_value;

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

	/* set srr */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_SRR_OFST)) = 0x01;

	/* create a timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	do {
		asm volatile (
			"mrs %[temp], cntvct_el0\n"
			: [temp] "=r" (temp)
		);
	} while(temp < timeout);

	/* set dlab in lcr */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_LCR_OFST)) = 0x83;
	/* set dll - 115200 baud */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_RBR_OFST)) = 0x36;
	/* set dlh - 115200 baud */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_IER_OFST)) = 0x00;
	/* set lcr */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_LCR_OFST)) = 0x03;
	/* set mcr */
	*((volatile uint32_t *)(the_uart_base + HPS_UART_MCR_OFST)) = 0x03;

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntvct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* create a timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntvct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	/* transmit and receive 8 characters */
	while((tx_value_index < 8) || (rx_value_index < 8)) {

		asm volatile (
			"dsb sy\n"
		);

		lsr = *((volatile uint32_t *)(the_uart_base +
							HPS_UART_LSR_OFST));

		if(((lsr & HPS_UART_LSR_THRE) == HPS_UART_LSR_THRE) &&
							(tx_value_index < 8))
			*((volatile uint32_t *)(the_uart_base +
			HPS_UART_RBR_OFST)) = tx_value_ptr[tx_value_index++];

		if(((lsr & HPS_UART_LSR_DR) == HPS_UART_LSR_DR) &&
							(rx_value_index < 8))
			rx_value_ptr[rx_value_index++] =
				(*((volatile uint32_t *)(the_uart_base +
							HPS_UART_RBR_OFST)));

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

	/* save the results */
	hps_uart->uart_time_fpga = end_time - start_time;
	hps_uart->tx_value_fpga = tx_value;
	hps_uart->rx_value_fpga = rx_value;

	/* restore original per1modrst register value */
	*((volatile uint32_t *)(per1modrst_base)) = per1modrst;
}

