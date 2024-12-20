#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 24.3


#
# module f2h_terminator_256
#
set_module_property DESCRIPTION ""
set_module_property NAME f2h_terminator_256
set_module_property VERSION 1.1
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME f2h_terminator_256
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
# connection point ace5lite_manager
#
add_interface ace5lite_manager ace5lite start
set_interface_property ace5lite_manager associatedClock clock
set_interface_property ace5lite_manager associatedReset reset
set_interface_property ace5lite_manager wakeupSignals false
set_interface_property ace5lite_manager uniqueIdSupport false
set_interface_property ace5lite_manager poison false
set_interface_property ace5lite_manager traceSignals false
set_interface_property ace5lite_manager dataCheck false
set_interface_property ace5lite_manager addressCheck false
set_interface_property ace5lite_manager securityAttribute false
set_interface_property ace5lite_manager userData false
set_interface_property ace5lite_manager readIssuingCapability 1
set_interface_property ace5lite_manager writeIssuingCapability 1
set_interface_property ace5lite_manager combinedIssuingCapability 1
set_interface_property ace5lite_manager enableConcurrentSubordinateAccess 0
set_interface_property ace5lite_manager noRepeatedIdsBetweenSubordinates 0
set_interface_property ace5lite_manager issuesINCRBursts true
set_interface_property ace5lite_manager issuesWRAPBursts false
set_interface_property ace5lite_manager issuesFIXEDBursts false
set_interface_property ace5lite_manager atomicTransactions true
set_interface_property ace5lite_manager cacheStashTransactions true
set_interface_property ace5lite_manager ENABLED true
set_interface_property ace5lite_manager EXPORT_OF ""
set_interface_property ace5lite_manager PORT_NAME_MAP ""
set_interface_property ace5lite_manager CMSIS_SVD_VARIABLES ""
set_interface_property ace5lite_manager SVD_ADDRESS_GROUP ""
set_interface_property ace5lite_manager IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property ace5lite_manager SV_INTERFACE_TYPE ""
set_interface_property ace5lite_manager SV_INTERFACE_MODPORT_TYPE ""

add_interface_port ace5lite_manager m0_awid awid Output 5
add_interface_port ace5lite_manager m0_awaddr awaddr Output 32
add_interface_port ace5lite_manager m0_awdomain awdomain Output 2
add_interface_port ace5lite_manager m0_awsnoop awsnoop Output 4
add_interface_port ace5lite_manager m0_awlen awlen Output 8
add_interface_port ace5lite_manager m0_awsize awsize Output 3
add_interface_port ace5lite_manager m0_arsize arsize Output 3
add_interface_port ace5lite_manager m0_awburst awburst Output 2
add_interface_port ace5lite_manager m0_awlock awlock Output 1
add_interface_port ace5lite_manager m0_awcache awcache Output 4
add_interface_port ace5lite_manager m0_awprot awprot Output 3
add_interface_port ace5lite_manager m0_awqos awqos Output 4
add_interface_port ace5lite_manager m0_awvalid awvalid Output 1
add_interface_port ace5lite_manager m0_awready awready Input 1
add_interface_port ace5lite_manager m0_wdata wdata Output 256
add_interface_port ace5lite_manager m0_wstrb wstrb Output 32
add_interface_port ace5lite_manager m0_wlast wlast Output 1
add_interface_port ace5lite_manager m0_wvalid wvalid Output 1
add_interface_port ace5lite_manager m0_wready wready Input 1
add_interface_port ace5lite_manager m0_awstashnid awstashnid Output 11
add_interface_port ace5lite_manager m0_awstashniden awstashniden Output 1
add_interface_port ace5lite_manager m0_awstashlpid awstashlpid Output 5
add_interface_port ace5lite_manager m0_awstashlpiden awstashlpiden Output 1
add_interface_port ace5lite_manager m0_awatop awatop Output 6
add_interface_port ace5lite_manager m0_bid bid Input 5
add_interface_port ace5lite_manager m0_bresp bresp Input 2
add_interface_port ace5lite_manager m0_bvalid bvalid Input 1
add_interface_port ace5lite_manager m0_bready bready Output 1
add_interface_port ace5lite_manager m0_arid arid Output 5
add_interface_port ace5lite_manager m0_araddr araddr Output 32
add_interface_port ace5lite_manager m0_ardomain ardomain Output 2
add_interface_port ace5lite_manager m0_arsnoop arsnoop Output 4
add_interface_port ace5lite_manager m0_arlen arlen Output 8
add_interface_port ace5lite_manager m0_arburst arburst Output 2
add_interface_port ace5lite_manager m0_arlock arlock Output 1
add_interface_port ace5lite_manager m0_arcache arcache Output 4
add_interface_port ace5lite_manager m0_arprot arprot Output 3
add_interface_port ace5lite_manager m0_arqos arqos Output 4
add_interface_port ace5lite_manager m0_arvalid arvalid Output 1
add_interface_port ace5lite_manager m0_arready arready Input 1
add_interface_port ace5lite_manager m0_rid rid Input 5
add_interface_port ace5lite_manager m0_rdata rdata Input 256
add_interface_port ace5lite_manager m0_rresp rresp Input 2
add_interface_port ace5lite_manager m0_rlast rlast Input 1
add_interface_port ace5lite_manager m0_rvalid rvalid Input 1
add_interface_port ace5lite_manager m0_rready rready Output 1
add_interface_port ace5lite_manager m0_aruser aruser Output 8
add_interface_port ace5lite_manager m0_awuser awuser Output 8
add_interface_port ace5lite_manager m0_arregion arregion Output 4
add_interface_port ace5lite_manager m0_awregion awregion Output 4
add_interface_port ace5lite_manager m0_wuser wuser Output 8
add_interface_port ace5lite_manager m0_buser buser Input 8
add_interface_port ace5lite_manager m0_ruser ruser Input 8

proc generate_verilog { output_name } {
set verilog_code {
//
// SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
// SPDX-License-Identifier: MIT-0
//

`timescale 1 ps / 1 ps
module ${output_name} (
		// Clock and Reset
		input  wire         clk,
		input  wire         reset,

		// ACE5-lite manager
		output wire \[4:0\]   m0_awid,
		output wire \[31:0\]  m0_awaddr,
		output wire \[7:0\]   m0_awlen,
		output wire \[2:0\]   m0_awsize,
		output wire \[1:0\]   m0_awburst,
		output wire           m0_awlock,
		output wire \[3:0\]   m0_awcache,
		output wire \[2:0\]   m0_awprot,
		output wire           m0_awvalid,
		input  wire           m0_awready,
		output wire \[3:0\]   m0_awqos,
		output wire \[255:0\] m0_wdata,
		output wire \[31:0\]  m0_wstrb,
		output wire           m0_wlast,
		output wire           m0_wvalid,
		input  wire           m0_wready,
		output wire \[10:0\]  m0_awstashnid,
		output wire           m0_awstashniden,
		output wire \[4:0\]   m0_awstashlpid,
		output wire           m0_awstashlpiden,
		output wire \[5:0\]   m0_awatop,
		input  wire \[4:0\]   m0_bid,
		input  wire \[1:0\]   m0_bresp,
		input  wire           m0_bvalid,
		output wire           m0_bready,
		output wire \[4:0\]   m0_arid,
		output wire \[31:0\]  m0_araddr,
		output wire \[7:0\]   m0_arlen,
		output wire \[2:0\]   m0_arsize,
		output wire \[1:0\]   m0_arburst,
		output wire           m0_arlock,
		output wire \[3:0\]   m0_arcache,
		output wire \[2:0\]   m0_arprot,
		output wire           m0_arvalid,
		input  wire           m0_arready,
		output wire \[3:0\]   m0_arqos,
		input  wire \[4:0\]   m0_rid,
		input  wire \[255:0\] m0_rdata,
		input  wire \[1:0\]   m0_rresp,
		input  wire           m0_rlast,
		input  wire           m0_rvalid,
		output wire           m0_rready,
		output wire \[1:0\]   m0_awdomain,
		output wire \[1:0\]   m0_ardomain,
		output wire \[3:0\]   m0_arsnoop,
		output wire \[3:0\]   m0_awsnoop,
		output wire \[7:0\]   m0_aruser,
		output wire \[7:0\]   m0_awuser,
		input  wire \[7:0\]   m0_buser,
		input  wire \[7:0\]   m0_ruser,
		output wire \[7:0\]   m0_wuser,
		output wire \[3:0\]   m0_arregion,
		output wire \[3:0\]   m0_awregion
	);

assign m0_wuser = 8'h00;
assign m0_arregion = 4'h0;
assign m0_awregion = 4'h0;

assign m0_awdomain = 2'b01;
assign m0_awsnoop = 4'h0;
assign m0_awuser = 8'h04;

assign m0_ardomain = 2'b01;
assign m0_arsnoop = 4'h0;
assign m0_aruser = 8'h04;

assign m0_awburst = 2'b00;

assign m0_arlen = 8'h0;

assign m0_arqos = 4'h0;

assign m0_wstrb = 32'h0;

assign m0_rready = 1'b0;

assign m0_awlen = 8'h0;

assign m0_awqos = 4'h0;

assign m0_arcache = 4'hF;

assign m0_wvalid = 1'b0;

assign m0_araddr = 32'h0;

assign m0_arprot = 3'b001;

assign m0_awprot = 3'b001;

assign m0_wdata = m0_rdata;

assign m0_arvalid = 1'b0;

assign m0_awcache = 4'hF;

assign m0_arid = 5'h0;

assign m0_arlock = 1'b0;

assign m0_awlock = 1'b0;

assign m0_awaddr = 32'h0;

assign m0_arburst = 2'b00;

assign m0_arsize = 3'b000;

assign m0_bready = 1'b0;

assign m0_wlast = 1'b0;

assign m0_awid = 5'h0;

assign m0_awsize = 3'b000;

assign m0_awvalid = 1'b0;

assign m0_awstashnid = 11'h0;

assign m0_awstashniden = 1'b0;

assign m0_awstashlpid = 5'h0;

assign m0_awstashlpiden = 1'b0;

assign m0_awatop = 6'h0;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
