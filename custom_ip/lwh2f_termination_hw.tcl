#
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 25.3


#
# module lwh2f_termination
#
set_module_property DESCRIPTION ""
set_module_property NAME lwh2f_termination
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property BSP_CPU false
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME lwh2f_termination
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property LOAD_ELABORATION_LIMIT 0
set_module_property PRE_COMP_MODULE_ENABLED false
set_module_property DISPLAY_ICON ""


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
set_interface_property reset associatedClock ""
set_interface_property reset synchronousEdges NONE
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
# connection point s0
#
add_interface s0 axi4 end
set_interface_property s0 associatedClock clock
set_interface_property s0 associatedReset reset
set_interface_property s0 optionalAssociatedReset false
set_interface_property s0 wakeupSignals false
set_interface_property s0 poison false
set_interface_property s0 dataCheck false
set_interface_property s0 addressCheck false
set_interface_property s0 securityAttribute false
set_interface_property s0 userData false
set_interface_property s0 readAcceptanceCapability 8
set_interface_property s0 writeAcceptanceCapability 8
set_interface_property s0 combinedAcceptanceCapability 16
set_interface_property s0 readDataReorderingDepth 1
set_interface_property s0 bridgesToMaster ""
set_interface_property s0 dfhFeatureGuid 0
set_interface_property s0 dfhGroupId 0
set_interface_property s0 dfhParameterId ""
set_interface_property s0 dfhParameterName ""
set_interface_property s0 dfhParameterVersion ""
set_interface_property s0 dfhParameterData ""
set_interface_property s0 dfhParameterDataLength ""
set_interface_property s0 dfhFeatureMajorVersion 0
set_interface_property s0 dfhFeatureMinorVersion 0
set_interface_property s0 dfhFeatureId 35
set_interface_property s0 dfhFeatureType 3
set_interface_property s0 ENABLED true
set_interface_property s0 EXPORT_OF ""
set_interface_property s0 PORT_NAME_MAP ""
set_interface_property s0 CMSIS_SVD_VARIABLES ""
set_interface_property s0 SVD_ADDRESS_GROUP ""
set_interface_property s0 IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property s0 SV_INTERFACE_TYPE ""
set_interface_property s0 SV_INTERFACE_MODPORT_TYPE ""

add_interface_port s0 s0_awid awid Input 4
add_interface_port s0 s0_awaddr awaddr Input 29
add_interface_port s0 s0_awlen awlen Input 8
add_interface_port s0 s0_awsize awsize Input 3
add_interface_port s0 s0_awburst awburst Input 2
add_interface_port s0 s0_awlock awlock Input 1
add_interface_port s0 s0_awcache awcache Input 4
add_interface_port s0 s0_awprot awprot Input 3
add_interface_port s0 s0_awvalid awvalid Input 1
add_interface_port s0 s0_awready awready Output 1
add_interface_port s0 s0_wdata wdata Input 32
add_interface_port s0 s0_wstrb wstrb Input 4
add_interface_port s0 s0_wlast wlast Input 1
add_interface_port s0 s0_wvalid wvalid Input 1
add_interface_port s0 s0_wready wready Output 1
add_interface_port s0 s0_bid bid Output 4
add_interface_port s0 s0_bresp bresp Output 2
add_interface_port s0 s0_bvalid bvalid Output 1
add_interface_port s0 s0_bready bready Input 1
add_interface_port s0 s0_arid arid Input 4
add_interface_port s0 s0_araddr araddr Input 29
add_interface_port s0 s0_arlen arlen Input 8
add_interface_port s0 s0_arsize arsize Input 3
add_interface_port s0 s0_arburst arburst Input 2
add_interface_port s0 s0_arlock arlock Input 1
add_interface_port s0 s0_arcache arcache Input 4
add_interface_port s0 s0_arprot arprot Input 3
add_interface_port s0 s0_arvalid arvalid Input 1
add_interface_port s0 s0_arready arready Output 1
add_interface_port s0 s0_rid rid Output 4
add_interface_port s0 s0_rdata rdata Output 32
add_interface_port s0 s0_rresp rresp Output 2
add_interface_port s0 s0_rlast rlast Output 1
add_interface_port s0 s0_rvalid rvalid Output 1
add_interface_port s0 s0_rready rready Input 1

proc generate_verilog { output_name } {
set verilog_code {
//
// SPDX-FileCopyrightText: Copyright (C) 2025 Intel Corporation
// SPDX-License-Identifier: MIT-0
//

`timescale 1 ps / 1 ps
module ${output_name} (
		// Clock and Reset
		input  wire         clk,
		input  wire         reset,

		// AXI4 subordinate
		input  wire \[3:0\]   s0_awid,
		input  wire \[28:0\]  s0_awaddr,
		input  wire \[7:0\]   s0_awlen,
		input  wire \[2:0\]   s0_awsize,
		input  wire \[1:0\]   s0_awburst,
		input  wire \[0:0\]   s0_awlock,
		input  wire \[3:0\]   s0_awcache,
		input  wire \[2:0\]   s0_awprot,
		input  wire           s0_awvalid,
		output wire           s0_awready,
		input  wire \[31:0\]  s0_wdata,
		input  wire \[3:0\]   s0_wstrb,
		input  wire           s0_wlast,
		input  wire           s0_wvalid,
		output wire           s0_wready,
		output wire \[3:0\]   s0_bid,
		output wire \[1:0\]   s0_bresp,
		output wire           s0_bvalid,
		input  wire           s0_bready,
		input  wire \[3:0\]   s0_arid,
		input  wire \[28:0\]  s0_araddr,
		input  wire \[7:0\]   s0_arlen,
		input  wire \[2:0\]   s0_arsize,
		input  wire \[1:0\]   s0_arburst,
		input  wire \[0:0\]   s0_arlock,
		input  wire \[3:0\]   s0_arcache,
		input  wire \[2:0\]   s0_arprot,
		input  wire           s0_arvalid,
		output wire           s0_arready,
		output wire \[3:0\]   s0_rid,
		output wire \[31:0\]  s0_rdata,
		output wire \[1:0\]   s0_rresp,
		output wire           s0_rlast,
		output wire           s0_rvalid,
		input  wire           s0_rready
	);

/*
(* preserve, noprune *) reg \[31:0\] rotate;

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		rotate <= 32'h1;
	end
	else begin
		rotate <= {rotate\[30:0\],rotate\[31\]};
	end
end
*/

(* preserve, noprune *) reg \[3:0\]   in_awid;
(* preserve, noprune *) reg \[28:0\]  in_awaddr;
(* preserve, noprune *) reg \[7:0\]   in_awlen;
(* preserve, noprune *) reg \[2:0\]   in_awsize;
(* preserve, noprune *) reg \[1:0\]   in_awburst;
(* preserve, noprune *) reg \[0:0\]   in_awlock;
(* preserve, noprune *) reg \[3:0\]   in_awcache;
(* preserve, noprune *) reg \[2:0\]   in_awprot;
(* preserve, noprune *) reg           in_awvalid;
(* preserve, noprune *) reg \[31:0\]  in_wdata;
(* preserve, noprune *) reg \[3:0\]   in_wstrb;
(* preserve, noprune *) reg           in_wlast;
(* preserve, noprune *) reg           in_wvalid;
(* preserve, noprune *) reg           in_bready;
(* preserve, noprune *) reg \[3:0\]   in_arid;
(* preserve, noprune *) reg \[28:0\]  in_araddr;
(* preserve, noprune *) reg \[7:0\]   in_arlen;
(* preserve, noprune *) reg \[2:0\]   in_arsize;
(* preserve, noprune *) reg \[1:0\]   in_arburst;
(* preserve, noprune *) reg \[0:0\]   in_arlock;
(* preserve, noprune *) reg \[3:0\]   in_arcache;
(* preserve, noprune *) reg \[2:0\]   in_arprot;
(* preserve, noprune *) reg           in_arvalid;
(* preserve, noprune *) reg           in_rready;

(* preserve, noprune *) reg           out_awready;
(* preserve, noprune *) reg           out_wready;
(* preserve, noprune *) reg \[3:0\]   out_bid;
(* preserve, noprune *) reg \[1:0\]   out_bresp;
(* preserve, noprune *) reg           out_bvalid;
(* preserve, noprune *) reg           out_arready;
(* preserve, noprune *) reg \[3:0\]   out_rid;
(* preserve, noprune *) reg \[31:0\]  out_rdata;
(* preserve, noprune *) reg \[1:0\]   out_rresp;
(* preserve, noprune *) reg           out_rlast;
(* preserve, noprune *) reg           out_rvalid;

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		in_awid <= 4'h0;
		in_awaddr <= 29'h0;
		in_awlen <= 8'h0;
		in_awsize <= 3'h0;
		in_awburst <= 2'h0;
		in_awlock <= 1'h0;
		in_awcache <= 4'h0;
		in_awprot <= 3'h0;
		in_awvalid <= 1'h0;
		in_wdata <= 32'h0;
		in_wstrb <= 4'h0;
		in_wlast <= 1'h0;
		in_wvalid <= 1'h0;
		in_bready <= 1'h0;
		in_arid <= 4'h0;
		in_araddr <= 29'h0;
		in_arlen <= 8'h0;
		in_arsize <= 3'h0;
		in_arburst <= 2'h0;
		in_arlock <= 1'h0;
		in_arcache <= 4'h0;
		in_arprot <= 3'h0;
		in_arvalid <= 1'h0;
		in_rready <= 1'h0;
	end else begin
		in_awid <= s0_awid;
		in_awaddr <= s0_awaddr;
		in_awlen <= s0_awlen;
		in_awsize <= s0_awsize;
		in_awburst <= s0_awburst;
		in_awlock <= s0_awlock;
		in_awcache <= s0_awcache;
		in_awprot <= s0_awprot;
		in_awvalid <= s0_awvalid;
		in_wdata <= s0_wdata;
		in_wstrb <= s0_wstrb;
		in_wlast <= s0_wlast;
		in_wvalid <= s0_wvalid;
		in_bready <= s0_bready;
		in_arid <= s0_arid;
		in_araddr <= s0_araddr;
		in_arlen <= s0_arlen;
		in_arsize <= s0_arsize;
		in_arburst <= s0_arburst;
		in_arlock <= s0_arlock;
		in_arcache <= s0_arcache;
		in_arprot <= s0_arprot;
		in_arvalid <= s0_arvalid;
		in_rready <= s0_rready;
	end
end

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		out_awready <= 1'h0;
		out_wready <= 1'h0;
		out_bid <= 4'h0;
		out_bresp <= 2'h0;
		out_bvalid <= 1'h0;
		out_arready <= 1'h0;
		out_rid <= 4'h0;
		out_rdata <= 32'h0;
		out_rresp <= 2'h0;
		out_rlast <= 1'h0;
		out_rvalid <= 1'h0;
	end else begin
		out_awready <= 1'h0;
		out_wready <= 1'h0;
		out_bid <= in_awid;
		out_bresp <= 2'h0;
		out_bvalid <= 1'h0;
		out_arready <= 1'h0;
		out_rid <= in_arid;
		out_rdata <= in_wdata;
		out_rresp <= 2'h0;
		out_rlast <= 1'h0;
		out_rvalid <= 1'h0;
	end
end

assign s0_awready = out_awready;
assign s0_wready = out_wready;
assign s0_bid = out_bid;
assign s0_bresp = out_bresp;
assign s0_bvalid = out_bvalid;
assign s0_arready = out_arready;
assign s0_rid = out_rid;
assign s0_rdata = out_rdata;
assign s0_rresp = out_rresp;
assign s0_rlast = out_rlast;
assign s0_rvalid = out_rvalid;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
