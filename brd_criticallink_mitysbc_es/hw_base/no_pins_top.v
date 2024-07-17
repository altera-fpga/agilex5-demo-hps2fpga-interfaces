/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1ns/10ps

module no_pins_top (

	input         i_hps_osc_clk,

	output        i_uart1_tx,
	input         i_uart1_rx,

	output        hps_mem_ck_t,
	output        hps_mem_ck_c,
	output        hps_mem_reset_n,
	input         i_hps_emif_ref_clk,
	output [5:0]  hps_mem_ca,
	output [1:0]  hps_mem_cke,
	output [1:0]  hps_mem_cs,
	inout  [31:0] hps_mem_dq,
	inout  [3:0]  hps_mem_dqs_t,
	inout  [3:0]  hps_mem_dqs_c,
	inout  [3:0]  hps_mem_dmi,
	input         hps_oct_rzqin
);

no_pins_pd_top hps_system (

	.hps_io_hps_osc_clk (i_hps_osc_clk),

	.hps_io_uart1_tx    (i_uart1_tx),
	.hps_io_uart1_rx    (i_uart1_rx),

	.emif_bank3a_hps_emif_ref_clk_0_clk     (i_hps_emif_ref_clk),
	.emif_bank3a_hps_emif_mem_0_mem_ck_t    (hps_mem_ck_t),
	.emif_bank3a_hps_emif_mem_0_mem_ck_c    (hps_mem_ck_c),
	.emif_bank3a_hps_emif_mem_0_mem_cke     (hps_mem_cke),
	.emif_bank3a_hps_emif_mem_0_mem_reset_n (hps_mem_reset_n),
	.emif_bank3a_hps_emif_mem_0_mem_cs      (hps_mem_cs),
	.emif_bank3a_hps_emif_mem_0_mem_ca      (hps_mem_ca),
	.emif_bank3a_hps_emif_mem_0_mem_dq      (hps_mem_dq),
	.emif_bank3a_hps_emif_mem_0_mem_dqs_t   (hps_mem_dqs_t),
	.emif_bank3a_hps_emif_mem_0_mem_dqs_c   (hps_mem_dqs_c),
	.emif_bank3a_hps_emif_mem_0_mem_dmi     (hps_mem_dmi),
	.emif_bank3a_hps_emif_oct_0_oct_rzqin   (hps_oct_rzqin)
);

endmodule
