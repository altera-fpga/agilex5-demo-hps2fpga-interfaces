#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
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
set_interface_property ace5lite_manager poison false
set_interface_property ace5lite_manager traceSignals false
set_interface_property ace5lite_manager dataCheck false
set_interface_property ace5lite_manager addressCheck false
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
set_interface_property ace5lite_manager untranslatedTransactions true
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

add_interface_port ace5lite_manager m0_awmmusecsid awmmusecsid Output 1
add_interface_port ace5lite_manager m0_awmmusid awmmusid Output 16

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

add_interface_port ace5lite_manager m0_armmusecsid armmusecsid Output 1
add_interface_port ace5lite_manager m0_armmusid armmusid Output 16

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

		output wire           m0_awmmusecsid,
		output wire \[15:0\]  m0_awmmusid,

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

		output wire           m0_armmusecsid,
		output wire \[15:0\]  m0_armmusid,

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

(* preserve, noprune *) reg           in_awready;
(* preserve, noprune *) reg           in_wready;
(* preserve, noprune *) reg \[4:0\]   in_bid;
(* preserve, noprune *) reg \[1:0\]   in_bresp;
(* preserve, noprune *) reg           in_bvalid;
(* preserve, noprune *) reg           in_arready;
(* preserve, noprune *) reg \[4:0\]   in_rid;
(* preserve, noprune *) reg \[255:0\] in_rdata;
(* preserve, noprune *) reg \[1:0\]   in_rresp;
(* preserve, noprune *) reg           in_rlast;
(* preserve, noprune *) reg           in_rvalid;
(* preserve, noprune *) reg \[7:0\]   in_buser;
(* preserve, noprune *) reg \[7:0\]   in_ruser;

(* preserve, noprune *) reg \[4:0\]   out_awid;
(* preserve, noprune *) reg \[31:0\]  out_awaddr;
(* preserve, noprune *) reg \[7:0\]   out_awlen;
(* preserve, noprune *) reg \[2:0\]   out_awsize;
(* preserve, noprune *) reg \[1:0\]   out_awburst;
(* preserve, noprune *) reg           out_awlock;
(* preserve, noprune *) reg           out_awmmusecsid;
(* preserve, noprune *) reg \[15:0\]  out_awmmusid;
(* preserve, noprune *) reg \[3:0\]   out_awcache;
(* preserve, noprune *) reg \[2:0\]   out_awprot;
(* preserve, noprune *) reg           out_awvalid;
(* preserve, noprune *) reg \[3:0\]   out_awqos;
(* preserve, noprune *) reg \[255:0\] out_wdata;
(* preserve, noprune *) reg \[31:0\]  out_wstrb;
(* preserve, noprune *) reg           out_wlast;
(* preserve, noprune *) reg           out_wvalid;
(* preserve, noprune *) reg \[10:0\]  out_awstashnid;
(* preserve, noprune *) reg           out_awstashniden;
(* preserve, noprune *) reg \[4:0\]   out_awstashlpid;
(* preserve, noprune *) reg           out_awstashlpiden;
(* preserve, noprune *) reg \[5:0\]   out_awatop;
(* preserve, noprune *) reg           out_bready;
(* preserve, noprune *) reg \[4:0\]   out_arid;
(* preserve, noprune *) reg \[31:0\]  out_araddr;
(* preserve, noprune *) reg \[7:0\]   out_arlen;
(* preserve, noprune *) reg \[2:0\]   out_arsize;
(* preserve, noprune *) reg \[1:0\]   out_arburst;
(* preserve, noprune *) reg           out_arlock;
(* preserve, noprune *) reg           out_armmusecsid;
(* preserve, noprune *) reg \[15:0\]  out_armmusid;
(* preserve, noprune *) reg \[3:0\]   out_arcache;
(* preserve, noprune *) reg \[2:0\]   out_arprot;
(* preserve, noprune *) reg           out_arvalid;
(* preserve, noprune *) reg \[3:0\]   out_arqos;
(* preserve, noprune *) reg           out_rready;
(* preserve, noprune *) reg \[1:0\]   out_awdomain;
(* preserve, noprune *) reg \[1:0\]   out_ardomain;
(* preserve, noprune *) reg \[3:0\]   out_arsnoop;
(* preserve, noprune *) reg \[3:0\]   out_awsnoop;
(* preserve, noprune *) reg \[7:0\]   out_aruser;
(* preserve, noprune *) reg \[7:0\]   out_awuser;
(* preserve, noprune *) reg \[7:0\]   out_wuser;
(* preserve, noprune *) reg \[3:0\]   out_arregion;
(* preserve, noprune *) reg \[3:0\]   out_awregion;

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		in_awready <= 1'b0;
		in_wready <= 1'b0;
		in_bid <= 4'h0;
		in_bresp <= 2'h0;
		in_bvalid <= 1'b0;
		in_arready <= 1'b0;
		in_rid <= 5'h0;
		in_rdata <= 256'h0;
		in_rresp <= 2'h0;
		in_rlast <= 1'b0;
		in_rvalid <= 1'b0;
		in_buser <= 8'h0;
		in_ruser <= 8'h0;
	end
	else begin
		in_awready <= m0_awready;
		in_wready <= m0_wready;
		in_bid <= m0_bid;
		in_bresp <= m0_bresp;
		in_bvalid <= m0_bvalid;
		in_arready <= m0_arready;
		in_rid <= m0_rid;
		in_rdata <= m0_rdata;
		in_rresp <= m0_rresp;
		in_rlast <= m0_rlast;
		in_rvalid <= m0_rvalid;
		in_buser <= m0_buser;
		in_ruser <= m0_ruser;
	end
end

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		out_awid <= 5'h0;
		out_awaddr <= 32'h0;
		out_awlen <= 8'h0;
		out_awsize <= 3'h0;
		out_awburst <= 2'h0;
		out_awlock <= 1'h0;
		out_awmmusecsid <= 1'h0;
		out_awmmusid <= 16'h0;
		out_awcache <= 4'h0;
		out_awprot <= 3'h0;
		out_awvalid <= 1'h0;
		out_awqos <= 4'h0;
		out_wdata <= 256'h0;
		out_wstrb <= 32'h0;
		out_wlast <= 1'h0;
		out_wvalid <= 1'h0;
		out_awstashnid <= 11'h0;
		out_awstashniden <= 1'h0;
		out_awstashlpid <= 5'h0;
		out_awstashlpiden <= 1'h0;
		out_awatop <= 6'h0;
		out_bready <= 1'h0;
		out_arid <= 5'h0;
		out_araddr <= 32'h0;
		out_arlen <= 8'h0;
		out_arsize <= 3'h0;
		out_arburst <= 2'h0;
		out_arlock <= 1'h0;
		out_armmusecsid <= 1'h0;
		out_armmusid <= 16'h0;
		out_arcache <= 4'h0;
		out_arprot <= 3'h0;
		out_arvalid <= 1'h0;
		out_arqos <= 4'h0;
		out_rready <= 1'h0;
		out_awdomain <= 2'h0;
		out_ardomain <= 2'h0;
		out_arsnoop <= 4'h0;
		out_awsnoop <= 4'h0;
		out_aruser <= 8'h0;
		out_awuser <= 8'h0;
		out_wuser <= 8'h0;
		out_arregion <= 4'h0;
		out_awregion <= 4'h0;
	end
	else begin
		out_awid <= 5'h0;
		out_awaddr <= 32'h0;
		out_awlen <= 8'h0;
		out_awsize <= 3'h0;
		out_awburst <= 2'h0;
		out_awlock <= 1'h0;
		out_awmmusecsid <= 1'h0;
		out_awmmusid <= 16'h0;
		out_awcache <= 4'h0;
		out_awprot <= 3'h0;
		out_awvalid <= 1'h0;
		out_awqos <= 4'h0;
		out_wdata <= in_rdata;
		out_wstrb <= 32'h0;
		out_wlast <= 1'h0;
		out_wvalid <= 1'h0;
		out_awstashnid <= 11'h0;
		out_awstashniden <= 1'h0;
		out_awstashlpid <= 5'h0;
		out_awstashlpiden <= 1'h0;
		out_awatop <= 6'h0;
		out_bready <= 1'h0;
		out_arid <= 5'h0;
		out_araddr <= 32'h0;
		out_arlen <= 8'h0;
		out_arsize <= 3'h0;
		out_arburst <= 2'h0;
		out_arlock <= 1'h0;
		out_armmusecsid <= 1'h0;
		out_armmusid <= 16'h0;
		out_arcache <= 4'h0;
		out_arprot <= 3'h0;
		out_arvalid <= 1'h0;
		out_arqos <= 4'h0;
		out_rready <= 1'h0;
		out_awdomain <= 2'h0;
		out_ardomain <= 2'h0;
		out_arsnoop <= 4'h0;
		out_awsnoop <= 4'h0;
		out_aruser <= 8'h0;
		out_awuser <= 8'h0;
		out_wuser <= 8'h0;
		out_arregion <= 4'h0;
		out_awregion <= 4'h0;
	end
end

assign m0_wuser = out_wuser;
assign m0_arregion = out_arregion;
assign m0_awregion = out_awregion;

assign m0_awdomain = out_awdomain;
assign m0_awsnoop = out_awsnoop;
assign m0_awuser = out_awuser;

assign m0_ardomain = out_ardomain;
assign m0_arsnoop = out_arsnoop;
assign m0_aruser = out_aruser;

assign m0_awburst = out_awburst;

assign m0_arlen = out_arlen;

assign m0_arqos = out_arqos;

assign m0_wstrb = out_wstrb;

assign m0_rready = out_rready;

assign m0_awlen = out_awlen;

assign m0_awqos = out_awqos;

assign m0_arcache = out_arcache;

assign m0_wvalid = out_wvalid;

assign m0_araddr = out_araddr;

assign m0_arprot = out_arprot;

assign m0_awprot = out_awprot;

assign m0_wdata = out_wdata;

assign m0_arvalid = out_arvalid;

assign m0_awcache = out_awcache;

assign m0_arid = out_arid;

assign m0_arlock = out_arlock;

assign m0_armmusecsid = out_armmusecsid;
assign m0_armmusid = out_armmusid;

assign m0_awlock = out_awlock;

assign m0_awmmusecsid = out_awmmusecsid;
assign m0_awmmusid = out_awmmusid;

assign m0_awaddr = out_awaddr;

assign m0_arburst = out_arburst;

assign m0_arsize = out_arsize;

assign m0_bready = out_bready;

assign m0_wlast = out_wlast;

assign m0_awid = out_awid;

assign m0_awsize = out_awsize;

assign m0_awvalid = out_awvalid;

assign m0_awstashnid = out_awstashnid;

assign m0_awstashniden = out_awstashniden;

assign m0_awstashlpid = out_awstashlpid;

assign m0_awstashlpiden = out_awstashlpiden;

assign m0_awatop = out_awatop;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
