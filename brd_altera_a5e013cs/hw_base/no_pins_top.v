/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1ns/10ps

module no_pins_top (

	input         hps_osc_clk,

	output        hps_uart0_TX,
	input         hps_uart0_RX,

	output wire        emif_hps_emif_mem_0_mem_ck_t,
	output wire        emif_hps_emif_mem_0_mem_ck_c,
	output wire        emif_hps_emif_mem_0_mem_cke,
	output wire        emif_hps_emif_mem_0_mem_reset_n,
	input  wire        emif_hps_emif_oct_0_oct_rzqin,
	input  wire        emif_hps_emif_ref_clk_0_clk,
	inout  wire [ 3:0] emif_hps_emif_mem_0_mem_dqs_t,
	inout  wire [ 3:0] emif_hps_emif_mem_0_mem_dqs_c,
	inout  wire [31:0] emif_hps_emif_mem_0_mem_dq,
	output wire        emif_hps_emif_mem_0_mem_cs,
	output wire [ 5:0] emif_hps_emif_mem_0_mem_ca,
	inout  wire [ 3:0] emif_hps_emif_mem_0_mem_dmi
);

no_pins_pd_top hps_system (

	.hps_io_hps_osc_clk (hps_osc_clk),

	.hps_io_uart0_tx    (hps_uart0_TX),
	.hps_io_uart0_rx    (hps_uart0_RX),

        .emif_bank3a_hps_mem_0_mem_cs            (emif_hps_emif_mem_0_mem_cs),
        .emif_bank3a_hps_mem_0_mem_ca            (emif_hps_emif_mem_0_mem_ca),
        .emif_bank3a_hps_mem_0_mem_cke           (emif_hps_emif_mem_0_mem_cke),
        .emif_bank3a_hps_mem_0_mem_dq            (emif_hps_emif_mem_0_mem_dq),
        .emif_bank3a_hps_mem_0_mem_dqs_t         (emif_hps_emif_mem_0_mem_dqs_t),
        .emif_bank3a_hps_mem_0_mem_dqs_c         (emif_hps_emif_mem_0_mem_dqs_c),
        .emif_bank3a_hps_mem_0_mem_dmi           (emif_hps_emif_mem_0_mem_dmi),
        .emif_bank3a_hps_mem_ck_0_mem_ck_t       (emif_hps_emif_mem_0_mem_ck_t),
        .emif_bank3a_hps_mem_ck_0_mem_ck_c       (emif_hps_emif_mem_0_mem_ck_c),
        .emif_bank3a_hps_mem_reset_n_mem_reset_n (emif_hps_emif_mem_0_mem_reset_n),
        .emif_bank3a_hps_oct_0_oct_rzqin         (emif_hps_emif_oct_0_oct_rzqin),
        .emif_bank3a_hps_ref_clk_clk             (emif_hps_emif_ref_clk_0_clk)

);

endmodule
