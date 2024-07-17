/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "standalone_common.h"

struct f2h_bridge_s {
	uint32_t gp_sig_value;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint32_t error;
	uint64_t dcache_flush_time;
	uint64_t buffer_compare_time;
	uint64_t h2f_dma_time;
	uint64_t f2h_dma_time;
	uint32_t error2;
	uint64_t buffer_compare_time2;
	uint64_t h2f_dma_time2;
	uint64_t f2h_dma_time2;
};

void do_the_interesting_thing(struct f2h_bridge_s *f2h_bridge);

int f2h_bridge(int argc, char *const argv[])
{
	uint64_t cntfrq_el0;
	uint64_t ns_time;
	uint64_t ps_time;
	uint64_t bytes_per_sec;
	uint64_t gb_per_sec;
	uint64_t gb_per_sec_frac;
	struct f2h_bridge_s f2h_bridge = {0};

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
	do_the_interesting_thing(&f2h_bridge);

	/* print the results */
	puts("\n");
	printf ("F2H Demo\n");
	puts("\n");

    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	printf("HPS_GP_IN signature value = 0x%08X : %c%c%c%c\n",
				f2h_bridge.gp_sig_value,
				(f2h_bridge.gp_sig_value >>  0) & 0xFF,
				(f2h_bridge.gp_sig_value >>  8) & 0xFF,
				(f2h_bridge.gp_sig_value >> 16) & 0xFF,
				(f2h_bridge.gp_sig_value >> 24) & 0xFF);
	puts("\n");

	printf("SYSID_ID: 0x%08X\n", f2h_bridge.sysid_id);
	printf("SYSID_TS: 0x%08X\n", f2h_bridge.sysid_ts);
	puts("\n");
	puts("---------- data cache flushed ----------\n");
	puts("\n");

	switch(f2h_bridge.error) {
	case(0):
		puts("No errors detected...\n");
		puts("\n");
		printf("   DCACHE FLUSH TIME: ");
		ns_time = (f2h_bridge.dcache_flush_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.dcache_flush_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9lld.%03lldns\n", ns_time, ps_time);

		printf(" BUFFER COMPARE TIME: ");
		ns_time = (f2h_bridge.buffer_compare_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.buffer_compare_time * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9lld.%03lldns\n", ns_time, ps_time);

		printf("HPS to FPGA DMA TIME: ");
		ns_time = (f2h_bridge.h2f_dma_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.h2f_dma_time * 1000000000)
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

		printf("FPGA to HPS DMA TIME: ");
		ns_time = (f2h_bridge.f2h_dma_time * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.f2h_dma_time * 1000000000)
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
		puts("HPS to FPGA DMA busy error returned...\n");
		break;
	case(3):
		puts("HPS to FPGA DMA timeout error returned...\n");
		break;
	case(4):
		puts("FPGA to HPS DMA busy error returned...\n");
		break;
	case(5):
		puts("FPGA to HPS DMA timeout error returned...\n");
		break;
	case(6):
		puts("Buffer validation error returned...\n");
		puts("Initial buffer does not match final buffer...\n");
		break;
	default:
		puts("Unknown error returned...\n");
	}

	puts("\n");
	puts("---------- data cache NOT flushed ----------\n");
	puts("\n");

	switch(f2h_bridge.error2) {
	case(0):
		puts("No errors detected...\n");
		puts("\n");
		printf(" BUFFER COMPARE TIME: ");
		ns_time = (f2h_bridge.buffer_compare_time2 * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.buffer_compare_time2 * 1000000000)
								% cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%9lld.%03lldns\n", ns_time, ps_time);

		printf("HPS to FPGA DMA TIME: ");
		ns_time = (f2h_bridge.h2f_dma_time2 * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.h2f_dma_time2 * 1000000000)
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

		printf("FPGA to HPS DMA TIME: ");
		ns_time = (f2h_bridge.f2h_dma_time2 * 1000000000)
								/ cntfrq_el0;
		ps_time = (f2h_bridge.f2h_dma_time2 * 1000000000)
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
		puts("HPS to FPGA DMA busy error returned...\n");
		break;
	case(3):
		puts("HPS to FPGA DMA timeout error returned...\n");
		break;
	case(4):
		puts("FPGA to HPS DMA busy error returned...\n");
		break;
	case(5):
		puts("FPGA to HPS DMA timeout error returned...\n");
		break;
	case(6):
		puts("Buffer validation error returned...\n");
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

void do_the_interesting_thing(struct f2h_bridge_s *f2h_bridge) {

	int i;
	uint32_t gp_in;
	uint32_t sysid_id;
	uint32_t sysid_ts;
	uint64_t cntfrq_el0;
	uint64_t start_time;
	uint64_t end_time;
	uint64_t timeout;
	uint64_t temp;
	uint32_t temp_32;
	uint8_t *dma_buffer_0 = (void*)(F2H_BUF_0_BASE);
	uint8_t *dma_buffer_1 = (void*)(F2H_BUF_1_BASE);
	uint64_t *dma_buffer_0_word_ptr = (uint64_t *)dma_buffer_0;
	uint32_t descriptor[8];
	uint64_t dma_wr_ptr;
	uint64_t dma_rd_ptr;

	f2h_bridge->error = 1;

	/* validate the hps_gp_in signature */
	*((volatile uint32_t *)(HPS_GP_OUT_BASE)) = 0;
	gp_in = *((volatile uint32_t *)(HPS_GP_IN_BASE));

	f2h_bridge->gp_sig_value = gp_in;

	if(gp_in != F2H_SIG)
		return;

	/* validate the sysid signature */
	sysid_id = *((volatile uint32_t *)(F2H_SYSID_ID_BASE));

	f2h_bridge->sysid_id = sysid_id;

	if(sysid_id != F2H_SIG)
		return;

	/* capture the sysid timestamp */
	sysid_ts = *((volatile uint32_t *)(F2H_SYSID_TS_BASE));
	f2h_bridge->sysid_ts = sysid_ts;

	/*
	 * we will now DMA data from dma_buffer_0 to the FPGA OCRAM buffer
	 * and then DMA from the FPGA OCRAM buffer to dma_buffer_1
	 *
	 * the data cache WILL be flushed prior to triggering the dma so the
	 * coherent transactions WILL NOT hit the cache
	 */

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* clear the three buffers that we'll use for DMA transfers */
	/* this isn't necessary but for demonstration purposes we'll do it */
	memset(dma_buffer_0, 0, F2H_OCRAM_32K_SPAN);
	memset(dma_buffer_1, 0, F2H_OCRAM_32K_SPAN);
	memset((void*)(F2H_OCRAM_32K_BASE), 0, F2H_OCRAM_32K_SPAN);

	/* fill the initial buffer with a randomized data pattern */
	asm volatile (
		"dsb sy\n"
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	temp ^= 0xFbFdF1F3F5F7FbFd;
	temp += 0x0b0d010305070b0d;
	for(i = 0 ; i < (F2H_OCRAM_32K_SPAN / sizeof(uint64_t)) ; i++) {
		temp += 0x0b0d010305070b0d;
		dma_buffer_0_word_ptr[i] = temp++;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* flush the data cache */
	flush_dcache_range((uint64_t)dma_buffer_0,
		(uint64_t)((void*)(dma_buffer_0) + F2H_OCRAM_32K_SPAN));
	flush_dcache_range((uint64_t)dma_buffer_1,
		(uint64_t)((void*)(dma_buffer_1) + F2H_OCRAM_32K_SPAN));

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the dcache flush time */
	f2h_bridge->dcache_flush_time = end_time - start_time;

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	if(temp_32 != 0x00000002) {
		f2h_bridge->error = 2;
		return;
	}

	/* build our descriptor for dma_buffer_0 to FPGA OCRAM */
	descriptor[0] = (uint64_t)(dma_buffer_0) & 0xFFFFFFFF;
	descriptor[1] = MSGDMA_OCRAM_32K_BASE & 0xFFFFFFFF;
	descriptor[2] = F2H_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = (uint64_t)(dma_buffer_0) >> 32;
	descriptor[6] = MSGDMA_OCRAM_32K_BASE >> 32;
	descriptor[7] = 0x80000000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 8 ; i++) {
		((volatile uint32_t *)(F2H_MSGDMA_DES_BASE))[i] =
								descriptor[i];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"dsb sy\n"
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = ((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	while((temp_32 & 0x00000001) == 0x00000001) {
		asm volatile (
			"dsb sy\n"
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			f2h_bridge->error = 3;
			return;
		}
		temp_32 = ((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	f2h_bridge->h2f_dma_time = end_time - start_time;

	/* initialize intermediate DMA pointers for F2H transfer */
	dma_rd_ptr = MSGDMA_OCRAM_32K_BASE;
	dma_wr_ptr = (uint64_t)(dma_buffer_1);

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	if(temp_32 != 0x00000002) {
		f2h_bridge->error = 4;
		return;
	}

	/* build our descriptor for FPGA OCRAM to dma_buffer_0 */
	descriptor[0] = dma_rd_ptr & 0xFFFFFFFF;
	descriptor[1] = dma_wr_ptr & 0xFFFFFFFF;
	descriptor[2] = F2H_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = dma_rd_ptr >> 32;
	descriptor[6] = dma_wr_ptr >> 32;
	descriptor[7] = 0x80000000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 4 ; i++) {
		((volatile uint64_t *)(F2H_MSGDMA_DES_BASE))[i] =
			((uint64_t)(descriptor[(i * 2) + 1]) << 32) |
			descriptor[i * 2];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"dsb sy\n"
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = ((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	while((temp_32 & 0x00000001) == 0x00000001) {
		asm volatile (
			"dsb sy\n"
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			f2h_bridge->error = 5;
			return;
		}
		temp_32 =
		((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	f2h_bridge->f2h_dma_time = end_time - start_time;

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
	if(memcmp(dma_buffer_0, dma_buffer_1, F2H_OCRAM_32K_SPAN) == 0) {
		f2h_bridge->error = 0;
	} else {
		f2h_bridge->error = 6;
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	f2h_bridge->buffer_compare_time = end_time - start_time;

	/*
	 * we will now DMA data from dma_buffer_0 to the FPGA OCRAM buffer
	 * and then DMA from the FPGA OCRAM buffer to dma_buffer_1
	 *
	 * the data cache WILL NOT be flushed prior to triggering the dma so the
	 * coherent transactions WILL hit the cache
	 */

	/* get the system counter frequency to calculate timeout delays */
    	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* clear the three buffers that we'll use for DMA transfers */
	/* this isn't necessary but for demonstration purposes we'll do it */
	memset(dma_buffer_0, 0, F2H_OCRAM_32K_SPAN);
	memset(dma_buffer_1, 0, F2H_OCRAM_32K_SPAN);
	memset((void*)(F2H_OCRAM_32K_BASE), 0, F2H_OCRAM_32K_SPAN);

	/* fill the initial buffer with a randomized data pattern */
	asm volatile (
		"dsb sy\n"
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	temp ^= 0xFbFdF1F3F5F7FbFd;
	temp += 0x0b0d010305070b0d;
	for(i = 0 ; i < (F2H_OCRAM_32K_SPAN / sizeof(uint64_t)) ; i++) {
		temp += 0x0b0d010305070b0d;
		dma_buffer_0_word_ptr[i] = temp++;
	}

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	if(temp_32 != 0x00000002) {
		f2h_bridge->error2 = 2;
		return;
	}

	/* build our descriptor for dma_buffer_0 to FPGA OCRAM */
	descriptor[0] = (uint64_t)(dma_buffer_0) & 0xFFFFFFFF;
	descriptor[1] = MSGDMA_OCRAM_32K_BASE & 0xFFFFFFFF;
	descriptor[2] = F2H_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = (uint64_t)(dma_buffer_0) >> 32;
	descriptor[6] = MSGDMA_OCRAM_32K_BASE >> 32;
	descriptor[7] = 0x80000000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 8 ; i++) {
		((volatile uint32_t *)(F2H_MSGDMA_DES_BASE))[i] =
								descriptor[i];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"dsb sy\n"
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = ((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	while((temp_32 & 0x00000001) == 0x00000001) {
		asm volatile (
			"dsb sy\n"
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			f2h_bridge->error2 = 3;
			return;
		}
		temp_32 = ((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	f2h_bridge->h2f_dma_time2 = end_time - start_time;

	/* initialize intermediate DMA pointers for F2H transfer */
	dma_rd_ptr = MSGDMA_OCRAM_32K_BASE;
	dma_wr_ptr = (uint64_t)(dma_buffer_1);

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	if(temp_32 != 0x00000002) {
		f2h_bridge->error2 = 4;
		return;
	}

	/* build our descriptor for FPGA OCRAM to dma_buffer_0 */
	descriptor[0] = dma_rd_ptr & 0xFFFFFFFF;
	descriptor[1] = dma_wr_ptr & 0xFFFFFFFF;
	descriptor[2] = F2H_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = dma_rd_ptr >> 32;
	descriptor[6] = dma_wr_ptr >> 32;
	descriptor[7] = 0x80000000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 4 ; i++) {
		((volatile uint64_t *)(F2H_MSGDMA_DES_BASE))[i] =
			((uint64_t)(descriptor[(i * 2) + 1]) << 32) |
			descriptor[i * 2];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[start_time], cntpct_el0\n"
		: [start_time] "=r" (start_time)
	);

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"dsb sy\n"
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = ((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	while((temp_32 & 0x00000001) == 0x00000001) {
		asm volatile (
			"dsb sy\n"
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			f2h_bridge->error2 = 5;
			return;
		}
		temp_32 =
		((volatile uint32_t *)(F2H_MSGDMA_CSR_BASE))[0];
	}

	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the DMA time */
	f2h_bridge->f2h_dma_time2 = end_time - start_time;

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
	if(memcmp(dma_buffer_0, dma_buffer_1, F2H_OCRAM_32K_SPAN) == 0) {
		f2h_bridge->error2 = 0;
	} else {
		f2h_bridge->error2 = 6;
	}
	/* mark the time */
	asm volatile (
		"dsb sy\n"
		"mrs %[end_time], cntpct_el0\n"
		: [end_time] "=r" (end_time)
	);

	/* return the buffer compare time */
	f2h_bridge->buffer_compare_time2 = end_time - start_time;
}

