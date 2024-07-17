/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1ns/10ps

module no_pins_top (

	input	wire		hps_io_hps_osc_clk,

	output	wire		hps_io_uart0_tx,
	input	wire		hps_io_uart0_rx,

	input	wire		lpddr4_m1_refclk,
	output	wire [5:0]	lpddr4_m1_ca,
	output	wire		lpddr4_m1_ck_t,
	output	wire		lpddr4_m1_ck_c,
	output	wire [1:0]	lpddr4_m1_cke,
	output	wire [1:0]	lpddr4_m1_cs,
	output	wire		lpddr4_m1_reset_n,
	inout	wire [31:0]	lpddr4_m1_dq,
	inout	wire [3:0]	lpddr4_m1_dqs_t,
	inout	wire [3:0]	lpddr4_m1_dqs_c,
	inout	wire [3:0]	lpddr4_m1_dmi,
	input	wire		lpddr4_m1_rzqin
);

no_pins_pd_top hps_system (

	.hps_io_hps_osc_clk (hps_io_hps_osc_clk),

	.hps_io_uart0_tx    (hps_io_uart0_tx),
	.hps_io_uart0_rx    (hps_io_uart0_rx),

	.emif_bank3a_hps_emif_mem_0_mem_ck_t    (lpddr4_m1_ck_t),
	.emif_bank3a_hps_emif_mem_0_mem_ck_c    (lpddr4_m1_ck_c),
	.emif_bank3a_hps_emif_mem_0_mem_cke     (lpddr4_m1_cke),
	.emif_bank3a_hps_emif_mem_0_mem_reset_n (lpddr4_m1_reset_n),
	.emif_bank3a_hps_emif_mem_0_mem_cs      (lpddr4_m1_cs),
	.emif_bank3a_hps_emif_mem_0_mem_ca      (lpddr4_m1_ca),
	.emif_bank3a_hps_emif_mem_0_mem_dq      (lpddr4_m1_dq),
	.emif_bank3a_hps_emif_mem_0_mem_dqs_t   (lpddr4_m1_dqs_t),
	.emif_bank3a_hps_emif_mem_0_mem_dqs_c   (lpddr4_m1_dqs_c),
	.emif_bank3a_hps_emif_mem_0_mem_dmi     (lpddr4_m1_dmi),
	.emif_bank3a_hps_emif_oct_0_oct_rzqin   (lpddr4_m1_rzqin),
	.emif_bank3a_hps_emif_ref_clk_0_clk     (lpddr4_m1_refclk)
);

endmodule
