/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1ns/10ps

module no_pins_top (

	input         hps_osc_clk,

	output        hps_uart0_TX,
	input         hps_uart0_RX,

	output   wire          emif_hps_emif_mem_0_mem_ck_t,
	output   wire          emif_hps_emif_mem_0_mem_ck_c,
	output   wire [16:0]   emif_hps_emif_mem_0_mem_a,
	output   wire          emif_hps_emif_mem_0_mem_act_n,
	output   wire [1:0]    emif_hps_emif_mem_0_mem_ba,
	output   wire [1:0]    emif_hps_emif_mem_0_mem_bg,
	output   wire          emif_hps_emif_mem_0_mem_cke,
	output   wire          emif_hps_emif_mem_0_mem_cs_n,
	output   wire          emif_hps_emif_mem_0_mem_odt,
	output   wire          emif_hps_emif_mem_0_mem_reset_n,
	output   wire          emif_hps_emif_mem_0_mem_par,
	input    wire          emif_hps_emif_mem_0_mem_alert_n,
	input    wire          emif_hps_emif_oct_0_oct_rzqin,
	input    wire          emif_hps_emif_ref_clk_0_clk,
	inout    wire [3:0]    emif_hps_emif_mem_0_mem_dqs_t,
	inout    wire [3:0]    emif_hps_emif_mem_0_mem_dqs_c,
	inout    wire [31:0]   emif_hps_emif_mem_0_mem_dq
);

no_pins_pd_top hps_system (

	.hps_io_hps_osc_clk (hps_osc_clk),

	.hps_io_uart0_tx    (hps_uart0_TX),
	.hps_io_uart0_rx    (hps_uart0_RX),

	.emif_bank3a_hps_emif_mem_0_mem_ck_t              (emif_hps_emif_mem_0_mem_ck_t),
	.emif_bank3a_hps_emif_mem_0_mem_ck_c              (emif_hps_emif_mem_0_mem_ck_c),
	.emif_bank3a_hps_emif_mem_0_mem_a                 (emif_hps_emif_mem_0_mem_a),
	.emif_bank3a_hps_emif_mem_0_mem_act_n             (emif_hps_emif_mem_0_mem_act_n),
	.emif_bank3a_hps_emif_mem_0_mem_ba                (emif_hps_emif_mem_0_mem_ba),
	.emif_bank3a_hps_emif_mem_0_mem_bg                (emif_hps_emif_mem_0_mem_bg),
	.emif_bank3a_hps_emif_mem_0_mem_cke               (emif_hps_emif_mem_0_mem_cke),
	.emif_bank3a_hps_emif_mem_0_mem_cs_n              (emif_hps_emif_mem_0_mem_cs_n),
	.emif_bank3a_hps_emif_mem_0_mem_odt               (emif_hps_emif_mem_0_mem_odt),
	.emif_bank3a_hps_emif_mem_0_mem_reset_n           (emif_hps_emif_mem_0_mem_reset_n),
	.emif_bank3a_hps_emif_mem_0_mem_par               (emif_hps_emif_mem_0_mem_par),
	.emif_bank3a_hps_emif_mem_0_mem_alert_n           (emif_hps_emif_mem_0_mem_alert_n),
	.emif_bank3a_hps_emif_mem_0_mem_dqs_t             (emif_hps_emif_mem_0_mem_dqs_t),
	.emif_bank3a_hps_emif_mem_0_mem_dqs_c             (emif_hps_emif_mem_0_mem_dqs_c),
	.emif_bank3a_hps_emif_mem_0_mem_dq                (emif_hps_emif_mem_0_mem_dq),
	.emif_bank3a_hps_emif_oct_0_oct_rzqin             (emif_hps_emif_oct_0_oct_rzqin),
	.emif_bank3a_hps_emif_ref_clk_0_clk               (emif_hps_emif_ref_clk_0_clk)
);

endmodule
