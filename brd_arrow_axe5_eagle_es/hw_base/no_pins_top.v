/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1ns/10ps

module no_pins_top (

	input         HPS_OSC_CLK_25MHz,

	output        HPS_UART0_TX,
	input         HPS_UART0_RX,

	output        LPDDR4A_CK_P,
	output        LPDDR4A_CK_N,
	output        LPDDR4A_RST,
	input         LPDDR4A_REFCK_p,
	output [5:0]  LPDDR4A_CA,
	output	      LPDDR4A_CKE,
	output	      LPDDR4A_CS_N,
	inout  [31:0] LPDDR4A_DQ,
	inout         LPDDR4A_DQSA1_p,
	inout         LPDDR4A_DQSA1_n,
	inout         LPDDR4A_DQSA0_p,
	inout         LPDDR4A_DQSA0_n,
	inout         LPDDR4A_DQSB1_p,
	inout         LPDDR4A_DQSB1_n,
	inout         LPDDR4A_DQSB0_p,
	inout         LPDDR4A_DQSB0_n,
	inout         LPDDR4A_DMB1,
	inout         LPDDR4A_DMB0,
	inout         LPDDR4A_DMA1,
	inout         LPDDR4A_DMA0,
	input         LPDDR4A_OCT_RZQIN
);

no_pins_pd_top hps_system (

	.hps_io_hps_osc_clk (HPS_OSC_CLK_25MHz),

	.hps_io_uart0_tx    (HPS_UART0_TX),
	.hps_io_uart0_rx    (HPS_UART0_RX),

	.emif_bank3a_hps_emif_ref_clk_0_clk     (LPDDR4A_REFCK_p),
	.emif_bank3a_hps_emif_mem_0_mem_ck_t    (LPDDR4A_CK_P),
	.emif_bank3a_hps_emif_mem_0_mem_ck_c    (LPDDR4A_CK_N),
	.emif_bank3a_hps_emif_mem_0_mem_cke     (LPDDR4A_CKE),
	.emif_bank3a_hps_emif_mem_0_mem_reset_n (LPDDR4A_RST),
	.emif_bank3a_hps_emif_mem_0_mem_cs      (LPDDR4A_CS_N),
	.emif_bank3a_hps_emif_mem_0_mem_ca      (LPDDR4A_CA),
	.emif_bank3a_hps_emif_mem_0_mem_dq      (LPDDR4A_DQ),
	.emif_bank3a_hps_emif_mem_0_mem_dqs_t   ({LPDDR4A_DQSB1_p, LPDDR4A_DQSB0_p, LPDDR4A_DQSA1_p, LPDDR4A_DQSA0_p}),
	.emif_bank3a_hps_emif_mem_0_mem_dqs_c   ({LPDDR4A_DQSB1_n, LPDDR4A_DQSB0_n, LPDDR4A_DQSA1_n, LPDDR4A_DQSA0_n}),
	.emif_bank3a_hps_emif_mem_0_mem_dmi     ({LPDDR4A_DMB1,LPDDR4A_DMB0,LPDDR4A_DMA1,LPDDR4A_DMA0}),
	.emif_bank3a_hps_emif_oct_0_oct_rzqin   (LPDDR4A_OCT_RZQIN)
);

endmodule
