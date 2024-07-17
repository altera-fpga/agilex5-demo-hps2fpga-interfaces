#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 23.4


#
# module f2sdram_terminator_64
#
set_module_property DESCRIPTION ""
set_module_property NAME f2sdram_terminator_64
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME f2sdram_terminator_64
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
add_interface_port axi4_man man_rdata rdata Input 64
add_interface_port axi4_man man_rid rid Input 5
add_interface_port axi4_man man_rlast rlast Input 1
add_interface_port axi4_man man_rready rready Output 1
add_interface_port axi4_man man_rresp rresp Input 2
add_interface_port axi4_man man_rvalid rvalid Input 1
add_interface_port axi4_man man_wdata wdata Output 64
add_interface_port axi4_man man_wlast wlast Output 1
add_interface_port axi4_man man_wready wready Input 1
add_interface_port axi4_man man_wstrb wstrb Output 8
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
	input  wire \[63:0\] man_rdata,
	input  wire \[4:0\]   man_rid,
	input  wire         man_rlast,
	output wire         man_rready,
	input  wire \[1:0\]   man_rresp,
	input  wire         man_rvalid,
	output wire \[63:0\] man_wdata,
	output wire         man_wlast,
	input  wire         man_wready,
	output wire \[7:0\]  man_wstrb,
	output wire         man_wvalid,
	output wire \[7:0\]   man_aruser,
	output wire \[7:0\]   man_awuser,
	output wire \[7:0\]   man_wuser,
	input  wire \[7:0\]   man_buser,
	output wire \[3:0\]   man_arregion,
	input  wire \[7:0\]   man_ruser,
	output wire \[3:0\]   man_awregion
);

assign man_wuser    = 8'h00;
assign man_awburst  = 2'b00;
assign man_arregion = 4'h0;
assign man_arlen    = 8'h00;
assign man_arqos    = 4'h0;
assign man_awuser   = 8'hE0;
assign man_wstrb    = 8'h00;
assign man_rready   = 1'b0;
assign man_awlen    = 8'h00;
assign man_awqos    = 4'h0;
assign man_arcache  = 4'h2;
assign man_araddr   = 32'h0;
assign man_wvalid   = 1'b0;
assign man_arprot   = 3'b011;
assign man_arvalid  = 1'b0;
assign man_awprot   = 3'b011;
assign man_wdata    = man_rdata;
assign man_arid     = 5'h0;
assign man_awcache  = 4'h2;
assign man_arlock   = 1'b0;
assign man_awlock   = 1'b0;
assign man_awaddr   = 32'h0;
assign man_arburst  = 2'b00;
assign man_arsize   = 3'b000;
assign man_bready   = 1'b0;
assign man_wlast    = 1'b0;
assign man_awregion = 4'h0;
assign man_awid     = 5'h0;
assign man_awsize   = 3'b000;
assign man_awvalid  = 1'b0;
assign man_aruser   = 8'hE0;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
