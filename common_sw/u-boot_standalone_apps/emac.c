/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct hps_emac_s {
	uint32_t gp_sig_value;
	uint32_t error;
	uint64_t dcache_flush_time_1;
	uint64_t buffer_compare_time_1;
	uint64_t hps_emac_loop_time;
	uint64_t dcache_flush_time_2;
	uint64_t buffer_compare_time_2;
	uint64_t gmii_loop_time;
};

void do_the_interesting_thing(struct hps_emac_s *hps_emac);

int emac(int argc, char *const argv[])
{
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	uint64_t bytes_per_sec;
	uint64_t gb_per_sec;
	uint64_t gb_per_sec_frac;
	struct hps_emac_s hps_emac = {0};

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
	do_the_interesting_thing(&hps_emac);

	/* print the results */
	puts("\n");
	printf ("HPS EMAC Demo\n");
	puts("\n");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
				hps_emac.gp_sig_value,
				(hps_emac.gp_sig_value >>  0) & 0xFF,
				(hps_emac.gp_sig_value >>  8) & 0xFF,
				(hps_emac.gp_sig_value >> 16) & 0xFF,
				(hps_emac.gp_sig_value >> 24) & 0xFF);
	puts("\n");

	switch(hps_emac.error) {
	case(0):
		puts("No errors detected...\n");
		puts("\n");
		printf("          DCACHE FLUSH TIME: ");
		ns_time = (hps_emac.dcache_flush_time_1 * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_emac.dcache_flush_time_1 * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9lld.%03lldns\n", ns_time, ps_time);

		printf("        BUFFER COMPARE TIME: ");
		ns_time = (hps_emac.buffer_compare_time_1 * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_emac.buffer_compare_time_1 * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9lld.%03lldns\n", ns_time, ps_time);

		printf("HPS EMAC INTERNAL LOOP TIME: ");
		ns_time = (hps_emac.hps_emac_loop_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_emac.hps_emac_loop_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9lld.%03lldns", ns_time, ps_time);
		bytes_per_sec = (F2H_OCRAM_32K_SPAN * 1000000000UL) / ns_time;
		gb_per_sec = bytes_per_sec / (1024 * 1024 * 1024);
		gb_per_sec_frac = bytes_per_sec % (1024 * 1024 * 1024);
		gb_per_sec_frac *= 1000;
		gb_per_sec_frac /= (1024 * 1024 * 1024);
		printf(" : %3lld.%03lldGB/s\n", gb_per_sec, gb_per_sec_frac);

		printf("          DCACHE FLUSH TIME: ");
		ns_time = (hps_emac.dcache_flush_time_2 * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_emac.dcache_flush_time_2 * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9lld.%03lldns\n", ns_time, ps_time);

		printf("        BUFFER COMPARE TIME: ");
		ns_time = (hps_emac.buffer_compare_time_2 * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_emac.buffer_compare_time_2 * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9lld.%03lldns\n", ns_time, ps_time);

		printf("             GMII LOOP TIME: ");
		ns_time = (hps_emac.gmii_loop_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (hps_emac.gmii_loop_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9lld.%03lldns", ns_time, ps_time);
		bytes_per_sec = (F2H_OCRAM_32K_SPAN * 1000000000UL) / ns_time;
		gb_per_sec = bytes_per_sec / (1024 * 1024 * 1024);
		gb_per_sec_frac = bytes_per_sec % (1024 * 1024 * 1024);
		gb_per_sec_frac *= 1000;
		gb_per_sec_frac /= (1024 * 1024 * 1024);
		printf(" : %3lld.%03lldGB/s\n", gb_per_sec, gb_per_sec_frac);
		break;
	case(1):
		puts("FPGA system validation error returned...\n");
		break;
	case(2):
		puts("1 - SMC secure register write operation failed...\n");
		break;
	case(3):
		puts("1 - HPS EMAC software reset timeout error returned...\n");
		break;
	case(4):
		puts("1 - DMA idle timeout error returned...\n");
		break;
	case(5):
		puts("1 - Buffer validation error returned...\n");
		puts("Initial buffer does not match final buffer...\n");
		break;
	case(6):
		puts("2 - SMC secure register write operation failed...\n");
		break;
	case(7):
		puts("2 - HPS EMAC software reset timeout error returned...\n");
		break;
	case(8):
		puts("2 - DMA idle timeout error returned...\n");
		break;
	case(9):
		puts("2 - Buffer validation error returned...\n");
		puts("Initial buffer does not match final buffer...\n");
		break;
	default:
		puts("Unknown error returned...\n");
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

struct descriptor_s {
	uint32_t desc0;
	uint32_t desc1;
	uint32_t desc2;
	uint32_t desc3;
};

void do_the_interesting_thing(struct hps_emac_s *hps_emac) {

	int i;
	uint32_t gp_in;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t timeout;
	uint64_t temp;
	uint32_t temp_32;
	uint8_t *tx_data_buffer = (void*)(HPS_EMAC0_TX_BUF_BASE);
	uint8_t *rx_data_buffer = (void*)(HPS_EMAC0_RX_BUF_BASE);
	uint64_t *tx_data_buffer_word_ptr = (uint64_t *)tx_data_buffer;
	struct descriptor_s *tx_descriptors = (void*)(HPS_EMAC0_TX_DESC_BASE);
	struct descriptor_s *rx_descriptors = (void*)(HPS_EMAC0_RX_DESC_BASE);
	uint64_t smc_cmd;
	uint64_t smc_result;
	uint64_t smc_sec_reg_addr;
	uint64_t smc_sec_reg_val;

	hps_emac->error = 1;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0;
	gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	hps_emac->gp_sig_value = gp_in;

	if(gp_in != EMAC_SIG)
		return;

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/*
	 * we will now transmit data from tx_data_buffer, through the HPS EMAC
	 * loopback, and receive it in the rx_data_buffer
	 */

	/* clear the DMA data buffers */
	/* this isn't necessary but for demonstration purposes we'll do it */
	memset(tx_data_buffer, 0, (32 * 1024));
	memset(rx_data_buffer, 0, (32 * 1024));

	/* fill the tx buffer with a randomized data pattern */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	temp ^= 0xFbFdF1F3F5F7FbFd;
	temp += 0x0b0d010305070b0d;
	for(i = 0 ; i < ((32 * 1024) / sizeof(uint64_t)) ; i++) {
		temp += 0x0b0d010305070b0d;
		tx_data_buffer_word_ptr[i] = temp++;
	}

	/*
	 * adjust MAC addresses and length field for each packet
	 *
	 * set the U/L bit, clear the I/G bit and clear the two SLAP bits
	 * so our MAC addresses shall be X2-XX-XX-XX-XX-XX and our length field
	 * shall be 0x0400
	 */
	for(i = 0 ; i < 32 ; i++) {

		/* adjust destination MAC address */
		tx_data_buffer[(i * 0x400) + 0] &= 0xF0;
		tx_data_buffer[(i * 0x400) + 0] |= 0x02;

		/* adjust source MAC address */
		tx_data_buffer[(i * 0x400) + 6] &= 0xF0;
		tx_data_buffer[(i * 0x400) + 6] |= 0x02;

		/* adjust length field */
		tx_data_buffer[(i * 0x400) + 12] |= 0x04;
		tx_data_buffer[(i * 0x400) + 13] |= 0x00;
	}

	/* create the TX/RX descriptor rings */
	for(i = 0 ; i < 32 ; i++) {
		/* tx desc0 - buffer 1 address */
		tx_descriptors[i].desc0 =
			(uint64_t)(&tx_data_buffer[i * 1024]) & 0xFFFFFFFF;
		/* tx desc1 - buffer 2 address */
		tx_descriptors[i].desc1 = 0;
		/* tx desc2 - buffer 1 length */
		tx_descriptors[i].desc2 = 1024;
		/* tx desc3 - OWN, FD, LD */
		tx_descriptors[i].desc3 = 0xB0000000;

		/* rx desc0 - buffer 1 address */
		rx_descriptors[i].desc0 =
			(uint64_t)(&rx_data_buffer[i * 1024]) & 0xFFFFFFFF;
		/* rx desc1 - reserved */
		rx_descriptors[i].desc1 = 0;
		/* rx desc2 - buffer 2 */
		rx_descriptors[i].desc2 = 0;
		/* rx desc3 - OWN, reserved */
		rx_descriptors[i].desc3 = 0x80000000;
	}

	/* null the last tx descriptor in the ring */
	tx_descriptors[i].desc0 = 0;
	tx_descriptors[i].desc1 = 0;
	tx_descriptors[i].desc2 = 0;
	tx_descriptors[i].desc3 = 0;

	/* null the last rx descriptor in the ring */
	rx_descriptors[i].desc0 = 0;
	rx_descriptors[i].desc1 = 0;
	rx_descriptors[i].desc2 = 0;
	rx_descriptors[i].desc3 = 0;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* flush the data cache */
	flush_dcache_range((uint64_t)tx_data_buffer,
		(uint64_t)((void*)(tx_data_buffer) + (32 * 1024)));
	flush_dcache_range((uint64_t)rx_data_buffer,
		(uint64_t)((void*)(rx_data_buffer) + (32 * 1024)));
	flush_dcache_range((uint64_t)tx_descriptors,
		(uint64_t)((void*)(tx_descriptors) +
			(sizeof(struct descriptor_s) * 33)));
	flush_dcache_range((uint64_t)rx_descriptors,
		(uint64_t)((void*)(rx_descriptors) +
			(sizeof(struct descriptor_s) * 33)));

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the dcache flush time */
	hps_emac->dcache_flush_time_1 = end_time - start_time;


	/* assert reset the EMAC0 peripheral */
	temp_32 = *((volatile uint32_t *)(PER0MODRST_BASE));
	*((volatile uint32_t *)(PER0MODRST_BASE)) = temp_32 | PER0MODRST_EMAC0;

	/* set the phy_intf_sel mode for tsn0 to RESET mode */
	smc_cmd = SMC_CMD_SEC_REG_WR;
	smc_sec_reg_addr = SYSMGR_TSN0_BASE;
	smc_sec_reg_val = SYSMGR_TSN0_PHY_INTF_SEL_RESET;
	asm volatile (
		"mov x0, %[smc_cmd]\n"
		"mov x1, %[smc_sec_reg_addr]\n"
		"mov x2, %[smc_sec_reg_val]\n"
		"mov x3, #0\n"
		"mov x4, #0\n"
		"mov x5, #0\n"
		"mov x6, #0\n"
		"smc #0\n"
		"mov %[smc_result], x0\n"
		:
		       [smc_result] "=r" (smc_result)
		:
		          [smc_cmd] "r"  (smc_cmd),
		 [smc_sec_reg_addr] "r"  (smc_sec_reg_addr),
		  [smc_sec_reg_val] "r"  (smc_sec_reg_val)
		: "x0", "x1", "x2", "x3", "x4", "x5", "x6"
	);

	if(smc_result != 0) {
		hps_emac->error = 2;
		return;
	}

	/* deassert reset the EMAC0 peripheral */
	temp_32 = *((volatile uint32_t *)(PER0MODRST_BASE));
	*((volatile uint32_t *)(PER0MODRST_BASE)) = temp_32 & ~PER0MODRST_EMAC0;

	/* assert software reset to the EMAC0 peripheral */
	*((volatile uint32_t *)(EMAC0_DMA_BASE + DMA_Mode_OFST)) = 0x00000001;

	/* wait for software reset to clear or timeout */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

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
		if(temp >= timeout) {
			hps_emac->error = 3;
			return;
		}

		temp_32 = *((volatile uint32_t *)(EMAC0_DMA_BASE +
								DMA_Mode_OFST));
	} while(temp_32 & 0x00000001);

	/* configure the EMAC0 DMA_SysBus_Mode register */
	*((volatile uint32_t *)(EMAC0_DMA_BASE +
				DMA_SysBus_Mode_OFST)) = 0x000000FF;

	/* configure the transmit descriptor ring length */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
				DMA_CH0_TX_Control2_OFST)) = 33 - 1;

	/* configure the receive descriptor ring length */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
				DMA_CH0_RX_Control2_OFST)) = 33 - 1;

	/* configure the transmit descriptor ring base */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
		DMA_CH0_TxDesc_List_LAddress_OFST)) =
				(uint64_t)(&tx_descriptors[0]) & 0xFFFFFFFF;

	/* configure the receive descriptor ring base */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
		DMA_CH0_RxDesc_List_LAddress_OFST)) =
				(uint64_t)(&rx_descriptors[0]) & 0xFFFFFFFF;

	/* configure the transmit descriptor ring tail pointer */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
		DMA_CH0_TxDesc_Tail_LPointer_OFST)) =
				(uint64_t)(&tx_descriptors[32]) & 0xFFFFFFFF;

	/* configure the receive descriptor ring tail pointer */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
		DMA_CH0_RxDesc_Tail_LPointer_OFST)) =
				(uint64_t)(&rx_descriptors[32]) & 0xFFFFFFFF;

	/* start the transmit DMA */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
					DMA_CH0_TX_Control_OFST)) = 0x00200001;

	/* start the receive DMA */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
					DMA_CH0_RX_Control_OFST)) = 0x00201001;

	/* configure the MAC packet filter, receive all packets promiscuously */
	*((volatile uint32_t *)(EMAC0_MAC_BASE +
					MAC_Packet_Filter_OFST)) = 0x80000001;

	/* enable TxQ0, store and forward mode, 32KB queue size */
	*((volatile uint32_t *)(EMAC0_MTL_BASE +
				MTL_TxQ0_Operation_Mode_OFST)) = 0x007F000A;

	/* configure RxQ0, store and forward mode, 32KB queue size */
	*((volatile uint32_t *)(EMAC0_MTL_BASE +
				MTL_RxQ0_Operation_Mode_OFST)) = 0x007F0020;

	/* enable RxQ0 */
	*((volatile uint32_t *)(EMAC0_MAC_BASE +
					MAC_RxQ_Ctrl0_OFST)) = 0x00000002;

	/* enable packet reception, internal loopback, FCS stripping  */
	*((volatile uint32_t *)(EMAC0_MAC_BASE +
				MAC_Rx_Configuration_OFST)) = 0x00000407;

	/* enable packet transmission, 1Gbps speed */
	*((volatile uint32_t *)(EMAC0_MAC_BASE +
				MAC_Tx_Configuration_OFST)) = 0x60000001;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = *((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
							DMA_CH0_Status_OFST));
	while(temp_32 != 0x00000084) {
		asm volatile (
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			hps_emac->error = 4;
			return;
		}
		temp_32 = *((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
							DMA_CH0_Status_OFST));
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	hps_emac->hps_emac_loop_time = end_time - start_time;

	/* dsb so that a76 waits for outstanding io before comparing buffers */
	asm volatile (
		"dsb sy\n"
	);

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* verify the initial buffer matches the final buffer */
	if(memcmp(tx_data_buffer, rx_data_buffer, (32 * 1024)) == 0) {
		hps_emac->error = 0;
	} else {
		hps_emac->error = 5;
		return;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	hps_emac->buffer_compare_time_1 = end_time - start_time;

	/*
	 * we will now transmit data from tx_data_buffer, through the GMII FPGA
	 * loopback, and receive it in the rx_data_buffer
	 */

	/* clear the DMA data buffers */
	/* this isn't necessary but for demonstration purposes we'll do it */
	memset(tx_data_buffer, 0, (32 * 1024));
	memset(rx_data_buffer, 0, (32 * 1024));

	/* fill the tx buffer with a randomized data pattern */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	temp ^= 0xFbFdF1F3F5F7FbFd;
	temp += 0x0b0d010305070b0d;
	for(i = 0 ; i < ((32 * 1024) / sizeof(uint64_t)) ; i++) {
		temp += 0x0b0d010305070b0d;
		tx_data_buffer_word_ptr[i] = temp++;
	}

	/*
	 * adjust MAC addresses and length field for each packet
	 *
	 * set the U/L bit, clear the I/G bit and clear the two SLAP bits
	 * so our MAC addresses shall be X2-XX-XX-XX-XX-XX and our length field
	 * shall be 0x0400
	 */
	for(i = 0 ; i < 32 ; i++) {

		/* adjust destination MAC address */
		tx_data_buffer[(i * 0x400) + 0] &= 0xF0;
		tx_data_buffer[(i * 0x400) + 0] |= 0x02;

		/* adjust source MAC address */
		tx_data_buffer[(i * 0x400) + 6] &= 0xF0;
		tx_data_buffer[(i * 0x400) + 6] |= 0x02;

		/* adjust length field */
		tx_data_buffer[(i * 0x400) + 12] |= 0x04;
		tx_data_buffer[(i * 0x400) + 13] |= 0x00;
	}

	/* create the TX/RX descriptor rings */
	for(i = 0 ; i < 32 ; i++) {
		/* tx desc0 - buffer 1 address */
		tx_descriptors[i].desc0 =
			(uint64_t)(&tx_data_buffer[i * 1024]) & 0xFFFFFFFF;
		/* tx desc1 - buffer 2 address */
		tx_descriptors[i].desc1 = 0;
		/* tx desc2 - buffer 1 length */
		tx_descriptors[i].desc2 = 1024;
		/* tx desc3 - OWN, FD, LD */
		tx_descriptors[i].desc3 = 0xB0000000;

		/* rx desc0 - buffer 1 address */
		rx_descriptors[i].desc0 =
			(uint64_t)(&rx_data_buffer[i * 1024]) & 0xFFFFFFFF;
		/* rx desc1 - reserved */
		rx_descriptors[i].desc1 = 0;
		/* rx desc2 - buffer 2 */
		rx_descriptors[i].desc2 = 0;
		/* rx desc3 - OWN, reserved */
		rx_descriptors[i].desc3 = 0x80000000;
	}

	/* null the last tx descriptor in the ring */
	tx_descriptors[i].desc0 = 0;
	tx_descriptors[i].desc1 = 0;
	tx_descriptors[i].desc2 = 0;
	tx_descriptors[i].desc3 = 0;

	/* null the last rx descriptor in the ring */
	rx_descriptors[i].desc0 = 0;
	rx_descriptors[i].desc1 = 0;
	rx_descriptors[i].desc2 = 0;
	rx_descriptors[i].desc3 = 0;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* flush the data cache */
	flush_dcache_range((uint64_t)tx_data_buffer,
		(uint64_t)((void*)(tx_data_buffer) + (32 * 1024)));
	flush_dcache_range((uint64_t)rx_data_buffer,
		(uint64_t)((void*)(rx_data_buffer) + (32 * 1024)));
	flush_dcache_range((uint64_t)tx_descriptors,
		(uint64_t)((void*)(tx_descriptors) +
			(sizeof(struct descriptor_s) * 33)));
	flush_dcache_range((uint64_t)rx_descriptors,
		(uint64_t)((void*)(rx_descriptors) +
			(sizeof(struct descriptor_s) * 33)));

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the dcache flush time */
	hps_emac->dcache_flush_time_2 = end_time - start_time;


	/* assert reset the EMAC0 peripheral */
	temp_32 = *((volatile uint32_t *)(PER0MODRST_BASE));
	*((volatile uint32_t *)(PER0MODRST_BASE)) = temp_32 | PER0MODRST_EMAC0;

	/* set the phy_intf_sel mode for tsn0 to GMII mode */
	smc_cmd = SMC_CMD_SEC_REG_WR;
	smc_sec_reg_addr = SYSMGR_TSN0_BASE;
	smc_sec_reg_val = SYSMGR_TSN0_PHY_INTF_SEL_GMII;
	asm volatile (
		"mov x0, %[smc_cmd]\n"
		"mov x1, %[smc_sec_reg_addr]\n"
		"mov x2, %[smc_sec_reg_val]\n"
		"mov x3, #0\n"
		"mov x4, #0\n"
		"mov x5, #0\n"
		"mov x6, #0\n"
		"smc #0\n"
		"mov %[smc_result], x0\n"
		:
		       [smc_result] "=r" (smc_result)
		:
		          [smc_cmd] "r"  (smc_cmd),
		 [smc_sec_reg_addr] "r"  (smc_sec_reg_addr),
		  [smc_sec_reg_val] "r"  (smc_sec_reg_val)
		: "x0", "x1", "x2", "x3", "x4", "x5", "x6"
	);

	if(smc_result != 0) {
		hps_emac->error = 6;
		return;
	}

	/* deassert reset the EMAC0 peripheral */
	temp_32 = *((volatile uint32_t *)(PER0MODRST_BASE));
	*((volatile uint32_t *)(PER0MODRST_BASE)) = temp_32 & ~PER0MODRST_EMAC0;

	/* assert software reset to the EMAC0 peripheral */
	*((volatile uint32_t *)(EMAC0_DMA_BASE + DMA_Mode_OFST)) = 0x00000001;

	/* wait for software reset to clear or timeout */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

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
		if(temp >= timeout) {
			hps_emac->error = 7;
			return;
		}

		temp_32 = *((volatile uint32_t *)(EMAC0_DMA_BASE +
								DMA_Mode_OFST));
	} while(temp_32 & 0x00000001);

	/* configure the EMAC0 DMA_SysBus_Mode register */
	*((volatile uint32_t *)(EMAC0_DMA_BASE +
				DMA_SysBus_Mode_OFST)) = 0x000000FF;

	/* configure the transmit descriptor ring length */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
				DMA_CH0_TX_Control2_OFST)) = 33 - 1;

	/* configure the receive descriptor ring length */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
				DMA_CH0_RX_Control2_OFST)) = 33 - 1;

	/* configure the transmit descriptor ring base */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
		DMA_CH0_TxDesc_List_LAddress_OFST)) =
				(uint64_t)(&tx_descriptors[0]) & 0xFFFFFFFF;

	/* configure the receive descriptor ring base */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
		DMA_CH0_RxDesc_List_LAddress_OFST)) =
				(uint64_t)(&rx_descriptors[0]) & 0xFFFFFFFF;

	/* configure the transmit descriptor ring tail pointer */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
		DMA_CH0_TxDesc_Tail_LPointer_OFST)) =
				(uint64_t)(&tx_descriptors[32]) & 0xFFFFFFFF;

	/* configure the receive descriptor ring tail pointer */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
		DMA_CH0_RxDesc_Tail_LPointer_OFST)) =
				(uint64_t)(&rx_descriptors[32]) & 0xFFFFFFFF;

	/* start the transmit DMA */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
					DMA_CH0_TX_Control_OFST)) = 0x00200001;

	/* start the receive DMA */
	*((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
					DMA_CH0_RX_Control_OFST)) = 0x00201001;

	/* configure the MAC packet filter, receive all packets promiscuously */
	*((volatile uint32_t *)(EMAC0_MAC_BASE +
					MAC_Packet_Filter_OFST)) = 0x80000001;

	/* enable TxQ0, store and forward mode, 32KB queue size */
	*((volatile uint32_t *)(EMAC0_MTL_BASE +
				MTL_TxQ0_Operation_Mode_OFST)) = 0x007F000A;

	/* configure RxQ0, store and forward mode, 32KB queue size */
	*((volatile uint32_t *)(EMAC0_MTL_BASE +
				MTL_RxQ0_Operation_Mode_OFST)) = 0x007F0020;

	/* enable RxQ0 */
	*((volatile uint32_t *)(EMAC0_MAC_BASE +
					MAC_RxQ_Ctrl0_OFST)) = 0x00000002;

	/* enable packet reception, FCS stripping  */
	*((volatile uint32_t *)(EMAC0_MAC_BASE +
				MAC_Rx_Configuration_OFST)) = 0x00000007;

	/* enable packet transmission, 1Gbps speed */
	*((volatile uint32_t *)(EMAC0_MAC_BASE +
				MAC_Tx_Configuration_OFST)) = 0x60000001;

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = *((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
							DMA_CH0_Status_OFST));
	while(temp_32 != 0x00000084) {
		asm volatile (
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			hps_emac->error = 8;
			return;
		}
		temp_32 = *((volatile uint32_t *)(EMAC0_DMA_CH0_BASE +
							DMA_CH0_Status_OFST));
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	hps_emac->gmii_loop_time = end_time - start_time;

	/* dsb so that a76 waits for outstanding io before comparing buffers */
	asm volatile (
		"dsb sy\n"
	);

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* verify the initial buffer matches the final buffer */
	if(memcmp(tx_data_buffer, rx_data_buffer, (32 * 1024)) == 0) {
		hps_emac->error = 0;
	} else {
		hps_emac->error = 9;
		return;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	hps_emac->buffer_compare_time_2 = end_time - start_time;
}