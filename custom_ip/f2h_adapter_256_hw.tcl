#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 24.3


#
# module f2h_adapter_256
#
set_module_property DESCRIPTION ""
set_module_property NAME f2h_adapter_256
set_module_property VERSION 1.1
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME f2h_adapter_256
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
# connection point axi4_subordinate
#
add_interface axi4_subordinate axi4 end
set_interface_property axi4_subordinate associatedClock clock
set_interface_property axi4_subordinate associatedReset reset
set_interface_property axi4_subordinate readAcceptanceCapability 8
set_interface_property axi4_subordinate writeAcceptanceCapability 8
set_interface_property axi4_subordinate combinedAcceptanceCapability 16
set_interface_property axi4_subordinate readDataReorderingDepth 8
set_interface_property axi4_subordinate bridgesToMaster ""
set_interface_property axi4_subordinate ENABLED true
set_interface_property axi4_subordinate EXPORT_OF ""
set_interface_property axi4_subordinate PORT_NAME_MAP ""
set_interface_property axi4_subordinate CMSIS_SVD_VARIABLES ""
set_interface_property axi4_subordinate SVD_ADDRESS_GROUP ""
set_interface_property axi4_subordinate IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property axi4_subordinate SV_INTERFACE_TYPE ""
set_interface_property axi4_subordinate SV_INTERFACE_MODPORT_TYPE ""

add_interface_port axi4_subordinate s0_awid awid Input 5
add_interface_port axi4_subordinate s0_awaddr awaddr Input 32
add_interface_port axi4_subordinate s0_awlen awlen Input 8
add_interface_port axi4_subordinate s0_awsize awsize Input 3
add_interface_port axi4_subordinate s0_awburst awburst Input 2
add_interface_port axi4_subordinate s0_awlock awlock Input 1
set_port_property s0_awlock VHDL_TYPE STD_LOGIC_VECTOR
add_interface_port axi4_subordinate s0_awcache awcache Input 4
add_interface_port axi4_subordinate s0_awprot awprot Input 3
add_interface_port axi4_subordinate s0_awuser awuser Input 8
add_interface_port axi4_subordinate s0_awqos awqos Input 4
add_interface_port axi4_subordinate s0_awvalid awvalid Input 1
add_interface_port axi4_subordinate s0_awready awready Output 1
add_interface_port axi4_subordinate s0_wdata wdata Input 256
add_interface_port axi4_subordinate s0_wstrb wstrb Input 32
add_interface_port axi4_subordinate s0_wlast wlast Input 1
add_interface_port axi4_subordinate s0_wvalid wvalid Input 1
add_interface_port axi4_subordinate s0_wready wready Output 1
add_interface_port axi4_subordinate s0_bid bid Output 5
add_interface_port axi4_subordinate s0_bresp bresp Output 2
add_interface_port axi4_subordinate s0_bvalid bvalid Output 1
add_interface_port axi4_subordinate s0_bready bready Input 1
add_interface_port axi4_subordinate s0_arid arid Input 5
add_interface_port axi4_subordinate s0_araddr araddr Input 32
add_interface_port axi4_subordinate s0_arlen arlen Input 8
add_interface_port axi4_subordinate s0_arsize arsize Input 3
add_interface_port axi4_subordinate s0_arburst arburst Input 2
add_interface_port axi4_subordinate s0_arlock arlock Input 1
set_port_property s0_arlock VHDL_TYPE STD_LOGIC_VECTOR
add_interface_port axi4_subordinate s0_arcache arcache Input 4
add_interface_port axi4_subordinate s0_arprot arprot Input 3
add_interface_port axi4_subordinate s0_aruser aruser Input 8
add_interface_port axi4_subordinate s0_arqos arqos Input 4
add_interface_port axi4_subordinate s0_arvalid arvalid Input 1
add_interface_port axi4_subordinate s0_arready arready Output 1
add_interface_port axi4_subordinate s0_rid rid Output 5
add_interface_port axi4_subordinate s0_rdata rdata Output 256
add_interface_port axi4_subordinate s0_rresp rresp Output 2
add_interface_port axi4_subordinate s0_rlast rlast Output 1
add_interface_port axi4_subordinate s0_rvalid rvalid Output 1
add_interface_port axi4_subordinate s0_rready rready Input 1


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
		output wire \[3:0\]   m0_awregion,

		// AXI4 subordinate
		input  wire \[4:0\]   s0_awid,
		input  wire \[31:0\]  s0_awaddr,
		input  wire \[7:0\]   s0_awlen,
		input  wire \[2:0\]   s0_awsize,
		input  wire \[1:0\]   s0_awburst,
		input  wire \[0:0\]   s0_awlock,
		input  wire \[3:0\]   s0_awcache,
		input  wire \[2:0\]   s0_awprot,
		input  wire \[7:0\]   s0_awuser,
		input  wire \[3:0\]   s0_awqos,
		input  wire           s0_awvalid,
		output wire           s0_awready,
		input  wire \[255:0\] s0_wdata,
		input  wire \[31:0\]  s0_wstrb,
		input  wire           s0_wlast,
		input  wire           s0_wvalid,
		output wire           s0_wready,
		output wire \[4:0\]   s0_bid,
		output wire \[1:0\]   s0_bresp,
		output wire           s0_bvalid,
		input  wire           s0_bready,
		input  wire \[4:0\]   s0_arid,
		input  wire \[31:0\]  s0_araddr,
		input  wire \[7:0\]   s0_arlen,
		input  wire \[2:0\]   s0_arsize,
		input  wire \[1:0\]   s0_arburst,
		input  wire \[0:0\]   s0_arlock,
		input  wire \[3:0\]   s0_arcache,
		input  wire \[2:0\]   s0_arprot,
		input  wire \[7:0\]   s0_aruser,
		input  wire \[3:0\]   s0_arqos,
		input  wire           s0_arvalid,
		output wire           s0_arready,
		output wire \[4:0\]   s0_rid,
		output wire \[255:0\] s0_rdata,
		output wire \[1:0\]   s0_rresp,
		output wire           s0_rlast,
		output wire           s0_rvalid,
		input  wire           s0_rready
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

assign m0_awburst = s0_awburst;

assign m0_arlen = s0_arlen;

assign m0_arqos = 4'h0;

assign m0_wstrb = s0_wstrb;

assign m0_rready = s0_rready;

assign m0_awlen = s0_awlen;

assign m0_awqos = 4'h0;

assign m0_arcache = 4'hF;

assign m0_wvalid = s0_wvalid;

assign m0_araddr = s0_araddr;

assign m0_arprot = 3'b011;

assign m0_awprot = 3'b011;

assign m0_wdata = s0_wdata;

assign m0_arvalid = s0_arvalid;

assign m0_awcache = 4'hF;

assign m0_arid = s0_arid;

assign m0_arlock = 1'b0;

assign m0_awlock = 1'b0;

assign m0_awaddr = s0_awaddr;

assign m0_arburst = s0_arburst;

assign m0_arsize = s0_arsize;

assign m0_bready = s0_bready;

assign m0_wlast = s0_wlast;

assign m0_awid = s0_awid;

assign m0_awsize = s0_awsize;

assign m0_awvalid = s0_awvalid;

assign s0_wready = m0_wready;

assign s0_rid = m0_rid;

assign s0_bresp = m0_bresp;

assign s0_arready = m0_arready;

assign s0_rdata = m0_rdata;

assign s0_awready = m0_awready;

assign s0_rlast = m0_rlast;

assign s0_rresp = m0_rresp;

assign s0_bid = m0_bid;

assign s0_bvalid = m0_bvalid;

assign s0_rvalid = m0_rvalid;

assign m0_awstashnid = 11'h0;

assign m0_awstashniden = 1'b0;

assign m0_awstashlpid = 5'h0;

assign m0_awstashlpiden = 1'b0;

assign m0_awatop = 6'h0;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
