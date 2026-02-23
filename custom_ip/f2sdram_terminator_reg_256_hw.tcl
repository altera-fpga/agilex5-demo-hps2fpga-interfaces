#
# SPDX-FileCopyrightText: Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 23.4


#
# module f2sdram_terminator_reg_256
#
set_module_property DESCRIPTION ""
set_module_property NAME f2sdram_terminator_reg_256
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME f2sdram_terminator_reg_256
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property LOAD_ELABORATION_LIMIT 0
set_module_property PRE_COMP_MODULE_ENABLED false


#
# file sets
#
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH generate_verilog

add_fileset SIM_VERILOG SIM_VERILOG generate_verilog

add_fileset SIM_VHDL SIM_VHDL generate_verilog


#
# parameters
#


#
# display items
#


#
# connection point clock
#
add_interface clock clock end
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""
set_interface_property clock IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property clock SV_INTERFACE_TYPE ""
set_interface_property clock SV_INTERFACE_MODPORT_TYPE ""

add_interface_port clock clk clk Input 1


#
# connection point reset
#
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""
set_interface_property reset IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property reset SV_INTERFACE_TYPE ""
set_interface_property reset SV_INTERFACE_MODPORT_TYPE ""

add_interface_port reset reset reset Input 1


#
# connection point axi4_man
#
add_interface axi4_man axi4 start
set_interface_property axi4_man associatedClock clock
set_interface_property axi4_man associatedReset reset
set_interface_property axi4_man wakeupSignals false
set_interface_property axi4_man uniqueIdSupport false
set_interface_property axi4_man poison false
set_interface_property axi4_man traceSignals false
set_interface_property axi4_man readIssuingCapability 1
set_interface_property axi4_man writeIssuingCapability 1
set_interface_property axi4_man combinedIssuingCapability 1
set_interface_property axi4_man issuesINCRBursts true
set_interface_property axi4_man issuesWRAPBursts true
set_interface_property axi4_man issuesFIXEDBursts true
set_interface_property axi4_man ENABLED true
set_interface_property axi4_man EXPORT_OF ""
set_interface_property axi4_man PORT_NAME_MAP ""
set_interface_property axi4_man CMSIS_SVD_VARIABLES ""
set_interface_property axi4_man SVD_ADDRESS_GROUP ""
set_interface_property axi4_man IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property axi4_man SV_INTERFACE_TYPE ""
set_interface_property axi4_man SV_INTERFACE_MODPORT_TYPE ""

add_interface_port axi4_man man_araddr araddr Output 32
add_interface_port axi4_man man_arburst arburst Output 2
add_interface_port axi4_man man_arcache arcache Output 4
add_interface_port axi4_man man_arid arid Output 5
add_interface_port axi4_man man_arlen arlen Output 8
add_interface_port axi4_man man_arlock arlock Output 1
add_interface_port axi4_man man_arprot arprot Output 3
add_interface_port axi4_man man_arqos arqos Output 4
add_interface_port axi4_man man_arready arready Input 1
add_interface_port axi4_man man_arsize arsize Output 3
add_interface_port axi4_man man_arvalid arvalid Output 1
add_interface_port axi4_man man_awaddr awaddr Output 32
add_interface_port axi4_man man_awburst awburst Output 2
add_interface_port axi4_man man_awcache awcache Output 4
add_interface_port axi4_man man_awid awid Output 5
add_interface_port axi4_man man_awlen awlen Output 8
add_interface_port axi4_man man_awlock awlock Output 1
add_interface_port axi4_man man_awprot awprot Output 3
add_interface_port axi4_man man_awqos awqos Output 4
add_interface_port axi4_man man_awready awready Input 1
add_interface_port axi4_man man_awsize awsize Output 3
add_interface_port axi4_man man_awvalid awvalid Output 1
add_interface_port axi4_man man_bid bid Input 5
add_interface_port axi4_man man_bready bready Output 1
add_interface_port axi4_man man_bresp bresp Input 2
add_interface_port axi4_man man_bvalid bvalid Input 1
add_interface_port axi4_man man_rdata rdata Input 256
add_interface_port axi4_man man_rid rid Input 5
add_interface_port axi4_man man_rlast rlast Input 1
add_interface_port axi4_man man_rready rready Output 1
add_interface_port axi4_man man_rresp rresp Input 2
add_interface_port axi4_man man_rvalid rvalid Input 1
add_interface_port axi4_man man_wdata wdata Output 256
add_interface_port axi4_man man_wlast wlast Output 1
add_interface_port axi4_man man_wready wready Input 1
add_interface_port axi4_man man_wstrb wstrb Output 32
add_interface_port axi4_man man_wvalid wvalid Output 1
add_interface_port axi4_man man_aruser aruser Output 8
add_interface_port axi4_man man_awuser awuser Output 8
add_interface_port axi4_man man_wuser wuser Output 8
add_interface_port axi4_man man_buser buser Input 8
add_interface_port axi4_man man_arregion arregion Output 4
add_interface_port axi4_man man_ruser ruser Input 8
add_interface_port axi4_man man_awregion awregion Output 4

proc generate_verilog { output_name } {
set verilog_code {
//
// SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
// SPDX-License-Identifier: MIT-0
//

`timescale 1 ps / 1 ps
module ${output_name} (

	//
	// clock and reset
	//
	input  wire         clk,
	input  wire         reset,

	//
	// AXI4 manager
	//
	output wire \[31:0\]  man_araddr,
	output wire \[1:0\]   man_arburst,
	output wire \[3:0\]   man_arcache,
	output wire \[4:0\]   man_arid,
	output wire \[7:0\]   man_arlen,
	output wire         man_arlock,
	output wire \[2:0\]   man_arprot,
	output wire \[3:0\]   man_arqos,
	input  wire         man_arready,
	output wire \[2:0\]   man_arsize,
	output wire         man_arvalid,
	output wire \[31:0\]  man_awaddr,
	output wire \[1:0\]   man_awburst,
	output wire \[3:0\]   man_awcache,
	output wire \[4:0\]   man_awid,
	output wire \[7:0\]   man_awlen,
	output wire         man_awlock,
	output wire \[2:0\]   man_awprot,
	output wire \[3:0\]   man_awqos,
	input  wire         man_awready,
	output wire \[2:0\]   man_awsize,
	output wire         man_awvalid,
	input  wire \[4:0\]   man_bid,
	output wire         man_bready,
	input  wire \[1:0\]   man_bresp,
	input  wire         man_bvalid,
	input  wire \[255:0\] man_rdata,
	input  wire \[4:0\]   man_rid,
	input  wire         man_rlast,
	output wire         man_rready,
	input  wire \[1:0\]   man_rresp,
	input  wire         man_rvalid,
	output wire \[255:0\] man_wdata,
	output wire         man_wlast,
	input  wire         man_wready,
	output wire \[31:0\]  man_wstrb,
	output wire         man_wvalid,
	output wire \[7:0\]   man_aruser,
	output wire \[7:0\]   man_awuser,
	output wire \[7:0\]   man_wuser,
	input  wire \[7:0\]   man_buser,
	output wire \[3:0\]   man_arregion,
	input  wire \[7:0\]   man_ruser,
	output wire \[3:0\]   man_awregion
);

(* preserve, noprune *) reg           in_arready;
(* preserve, noprune *) reg           in_awready;
(* preserve, noprune *) reg \[4:0\]   in_bid;
(* preserve, noprune *) reg \[1:0\]   in_bresp;
(* preserve, noprune *) reg           in_bvalid;
(* preserve, noprune *) reg \[255:0\] in_rdata;
(* preserve, noprune *) reg \[4:0\]   in_rid;
(* preserve, noprune *) reg           in_rlast;
(* preserve, noprune *) reg \[1:0\]   in_rresp;
(* preserve, noprune *) reg           in_rvalid;
(* preserve, noprune *) reg           in_wready;
(* preserve, noprune *) reg \[7:0\]   in_buser;
(* preserve, noprune *) reg \[7:0\]   in_ruser;

(* preserve, noprune *) reg \[31:0\]  out_araddr;
(* preserve, noprune *) reg \[1:0\]   out_arburst;
(* preserve, noprune *) reg \[3:0\]   out_arcache;
(* preserve, noprune *) reg \[4:0\]   out_arid;
(* preserve, noprune *) reg \[7:0\]   out_arlen;
(* preserve, noprune *) reg           out_arlock;
(* preserve, noprune *) reg \[2:0\]   out_arprot;
(* preserve, noprune *) reg \[3:0\]   out_arqos;
(* preserve, noprune *) reg \[2:0\]   out_arsize;
(* preserve, noprune *) reg           out_arvalid;
(* preserve, noprune *) reg \[31:0\]  out_awaddr;
(* preserve, noprune *) reg \[1:0\]   out_awburst;
(* preserve, noprune *) reg \[3:0\]   out_awcache;
(* preserve, noprune *) reg \[4:0\]   out_awid;
(* preserve, noprune *) reg \[7:0\]   out_awlen;
(* preserve, noprune *) reg           out_awlock;
(* preserve, noprune *) reg \[2:0\]   out_awprot;
(* preserve, noprune *) reg \[3:0\]   out_awqos;
(* preserve, noprune *) reg \[2:0\]   out_awsize;
(* preserve, noprune *) reg           out_awvalid;
(* preserve, noprune *) reg           out_bready;
(* preserve, noprune *) reg           out_rready;
(* preserve, noprune *) reg \[255:0\] out_wdata;
(* preserve, noprune *) reg           out_wlast;
(* preserve, noprune *) reg \[31:0\]  out_wstrb;
(* preserve, noprune *) reg           out_wvalid;
(* preserve, noprune *) reg \[7:0\]   out_aruser;
(* preserve, noprune *) reg \[7:0\]   out_awuser;
(* preserve, noprune *) reg \[7:0\]   out_wuser;
(* preserve, noprune *) reg \[3:0\]   out_arregion;
(* preserve, noprune *) reg \[3:0\]   out_awregion;

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		in_arready <= 1'h0;
		in_awready <= 1'h0;
		in_bid <= 5'h0;
		in_bresp <= 2'h0;
		in_bvalid <= 1'h0;
		in_rdata <= 256'h0;
		in_rid <= 5'h0;
		in_rlast <= 1'h0;
		in_rresp <= 2'h0;
		in_rvalid <= 1'h0;
		in_wready <= 1'h0;
		in_buser <= 8'h0;
		in_ruser <= 8'h0;
	end
	else begin
		in_arready <= man_arready;
		in_awready <= man_awready;
		in_bid <= man_bid;
		in_bresp <= man_bresp;
		in_bvalid <= man_bvalid;
		in_rdata <= man_rdata;
		in_rid <= man_rid;
		in_rlast <= man_rlast;
		in_rresp <= man_rresp;
		in_rvalid <= man_rvalid;
		in_wready <= man_wready;
		in_buser <= man_buser;
		in_ruser <= man_ruser;
	end
end

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		out_araddr <= 32'h0;
		out_arburst <= 2'h0;
		out_arcache <= 4'h0;
		out_arid <= 5'h0;
		out_arlen <= 8'h0;
		out_arlock <= 1'h0;
		out_arprot <= 3'h0;
		out_arqos <= 4'h0;
		out_arsize <= 3'h0;
		out_arvalid <= 1'h0;
		out_awaddr <= 32'h0;
		out_awburst <= 2'h0;
		out_awcache <= 4'h0;
		out_awid <= 5'h0;
		out_awlen <= 8'h0;
		out_awlock <= 1'h0;
		out_awprot <= 3'h0;
		out_awqos <= 4'h0;
		out_awsize <= 3'h0;
		out_awvalid <= 1'h0;
		out_bready <= 1'h0;
		out_rready <= 1'h0;
		out_wdata <= 256'h0;
		out_wlast <= 1'h0;
		out_wstrb <= 32'h0;
		out_wvalid <= 1'h0;
		out_aruser <= 8'h0;
		out_awuser <= 8'h0;
		out_wuser <= 8'h0;
		out_arregion <= 4'h0;
		out_awregion <= 4'h0;
	end
	else begin
		out_araddr <= 32'h0;
		out_arburst <= 2'h0;
		out_arcache <= 4'h0;
		out_arid <= 5'h0;
		out_arlen <= 8'h0;
		out_arlock <= 1'h0;
		out_arprot <= 3'h0;
		out_arqos <= 4'h0;
		out_arsize <= 3'h0;
		out_arvalid <= 1'h0;
		out_awaddr <= 32'h0;
		out_awburst <= 2'h0;
		out_awcache <= 4'h0;
		out_awid <= 5'h0;
		out_awlen <= 8'h0;
		out_awlock <= 1'h0;
		out_awprot <= 3'h0;
		out_awqos <= 4'h0;
		out_awsize <= 3'h0;
		out_awvalid <= 1'h0;
		out_bready <= 1'h0;
		out_rready <= 1'h0;
		out_wdata <= in_rdata;
		out_wlast <= 1'h0;
		out_wstrb <= 32'h0;
		out_wvalid <= 1'h0;
		out_aruser <= 8'h0;
		out_awuser <= 8'h0;
		out_wuser <= 8'h0;
		out_arregion <= 4'h0;
		out_awregion <= 4'h0;
	end
end

assign man_araddr = out_araddr;
assign man_arburst = out_arburst;
assign man_arcache = out_arcache;
assign man_arid = out_arid;
assign man_arlen = out_arlen;
assign man_arlock = out_arlock;
assign man_arprot = out_arprot;
assign man_arqos = out_arqos;
assign man_arsize = out_arsize;
assign man_arvalid = out_arvalid;
assign man_awaddr = out_awaddr;
assign man_awburst = out_awburst;
assign man_awcache = out_awcache;
assign man_awid = out_awid;
assign man_awlen = out_awlen;
assign man_awlock = out_awlock;
assign man_awprot = out_awprot;
assign man_awqos = out_awqos;
assign man_awsize = out_awsize;
assign man_awvalid = out_awvalid;
assign man_bready = out_bready;
assign man_rready = out_rready;
assign man_wdata = out_wdata;
assign man_wlast = out_wlast;
assign man_wstrb = out_wstrb;
assign man_wvalid = out_wvalid;
assign man_aruser = out_aruser;
assign man_awuser = out_awuser;
assign man_wuser = out_wuser;
assign man_arregion = out_arregion;
assign man_awregion = out_awregion;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
