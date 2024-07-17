/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
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

void do_the_interesting_thing(struct hps_uart_s *hps_uart);

int uart(int argc, char *const argv[])
{
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	struct hps_uart_s hps_uart = {0};

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
	do_the_interesting_thing(&hps_uart);

	/* print the results */
	puts("\n");
	printf ("HPS UART Demo\n");
	puts("\n");

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
	puts("\n");

	printf("uart_time_loop = ");
	ns_time = (hps_uart.uart_time_loop * 1000000000) / cntfrq_el0;
	ps_time = (hps_uart.uart_time_loop * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9lld.%03lldns\n", ns_time, ps_time);

	printf(" tx_value_loop = 0x%016llX\n", hps_uart.tx_value_loop);
	printf(" rx_value_loop = 0x%016llX\n", hps_uart.rx_value_loop);
	printf("xor_value_loop = 0x%016llX\n", hps_uart.tx_value_loop ^
							hps_uart.rx_value_loop);

	puts("\n");
	printf("uart_time_fpga = ");
	ns_time = (hps_uart.uart_time_fpga * 1000000000) / cntfrq_el0;
	ps_time = (hps_uart.uart_time_fpga * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9lld.%03lldns\n", ns_time, ps_time);

	printf(" tx_value_fpga = 0x%016llX\n", hps_uart.tx_value_fpga);
	printf(" rx_value_fpga = 0x%016llX\n", hps_uart.rx_value_fpga);
	printf("xor_value_fpga = 0x%016llX\n", hps_uart.tx_value_fpga ^
							hps_uart.rx_value_fpga);

	puts("\n");
	printf ("Press any key to exit this demo.");

	/* wait for console input */
	while (!tstc());

	/* discard the input */
	(void) getc();

	printf ("\n\n");
	return 0;
}

void do_the_interesting_thing(struct hps_uart_s *hps_uart) {

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

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0;
	gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

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
		"mrs %[tx_value], cntpct_el0\n"
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
	per1modrst = *((volatile uint32_t *)(PER1MODRST_BASE));
	*((volatile uint32_t *)(PER1MODRST_BASE)) =
					per1modrst & (~PER1MODRST_THE_UART);

	asm volatile (
		"dsb sy\n"
	);

	/* set srr */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_SRR_OFST)) = 0x01;

	/* create a timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	do {
		asm volatile (
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
	} while(temp < timeout);

	/* set dlab in lcr */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_LCR_OFST)) = 0x83;
	/* set dll - 115200 baud */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_RBR_OFST)) = 0x36;
	/* set dlh - 115200 baud */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_IER_OFST)) = 0x00;
	/* set lcr */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_LCR_OFST)) = 0x03;
	/* set mcr */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_MCR_OFST)) = 0x13;

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* create a timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	/* transmit and receive 8 characters */
	while((tx_value_index < 8) || (rx_value_index < 8)) {

		asm volatile (
			"dsb sy\n"
		);

		lsr = *((volatile uint32_t *)(THE_UART_BASE +
							HPS_UART_LSR_OFST));

		if(((lsr & HPS_UART_LSR_THRE) == HPS_UART_LSR_THRE) &&
							(tx_value_index < 8))
			*((volatile uint32_t *)(THE_UART_BASE +
			HPS_UART_RBR_OFST)) = tx_value_ptr[tx_value_index++];

		if(((lsr & HPS_UART_LSR_DR) == HPS_UART_LSR_DR) &&
							(rx_value_index < 8))
			rx_value_ptr[rx_value_index++] =
				(*((volatile uint32_t *)(THE_UART_BASE +
							HPS_UART_RBR_OFST)));

		asm volatile (
			"mrs %[temp], cntpct_el0\n"
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
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_uart->uart_time_loop = end_time - start_time;
	hps_uart->tx_value_loop = tx_value;
	hps_uart->rx_value_loop = rx_value;

	/* capture current time and configure the tx/rx pointer and index */
	asm volatile (
		"mrs %[tx_value], cntpct_el0\n"
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
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_SRR_OFST)) = 0x01;

	/* create a timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	do {
		asm volatile (
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
	} while(temp < timeout);

	/* set dlab in lcr */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_LCR_OFST)) = 0x83;
	/* set dll - 115200 baud */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_RBR_OFST)) = 0x36;
	/* set dlh - 115200 baud */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_IER_OFST)) = 0x00;
	/* set lcr */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_LCR_OFST)) = 0x03;
	/* set mcr */
	*((volatile uint32_t *)(THE_UART_BASE + HPS_UART_MCR_OFST)) = 0x03;

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* create a timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	/* transmit and receive 8 characters */
	while((tx_value_index < 8) || (rx_value_index < 8)) {

		asm volatile (
			"dsb sy\n"
		);

		lsr = *((volatile uint32_t *)(THE_UART_BASE +
							HPS_UART_LSR_OFST));

		if(((lsr & HPS_UART_LSR_THRE) == HPS_UART_LSR_THRE) &&
							(tx_value_index < 8))
			*((volatile uint32_t *)(THE_UART_BASE +
			HPS_UART_RBR_OFST)) = tx_value_ptr[tx_value_index++];

		if(((lsr & HPS_UART_LSR_DR) == HPS_UART_LSR_DR) &&
							(rx_value_index < 8))
			rx_value_ptr[rx_value_index++] =
				(*((volatile uint32_t *)(THE_UART_BASE +
							HPS_UART_RBR_OFST)));

		asm volatile (
			"mrs %[temp], cntpct_el0\n"
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
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_uart->uart_time_fpga = end_time - start_time;
	hps_uart->tx_value_fpga = tx_value;
	hps_uart->rx_value_fpga = rx_value;

	/* restore original per1modrst register value */
	*((volatile uint32_t *)(PER1MODRST_BASE)) = per1modrst;
}

