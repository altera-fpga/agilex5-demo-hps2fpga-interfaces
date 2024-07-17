/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct hps_spim_s {
	uint32_t gp_sig_value;
	uint64_t no_trans_error;
	uint64_t no_trans_time;
	uint64_t spi_write_reg32_time;
	uint64_t spi_write_reg32_error;
	uint64_t spi_write_reg32_value;
	uint64_t spi_read_reg32_time;
	uint64_t spi_read_reg32_error;
	uint64_t spi_read_reg32_value;
	uint64_t spi_write_image_time;
	uint64_t spi_write_image_error;
	uint64_t spi_read_image_time;
	uint64_t spi_read_image_error;
	uint64_t spi_image_compare_error;
};

void do_the_interesting_thing(struct hps_spim_s *hps_spim);

int spi_bridge(int argc, char *const argv[])
{
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	struct hps_spim_s hps_spim = {0};

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
	do_the_interesting_thing(&hps_spim);

	/* print the results */
	puts("\n");
	printf ("HPS SPIM bridge Demo\n");
	puts("\n");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
					hps_spim.gp_sig_value,
					(hps_spim.gp_sig_value >>  0) & 0xFF,
					(hps_spim.gp_sig_value >>  8) & 0xFF,
					(hps_spim.gp_sig_value >> 16) & 0xFF,
					(hps_spim.gp_sig_value >> 24) & 0xFF);
	puts("\n");
	printf("No Transaction Operation\n");
	printf("         Operation: %13s\n",
		(hps_spim.no_trans_error == 0) ? "SUCCESSFUL" : "FAILED");
	printf("              Time: ");
	ns_time = (hps_spim.no_trans_time * 1000000000) / cntfrq_el0;
	ps_time = (hps_spim.no_trans_time * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9lld.%03lldns\n", ns_time, ps_time);

	puts("\n");
	printf("SPI Write reg32 Operation\n");
	printf("         Operation: %13s\n",
		(hps_spim.spi_write_reg32_error == 0) ?
			"SUCCESSFUL" : "FAILED");
	printf("              Time: ");
	ns_time = (hps_spim.spi_write_reg32_time * 1000000000) / cntfrq_el0;
	ps_time = (hps_spim.spi_write_reg32_time * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9lld.%03lldns\n", ns_time, ps_time);
	printf("             Value:    0x%08X\n",
		(uint32_t)(hps_spim.spi_write_reg32_value));

	puts("\n");
	printf("SPI Read reg32 Operation\n");
	printf("         Operation: %13s\n",
		(hps_spim.spi_read_reg32_error == 0) ? "SUCCESSFUL" : "FAILED");
	printf("              Time: ");
	ns_time = (hps_spim.spi_read_reg32_time * 1000000000) / cntfrq_el0;
	ps_time = (hps_spim.spi_read_reg32_time * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9lld.%03lldns\n", ns_time, ps_time);
	printf("             Value:    0x%08X\n",
		(uint32_t)(hps_spim.spi_read_reg32_value));

	puts("\n");
	printf("SPI 4KB Write Read Operation\n");
	printf("   Write Operation: %13s\n",
		(hps_spim.spi_write_image_error == 0) ?
			"SUCCESSFUL" : "FAILED");
	printf("        Write Time: ");
	ns_time = (hps_spim.spi_write_image_time * 1000000000) / cntfrq_el0;
	ps_time = (hps_spim.spi_write_image_time * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9lld.%03lldns\n", ns_time, ps_time);

	printf("    Read Operation: %13s\n",
		(hps_spim.spi_read_image_error == 0) ? "SUCCESSFUL" : "FAILED");
	printf("         Read Time: ");
	ns_time = (hps_spim.spi_read_image_time * 1000000000) / cntfrq_el0;
	ps_time = (hps_spim.spi_read_image_time * 1000000000) % cntfrq_el0;
	ps_time *= 1000;
	ps_time /= cntfrq_el0;
	printf("%9lld.%03lldns\n", ns_time, ps_time);

	printf("   Data Comparison: %13s\n",
		(hps_spim.spi_image_compare_error == 0) ?
			"SUCCESSFUL" : "FAILED");

	puts("\n");
	printf ("Press any key to exit this demo.");

	/* wait for console input */
	while (!tstc());

	/* discard the input */
	(void) getc();

	printf ("\n\n");
	return 0;
}

int spi_write_image(uint32_t write_addr, uint8_t *write_data,
							uint32_t write_size);
int spi_write_reg32(uint32_t write_addr, uint32_t write_data);
int spi_read_reg32(uint32_t read_addr, uint32_t *read_data);
int run_no_transaction_command(void);

void do_the_interesting_thing(struct hps_spim_s *hps_spim) {

	int i;
	int result;
	uint32_t gp_in;
	uint32_t per0modrst;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t tx_value_64;
	uint32_t tx_value;
	uint32_t rx_value;
	uint8_t tx_pattern[4 * 1024] = {0};
	uint8_t rx_pattern[4 * 1024] = {0};
	uint64_t timeout;
	uint64_t temp;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0;
	gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	hps_spim->gp_sig_value = gp_in;

	if(gp_in != SAMB_SIG)
		return;

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* release spim0 from reset */
	per0modrst = *((volatile uint32_t *)(PER0MODRST_BASE));
	*((volatile uint32_t *)(PER0MODRST_BASE)) =
					per0modrst & (~PER0MODRST_SPIM0);

	asm volatile (
		"dsb sy\n"
	);

/* configure the spim0 controller */

	/* clear spim ssienr */
	*((volatile uint32_t *)(HPS_SPIM0_BASE + HPS_SPI_SSIENR_OFST)) =
								0x00000000;

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

	/* set spim baudr */
	*((volatile uint32_t *)(HPS_SPIM0_BASE + HPS_SPI_BAUDR_OFST)) =
								0x00000004;
	/* set spim ser */
	*((volatile uint32_t *)(HPS_SPIM0_BASE + HPS_SPI_SER_OFST)) =
								0x00000001;
	/* set spim ctrlr0 */
	*((volatile uint32_t *)(HPS_SPIM0_BASE + HPS_SPI_CTRLR0_OFST)) =
								0x00070040;
	/* set spim ssienr */
	*((volatile uint32_t *)(HPS_SPIM0_BASE + HPS_SPI_SSIENR_OFST)) =
								0x00000001;

/* signal a no-transaction command to the spi bridge hardware */

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	result = run_no_transaction_command();

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_spim->no_trans_time = end_time - start_time;
	if(result == 0)
		hps_spim->no_trans_error = 0;
	else
		hps_spim->no_trans_error = 1;

/* perform a 32-bit write and read back through spi bridge hardware */

	/* capture current time and create a unique value with it */
	asm volatile (
		"mrs %[tx_value_64], cntpct_el0\n"
		: [tx_value_64] "=r" (tx_value_64)
	);
	tx_value_64 = tx_value_64 ^ (tx_value_64 << 32);
	tx_value_64 ^= 0x1122334455667788;
	tx_value = (uint32_t)(tx_value_64);

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	result = spi_write_reg32(0, tx_value);

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_spim->spi_write_reg32_time = end_time - start_time;
	if(result == 0)
		hps_spim->spi_write_reg32_error = 0;
	else
		hps_spim->spi_write_reg32_error = 1;

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	result = spi_read_reg32(0, &rx_value);

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_spim->spi_read_reg32_time = end_time - start_time;
	if(result == 0)
		hps_spim->spi_read_reg32_error = 0;
	else
		hps_spim->spi_read_reg32_error = 1;

	hps_spim->spi_write_reg32_value = tx_value;
	hps_spim->spi_read_reg32_value  = rx_value;

/* write 4KB and read back through the spi bridge hardware */

	for(i = 0 ; i < 4096 ; i += 8) {
		tx_value_64 += 0x0305070B0D111317;
		*(volatile uint64_t*)(&tx_pattern[i]) = tx_value_64;
	}

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	result = spi_write_image(0x0, &tx_pattern[0], 4 * 1024);

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_spim->spi_write_image_time = end_time - start_time;
	if(result == 0)
		hps_spim->spi_write_image_error = 0;
	else
		hps_spim->spi_write_image_error = 1;

	/* mark the time */
	asm volatile (
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	for(i = 0 ; i < 4096 ; i += 4) {
		result = spi_read_reg32(i, &rx_value);
		if(result != 0)
			break;

		*(volatile uint32_t*)(&rx_pattern[i]) = rx_value;
	}

	/* mark the time */
	asm volatile (
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* save the results */
	hps_spim->spi_read_image_time = end_time - start_time;
	if(result == 0)
		hps_spim->spi_read_image_error = 0;
	else
		hps_spim->spi_read_image_error = 1;

	result = memcmp(rx_pattern, tx_pattern, 4 * 1024);
	if(result != 0)
		hps_spim->spi_image_compare_error = 1;
	else
		hps_spim->spi_image_compare_error = 0;

	/* restore original per1modrst register value */
	*((volatile uint32_t *)(PER0MODRST_BASE)) = per0modrst;
}

/* AVST SPI special characters */
#define AV_SPI_IDLE	0x4A
#define AV_SPI_ESCAPE	0x4D

/* bytes to packet special characters */
#define B2P_SOP	0x7A
#define B2P_EOP	0x7B
#define B2P_CHAN	0x7C
#define B2P_ESCAPE	0x7D

/* packet to transaction operations */
#define WR_NO_INCR_OP	0x00
#define WR_INCR_OP	0x04
#define RD_NO_INCR_OP	0x10
#define RD_INCR_OP	0x14
#define NO_OP		0x7F

struct spi_msg {
	uint8_t *tx_buf;
	uint8_t *rx_buf;
	uint32_t len;
};

int send_spi_msg(struct spi_msg *mesg);

/* This routine writes an arbitrary amount of data to a 32-bit aligned address.
 */
int spi_write_image(uint32_t write_addr, uint8_t *write_data,
							uint32_t write_size) {

	int result;
	int i;
	int j;
	int b2p_message_length;
	int spi_message_length;
	int b2p_response_length;
	int base_response_length;

	struct spi_msg mesg;

	uint8_t base_message[(4 * 1024) + 8];
	uint8_t b2p_message[8 * 1024];
	uint8_t spi_message[8 * 1024];
	uint8_t spi_response[8 * 1024];
	uint8_t b2p_response[8 * 1024];
	uint8_t base_response[8 * 1024];

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

		/* create base message */
		base_message[0] = WR_INCR_OP;		// transaction code
		base_message[1] = 0x00;				// reserved
		base_message[2] = (cur_size >> 8) & 0xFF;	// size[1]
		base_message[3] = (cur_size >> 0) & 0xFF;	// size[0]
		base_message[4] = (cur_addr >> 24) & 0xFF;	// addr[3]
		base_message[5] = (cur_addr >> 16) & 0xFF;	// addr[2]
		base_message[6] = (cur_addr >>  8) & 0xFF;	// addr[1]
		base_message[7] = (cur_addr >>  0) & 0xFF;	// addr[0]

		cur_addr += cur_size;

		for(i = 0 ; i < cur_size ; i++) {
			base_message[8 + i]  = *cur_data++;
		}

		/* create B2P message */
		j=0;
		for(i = 0 ; i < (cur_size + 8) ; i++) {
			if(i == 0)
				b2p_message[j++] = B2P_SOP;
			if(i == (cur_size + 8) - 1)
				b2p_message[j++] = B2P_EOP;

			switch(base_message[i]) {
				case B2P_SOP:
					b2p_message[j++] = B2P_ESCAPE;
					b2p_message[j++] = base_message[i]
									^ 0x20;
					break;
				case B2P_EOP:
					b2p_message[j++] = B2P_ESCAPE;
					b2p_message[j++] = base_message[i]
									^ 0x20;
					break;
				case B2P_CHAN:
					b2p_message[j++] = B2P_ESCAPE;
					b2p_message[j++] = base_message[i]
									^ 0x20;
					break;
				case B2P_ESCAPE:
					b2p_message[j++] = B2P_ESCAPE;
					b2p_message[j++] = base_message[i]
									^ 0x20;
					break;
				default:
					b2p_message[j++] = base_message[i];
					break;
			}
		}
		b2p_message_length = j;

		/* create SPI message */
		j=0;
		for(i = 0 ; i < b2p_message_length ; i++) {
			switch(b2p_message[i]) {
				case AV_SPI_IDLE:
					spi_message[j++] = AV_SPI_ESCAPE;
					spi_message[j++] = b2p_message[i]
									^ 0x20;
					break;
				case AV_SPI_ESCAPE:
					spi_message[j++] = AV_SPI_ESCAPE;
					spi_message[j++] = b2p_message[i]
									^ 0x20;
					break;
				default:
					spi_message[j++] = b2p_message[i];
					break;
			}
		}
		/* pad SPI message to worst case response length */
		for(i = 0 ; i < 11 ; i++) {
			spi_message[j++] = AV_SPI_IDLE;
		}
		spi_message_length = j;

		/* break SPI transactions into 256 bytes or less */
		i = 0;
		do {
			/* run SPI transaction */
			memset(&mesg, 0x00, sizeof mesg);

			mesg.tx_buf = &spi_message[i];
			mesg.rx_buf = &spi_response[i];
			if((j - i) <= 256) {
				mesg.len = j - i;
				i += j - i;
			} else {
				mesg.len = 256;
				i += 256;
			}

			result = send_spi_msg(&mesg);
			if(result < 0)
				return 4;
		} while(i < j);

		/* extract B2P response */
		j=0;
		for(i = 0 ; i < spi_message_length ; i++) {
			switch(spi_response[i]) {
				case AV_SPI_IDLE:
					break;
				case AV_SPI_ESCAPE:
					i++;
					b2p_response[j++] = spi_response[i]
									^ 0x20;
					break;
				default:
					b2p_response[j++] = spi_response[i];
					break;
			}
		}
		b2p_response_length = j;

		/* extract base response */
		j=0;
		for(i = 0 ; i < b2p_response_length ; i++) {
			switch(b2p_response[i]) {
				case B2P_SOP:
					break;
				case B2P_EOP:
					break;
				case B2P_CHAN:
					i++;
					break;
				case B2P_ESCAPE:
					i++;
					base_response[j++] = b2p_response[i]
									^ 0x20;
					break;
				default:
					base_response[j++] = b2p_response[i];
					break;
			}
		}
		base_response_length = j;

		if(base_response_length != 4)
			return 2;

		if(
		(base_response[0] != (WR_INCR_OP ^ 0x80)) ||
		(base_response[1] != 0x00) ||
		(base_response[2] != (uint8_t)((cur_size >> 8) & 0xFF)) ||
		(base_response[3] != (uint8_t)((cur_size >> 0) & 0xFF))
		)
			return 3;
	}
	return 0;
}

/* This routine writes one 32-bit word of data to a 32-bit aligned address.
 */
int spi_write_reg32(uint32_t write_addr, uint32_t write_data) {

	int result;
	int i;
	int j;
	int b2p_message_length;
	int spi_message_length;
	int b2p_response_length;
	int base_response_length;

	struct spi_msg mesg;

	uint8_t base_message[12];
	uint8_t b2p_message[24];
	uint8_t spi_message[48];
	uint8_t spi_response[48];
	uint8_t b2p_response[48];
	uint8_t base_response[48];

	/* validate input address */
	if((write_addr & 0x3) != 0)
		return 1;

	/* create base message */
	base_message[0] = WR_NO_INCR_OP;		// transaction code
	base_message[1] = 0x00;				// reserved
	base_message[2] = 0x00;				// size[1]
	base_message[3] = 0x04;				// size[0]
	base_message[4] = (write_addr >> 24) & 0xFF;	// addr[3]
	base_message[5] = (write_addr >> 16) & 0xFF;	// addr[2]
	base_message[6] = (write_addr >>  8) & 0xFF;	// addr[1]
	base_message[7] = (write_addr >>  0) & 0xFF;	// addr[0]

	base_message[8]  = (write_data >>  0) & 0xFF;	// data[0]
	base_message[9]  = (write_data >>  8) & 0xFF;	// data[1]
	base_message[10] = (write_data >> 16) & 0xFF;	// data[2]
	base_message[11] = (write_data >> 24) & 0xFF;	// data[3]

	/* create B2P message */
	j=0;
	for(i = 0 ; i < 12 ; i++) {
		if(i == 0)
			b2p_message[j++] = B2P_SOP;
		if(i == 11)
			b2p_message[j++] = B2P_EOP;

		switch(base_message[i]) {
			case B2P_SOP:
				b2p_message[j++] = B2P_ESCAPE;
				b2p_message[j++] = base_message[i] ^ 0x20;
				break;
			case B2P_EOP:
				b2p_message[j++] = B2P_ESCAPE;
				b2p_message[j++] = base_message[i] ^ 0x20;
				break;
			case B2P_CHAN:
				b2p_message[j++] = B2P_ESCAPE;
				b2p_message[j++] = base_message[i] ^ 0x20;
				break;
			case B2P_ESCAPE:
				b2p_message[j++] = B2P_ESCAPE;
				b2p_message[j++] = base_message[i] ^ 0x20;
				break;
			default:
				b2p_message[j++] = base_message[i];
				break;
		}
	}
	b2p_message_length = j;

	/* create SPI message */
	j=0;
	for(i = 0 ; i < b2p_message_length ; i++) {
		switch(b2p_message[i]) {
			case AV_SPI_IDLE:
				spi_message[j++] = AV_SPI_ESCAPE;
				spi_message[j++] = b2p_message[i] ^ 0x20;
				break;
			case AV_SPI_ESCAPE:
				spi_message[j++] = AV_SPI_ESCAPE;
				spi_message[j++] = b2p_message[i] ^ 0x20;
				break;
			default:
				spi_message[j++] = b2p_message[i];
				break;
		}
	}
	/* pad SPI message to worst case response length */
	for(i = 0 ; i < 11 ; i++) {
		spi_message[j++] = AV_SPI_IDLE;
	}
	spi_message_length = j;

	/* run SPI transaction */
	memset(&mesg, 0x00, sizeof mesg);

	mesg.tx_buf = &spi_message[0];
	mesg.rx_buf = &spi_response[0];
	mesg.len = spi_message_length;

	result = send_spi_msg(&mesg);
	if(result < 0)
		return 4;

	/* extract B2P response */
	j=0;
	for(i = 0 ; i < spi_message_length ; i++) {
		switch(spi_response[i]) {
			case AV_SPI_IDLE:
				break;
			case AV_SPI_ESCAPE:
				i++;
				b2p_response[j++] = spi_response[i] ^ 0x20;
				break;
			default:
				b2p_response[j++] = spi_response[i];
				break;
		}
	}
	b2p_response_length = j;

	/* extract base response */
	j=0;
	for(i = 0 ; i < b2p_response_length ; i++) {
		switch(b2p_response[i]) {
			case B2P_SOP:
				break;
			case B2P_EOP:
				break;
			case B2P_CHAN:
				i++;
				break;
			case B2P_ESCAPE:
				i++;
				base_response[j++] = b2p_response[i] ^ 0x20;
				break;
			default:
				base_response[j++] = b2p_response[i];
				break;
		}
	}
	base_response_length = j;

	if(base_response_length != 4)
		return 2;

	if(
		(base_response[0] != (WR_NO_INCR_OP ^ 0x80)) ||
		(base_response[1] != 0x00) ||
		(base_response[2] != 0x00) ||
		(base_response[3] != 0x04)
	)
		return 3;

	return 0;
}

/* This routine reads one 32-bit word of data from a 32-bit aligned address.
 */
int spi_read_reg32(uint32_t read_addr, uint32_t *read_data) {

	int result;
	int i;
	int j;
	int b2p_message_length;
	int spi_message_length;
	int b2p_response_length;
	int base_response_length;
	uint32_t the_read_data;

	struct spi_msg mesg;

	uint8_t base_message[8];
	uint8_t b2p_message[16];
	uint8_t spi_message[32];
	uint8_t spi_response[32];
	uint8_t b2p_response[32];
	uint8_t base_response[32];

	/* validate input address */
	if((read_addr & 0x3) != 0)
		return 1;

	/* create base message */
	base_message[0] = RD_NO_INCR_OP;		// transaction code
	base_message[1] = 0x00;				// reserved
	base_message[2] = 0x00;				// size[1]
	base_message[3] = 0x04;				// size[0]
	base_message[4] = (read_addr >> 24) & 0xFF;	// addr[3]
	base_message[5] = (read_addr >> 16) & 0xFF;	// addr[2]
	base_message[6] = (read_addr >>  8) & 0xFF;	// addr[1]
	base_message[7] = (read_addr >>  0) & 0xFF;	// addr[0]

	/* create B2P message */
	j=0;
	for(i = 0 ; i < 8 ; i++) {
		if(i == 0)
			b2p_message[j++] = B2P_SOP;
		if(i == 7)
			b2p_message[j++] = B2P_EOP;

		switch(base_message[i]) {
			case B2P_SOP:
				b2p_message[j++] = B2P_ESCAPE;
				b2p_message[j++] = base_message[i] ^ 0x20;
				break;
			case B2P_EOP:
				b2p_message[j++] = B2P_ESCAPE;
				b2p_message[j++] = base_message[i] ^ 0x20;
				break;
			case B2P_CHAN:
				b2p_message[j++] = B2P_ESCAPE;
				b2p_message[j++] = base_message[i] ^ 0x20;
				break;
			case B2P_ESCAPE:
				b2p_message[j++] = B2P_ESCAPE;
				b2p_message[j++] = base_message[i] ^ 0x20;
				break;
			default:
				b2p_message[j++] = base_message[i];
				break;
		}
	}
	b2p_message_length = j;

	/* create SPI message */
	j=0;
	for(i = 0 ; i < b2p_message_length ; i++) {
		switch(b2p_message[i]) {
			case AV_SPI_IDLE:
				spi_message[j++] = AV_SPI_ESCAPE;
				spi_message[j++] = b2p_message[i] ^ 0x20;
				break;
			case AV_SPI_ESCAPE:
				spi_message[j++] = AV_SPI_ESCAPE;
				spi_message[j++] = b2p_message[i] ^ 0x20;
				break;
			default:
				spi_message[j++] = b2p_message[i];
				break;
		}
	}
	/* pad SPI message to worst case response length */
	for(i = 0 ; i < 13 ; i++) {
		spi_message[j++] = AV_SPI_IDLE;
	}
	spi_message_length = j;

	/* run SPI transaction */
	memset(&mesg, 0x00, sizeof mesg);

	mesg.tx_buf = &spi_message[0];
	mesg.rx_buf = &spi_response[0];
	mesg.len = spi_message_length;

	result = send_spi_msg(&mesg);
	if(result < 0)
		return 4;

	/* extract B2P response */
	j=0;
	for(i = 0 ; i < spi_message_length ; i++) {
		switch(spi_response[i]) {
			case AV_SPI_IDLE:
				break;
			case AV_SPI_ESCAPE:
				i++;
				b2p_response[j++] = spi_response[i] ^ 0x20;
				break;
			default:
				b2p_response[j++] = spi_response[i];
				break;
		}
	}
	b2p_response_length = j;

	/* extract base response */
	j=0;
	for(i = 0 ; i < b2p_response_length ; i++) {
		switch(b2p_response[i]) {
			case B2P_SOP:
				break;
			case B2P_EOP:
				break;
			case B2P_CHAN:
				i++;
				break;
			case B2P_ESCAPE:
				i++;
				base_response[j++] = b2p_response[i] ^ 0x20;
				break;
			default:
				base_response[j++] = b2p_response[i];
				break;
		}
	}
	base_response_length = j;

	if(base_response_length != 4)
		return 2;

	the_read_data =
			(base_response[3] << 24) |
			(base_response[2] << 16) |
			(base_response[1] <<  8) |
			(base_response[0] <<  0);

	*read_data = the_read_data;
	return 0;
}

/* This function issues a "no transaction" command to the SPI slave.  It can be
 * used to verify proper connectivity to the SPI slave.  If this command doesn't
 * work, then nothing more is likely to work.
 */
int run_no_transaction_command(void) {

	int result;

	struct spi_msg mesg;

	uint8_t tx_buffer[19] = {
		B2P_SOP,	NO_OP,		0x00,		0x00,
		0x00,		0x00,		0x00,		0x00,
		B2P_EOP,	0x00,		AV_SPI_IDLE,	AV_SPI_IDLE,
		AV_SPI_IDLE,	AV_SPI_IDLE,	AV_SPI_IDLE,	AV_SPI_IDLE,
		AV_SPI_IDLE,	AV_SPI_IDLE,	AV_SPI_IDLE };

	uint8_t rx_buffer[19] = { 0 };

	uint8_t expected_rx_pattern[19] = {
		AV_SPI_IDLE,	AV_SPI_IDLE,	AV_SPI_IDLE,	AV_SPI_IDLE,
		AV_SPI_IDLE,	AV_SPI_IDLE,	AV_SPI_IDLE,	AV_SPI_IDLE,
		AV_SPI_IDLE,	AV_SPI_IDLE,	AV_SPI_IDLE,	B2P_CHAN,
		0x00,		B2P_SOP,	0xFF,		0x00,
		0x00,		B2P_EOP,	0x00 };

	memset(&mesg, 0x00, sizeof mesg);

	mesg.tx_buf = &tx_buffer[0];
	mesg.rx_buf = &rx_buffer[0];
	mesg.len = 19;

	result = send_spi_msg(&mesg);
	if(result < 0)
		return 4;

	result = memcmp(rx_buffer, expected_rx_pattern, 19);
	if(result != 0)
		return 1;

	return result;
}

int send_spi_msg(struct spi_msg *mesg) {

	int i;
	uint32_t fill_level;
	uint64_t cntfrq_el0;
	uint64_t timeout;
	uint64_t temp;

	/* validate the len argument */
	if(mesg->len == 0)
		return -1;

	if(mesg->len > 256)
		return -1;

	/* get spim txflr */
	fill_level =
		*((volatile uint32_t *)(HPS_SPIM0_BASE + HPS_SPI_TXFLR_OFST));
	if(fill_level != 0)
		return -2;

	/* send message */
	for(i = 0 ; i < mesg->len ; i++)
		*((volatile uint32_t *)(HPS_SPIM0_BASE + HPS_SPI_DR0_OFST)) =
							(mesg->tx_buf)[i];

	/* get spim txflr */
	fill_level =
		*((volatile uint32_t *)(HPS_SPIM0_BASE + HPS_SPI_TXFLR_OFST));

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* create a timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	/* wait for spim rxflr */
	do {
		asm volatile (
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout)
			return -3;

		fill_level =
		*((volatile uint32_t *)(HPS_SPIM0_BASE + HPS_SPI_RXFLR_OFST));
	} while(fill_level < mesg->len);

	/* receive response */
	for(i = 0 ; i < mesg->len ; i++)
		(mesg->rx_buf)[i] =
		*((volatile uint32_t *)(HPS_SPIM0_BASE + HPS_SPI_DR0_OFST));

	return 0;
}

