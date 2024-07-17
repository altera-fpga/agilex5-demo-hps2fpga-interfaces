/*
 * SPDX-FileCopyrightText: Copyright (C) 2021-2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1 ps / 1 ps
module default_subordinate #(
	parameter [0:0]  ALLOW_AWREADY = 1,
	parameter [0:0]  ALLOW_ARREADY = 1,
	parameter [0:0]  ALLOW_BVALID  = 1,
	parameter [0:0]  ALLOW_RVALID  = 1,
	parameter [1:0]  DEFAULT_BRESP = 2'b00,
	parameter [1:0]  DEFAULT_RRESP = 2'b00,
	parameter [31:0] DEFAULT_RDATA = 32'h0000_006f
) (

	// clock and reset
	input  wire        clk,
	input  wire        reset,

	// DEFAULT AXI4-lite subordinate
	input  wire [11:0] default_sub_araddr,
	input  wire [2:0]  default_sub_arprot,
	output wire        default_sub_arready,
	input  wire        default_sub_arvalid,
	input  wire [11:0] default_sub_awaddr,
	input  wire [2:0]  default_sub_awprot,
	output wire        default_sub_awready,
	input  wire        default_sub_awvalid,
	input  wire        default_sub_bready,
	output wire [1:0]  default_sub_bresp,
	output wire        default_sub_bvalid,
	output wire [31:0] default_sub_rdata,
	input  wire        default_sub_rready,
	output wire [1:0]  default_sub_rresp,
	output wire        default_sub_rvalid,
	input  wire [31:0] default_sub_wdata,
	output wire        default_sub_wready,
	input  wire [3:0]  default_sub_wstrb,
	input  wire        default_sub_wvalid,

	// status outputs
	output wire        awvalid_reset,
	output wire        awvalid_irq,
	output wire        awvalid_conduit,

	output wire        wvalid_reset,
	output wire        wvalid_irq,
	output wire        wvalid_conduit,

	output wire        arvalid_reset,
	output wire        arvalid_irq,
	output wire        arvalid_conduit,

	output wire        any_valid_reset,
	output wire        any_valid_irq,
	output wire        any_valid_conduit
);

reg default_awvalid_reg;
reg default_wvalid_reg;
reg default_bvalid_reg;
reg default_arvalid_reg;
reg default_rvalid_reg;

reg default_awvalid_once_reg;
reg default_wvalid_once_reg;
reg default_arvalid_once_reg;

// -----------------------------------------------------------------------------
// status outputs, create three different interfaces for each
// -----------------------------------------------------------------------------
assign awvalid_reset   = default_awvalid_once_reg;
assign awvalid_irq     = awvalid_reset;
assign awvalid_conduit = awvalid_reset;

assign wvalid_reset   = default_wvalid_once_reg;
assign wvalid_irq     = wvalid_reset;
assign wvalid_conduit = wvalid_reset;

assign arvalid_reset   = default_arvalid_once_reg;
assign arvalid_irq     = arvalid_reset;
assign arvalid_conduit = arvalid_reset;

assign any_valid_reset   = awvalid_reset | wvalid_reset | arvalid_reset;
assign any_valid_irq     = any_valid_reset;
assign any_valid_conduit = any_valid_reset;

// -----------------------------------------------------------------------------
// DEFAULT subordinate control - write channels
// -----------------------------------------------------------------------------

assign default_sub_bresp = DEFAULT_BRESP;
assign default_sub_wready = (ALLOW_AWREADY == 1) ? ~default_wvalid_reg : 1'b0;
assign default_sub_awready = (ALLOW_AWREADY == 1) ? ~default_awvalid_reg : 1'b0;
assign default_sub_bvalid = default_bvalid_reg;

always @ (posedge clk or posedge reset) begin
if(reset) begin
	default_awvalid_reg <= 1'b0;
	default_wvalid_reg <= 1'b0;
	default_bvalid_reg <= 1'b0;
	default_awvalid_once_reg <= 1'b0;
	default_wvalid_once_reg <= 1'b0;
end else begin
	if((ALLOW_AWREADY == 0) & default_sub_awvalid) begin
		default_awvalid_once_reg <= 1'b1;
	end
	if(default_sub_awready & default_sub_awvalid) begin
		default_awvalid_reg <= 1'b1;
		default_awvalid_once_reg <= 1'b1;
	end
	if((ALLOW_AWREADY == 0) & default_sub_wvalid) begin
		default_wvalid_once_reg <= 1'b1;
	end
	if(default_sub_wready & default_sub_wvalid) begin
		default_wvalid_reg <= 1'b1;
		default_wvalid_once_reg <= 1'b1;
	end
	if(default_awvalid_reg & default_wvalid_reg & ~default_bvalid_reg) begin
		default_bvalid_reg <= (ALLOW_RVALID == 1) ? 1'b1 : 1'b0;
	end
	if(default_sub_bready & default_sub_bvalid) begin
		default_awvalid_reg <= 1'b0;
		default_wvalid_reg <= 1'b0;
		default_bvalid_reg <= 1'b0;
	end
end
end

// -----------------------------------------------------------------------------
// DEFAULT subordinate control - read channels
// -----------------------------------------------------------------------------

assign default_sub_rresp = DEFAULT_RRESP;
assign default_sub_arready = (ALLOW_ARREADY == 1) ? ~default_arvalid_reg : 1'b0;
assign default_sub_rvalid = default_rvalid_reg;
assign default_sub_rdata = DEFAULT_RDATA;

always @ (posedge clk or posedge reset) begin
if(reset) begin
	default_arvalid_reg <= 1'b0;
	default_rvalid_reg <= 1'b0;
	default_arvalid_once_reg <= 1'b0;

end else begin
	if((ALLOW_ARREADY == 0) & default_sub_arvalid) begin
		default_arvalid_once_reg <= 1'b1;
	end
	if(default_sub_arready & default_sub_arvalid) begin
		default_arvalid_reg <= 1'b1;
		default_arvalid_once_reg <= 1'b1;
	end
	if(default_arvalid_reg & ~default_rvalid_reg) begin
		default_rvalid_reg <= (ALLOW_RVALID == 1) ? 1'b1 : 1'b0;
	end
	if(default_sub_rready & default_sub_rvalid) begin
		default_arvalid_reg <= 1'b0;
		default_rvalid_reg <= 1'b0;
	end
end
end

endmodule

