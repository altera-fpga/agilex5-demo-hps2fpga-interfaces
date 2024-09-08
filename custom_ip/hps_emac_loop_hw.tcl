#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 24.2


#
# module hps_emac_loop
#
set_module_property DESCRIPTION ""
set_module_property NAME hps_emac_loop
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property BSP_CPU false
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME hps_emac_loop
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
# connection point hps_emac_loop
#
add_interface hps_emac_loop conduit end
set_interface_property hps_emac_loop associatedClock ""
set_interface_property hps_emac_loop associatedReset ""
set_interface_property hps_emac_loop ENABLED true
set_interface_property hps_emac_loop EXPORT_OF ""
set_interface_property hps_emac_loop PORT_NAME_MAP ""
set_interface_property hps_emac_loop CMSIS_SVD_VARIABLES ""
set_interface_property hps_emac_loop SVD_ADDRESS_GROUP ""
set_interface_property hps_emac_loop IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property hps_emac_loop SV_INTERFACE_TYPE ""
set_interface_property hps_emac_loop SV_INTERFACE_MODPORT_TYPE ""

add_interface_port hps_emac_loop emac_mac_tx_clk_o mac_tx_clk_o Input 1
add_interface_port hps_emac_loop emac_mac_tx_clk_i mac_tx_clk_i Output 1
add_interface_port hps_emac_loop emac_mac_rx_clk mac_rx_clk Output 1
add_interface_port hps_emac_loop emac_mac_rst_tx_n mac_rst_tx_n Input 1
add_interface_port hps_emac_loop emac_mac_rst_rx_n mac_rst_rx_n Input 1
add_interface_port hps_emac_loop emac_mac_txen mac_txen Input 1
add_interface_port hps_emac_loop emac_mac_txer mac_txer Input 1
add_interface_port hps_emac_loop emac_mac_rxdv mac_rxdv Output 1
add_interface_port hps_emac_loop emac_mac_rxer mac_rxer Output 1
add_interface_port hps_emac_loop emac_mac_rxd mac_rxd Output 8
add_interface_port hps_emac_loop emac_mac_col mac_col Output 1
add_interface_port hps_emac_loop emac_mac_crs mac_crs Output 1
add_interface_port hps_emac_loop emac_mac_speed mac_speed Input 3
add_interface_port hps_emac_loop emac_mac_txd_o mac_txd_o Input 8

proc generate_verilog { output_name } {
set verilog_code {
//
// SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
// SPDX-License-Identifier: MIT-0
//

`timescale 1 ps / 1 ps
module ${output_name} (
		input  wire       emac_mac_tx_clk_o,
		output wire       emac_mac_tx_clk_i,
		output wire       emac_mac_rx_clk,
		input  wire       emac_mac_rst_tx_n,
		input  wire       emac_mac_rst_rx_n,
		input  wire       emac_mac_txen,
		input  wire       emac_mac_txer,
		output wire       emac_mac_rxdv,
		output wire       emac_mac_rxer,
		output wire \[7:0\] emac_mac_rxd,
		output wire       emac_mac_col,
		output wire       emac_mac_crs,
		input  wire \[2:0\] emac_mac_speed,
		input  wire \[7:0\] emac_mac_txd_o
	);

assign emac_mac_rxd = emac_mac_txd_o;
assign emac_mac_tx_clk_i = 1'b0;
assign emac_mac_rxdv = emac_mac_txen;
assign emac_mac_crs = 1'b1;
assign emac_mac_col = 1'b0;
assign emac_mac_rx_clk = emac_mac_tx_clk_o;
assign emac_mac_rxer = emac_mac_txer;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
