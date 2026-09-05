/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
 * SPDX-FileCopyrightText: Copyright (C) 2026 Altera Corporation
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1ns/10ps

module no_pins_top (

	input         HPS_CLK_25,

	output        HPS_UART_TX,
	input         HPS_UART_RX,

	output wire        LPDDR4A_CK,
	output wire        LPDDR4A_CK_n,
	output wire        LPDDR4A_CKE,
	output wire        LPDDR4A_RESET_n,
	input  wire        LPDDR4A_RZQ,
	input  wire        LPDDR4A_REFCLK_p,
	inout  wire [ 3:0] LPDDR4A_DQS,
	inout  wire [ 3:0] LPDDR4A_DQS_n,
	inout  wire [31:0] LPDDR4A_DQ,
	output wire        LPDDR4A_CS_n,
	output wire [ 5:0] LPDDR4A_CA,
	inout  wire [ 3:0] LPDDR4A_DM
);

no_pins_pd_top hps_system (

	.hps_io_hps_osc_clk (HPS_CLK_25),

	.hps_io_uart1_tx    (HPS_UART_TX),
	.hps_io_uart1_rx    (HPS_UART_RX),

        .emif_bank3a_hps_mem_0_mem_cs            (LPDDR4A_CS_n),
        .emif_bank3a_hps_mem_0_mem_ca            (LPDDR4A_CA),
        .emif_bank3a_hps_mem_0_mem_cke           (LPDDR4A_CKE),
        .emif_bank3a_hps_mem_0_mem_dq            (LPDDR4A_DQ),
        .emif_bank3a_hps_mem_0_mem_dqs_t         (LPDDR4A_DQS),
        .emif_bank3a_hps_mem_0_mem_dqs_c         (LPDDR4A_DQS_n),
        .emif_bank3a_hps_mem_0_mem_dmi           (LPDDR4A_DM),
        .emif_bank3a_hps_mem_ck_0_mem_ck_t       (LPDDR4A_CK),
        .emif_bank3a_hps_mem_ck_0_mem_ck_c       (LPDDR4A_CK_n),
        .emif_bank3a_hps_mem_reset_n_mem_reset_n (LPDDR4A_RESET_n),
        .emif_bank3a_hps_oct_0_oct_rzqin         (LPDDR4A_RZQ),
        .emif_bank3a_hps_ref_clk_clk             (LPDDR4A_REFCLK_p)

);

endmodule
