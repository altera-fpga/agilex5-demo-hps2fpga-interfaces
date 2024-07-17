#
# SPDX-FileCopyrightText: Copyright (C) 2023-2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 22.2


#
# module conduit_xlate_i2c
#
set_module_property DESCRIPTION "Translate HPS I2C conduit to FPGA I2C conduit."
set_module_property NAME conduit_xlate_i2c
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME conduit_xlate_i2c
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property LOAD_ELABORATION_LIMIT 0


#
# file sets
#
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH generate_verilog

add_fileset SIM_VERILOG SIM_VERILOG generate_verilog

#
# parameters
#


#
# display items
#


#
# connection point hps_i2c0_scl_in
#
add_interface hps_i2c0_scl_in clock start
set_interface_property hps_i2c0_scl_in associatedDirectClock ""
set_interface_property hps_i2c0_scl_in ENABLED true
set_interface_property hps_i2c0_scl_in EXPORT_OF ""
set_interface_property hps_i2c0_scl_in PORT_NAME_MAP ""
set_interface_property hps_i2c0_scl_in CMSIS_SVD_VARIABLES ""
set_interface_property hps_i2c0_scl_in SVD_ADDRESS_GROUP ""
set_interface_property hps_i2c0_scl_in IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port hps_i2c0_scl_in i2c0_scl_i clk Output 1


#
# connection point hps_i2c0_clk
#
add_interface hps_i2c0_clk clock end
set_interface_property hps_i2c0_clk clockRate 125000000
set_interface_property hps_i2c0_clk ENABLED true
set_interface_property hps_i2c0_clk EXPORT_OF ""
set_interface_property hps_i2c0_clk PORT_NAME_MAP ""
set_interface_property hps_i2c0_clk CMSIS_SVD_VARIABLES ""
set_interface_property hps_i2c0_clk SVD_ADDRESS_GROUP ""
set_interface_property hps_i2c0_clk IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port hps_i2c0_clk i2c0_scl_oe clk Input 1


#
# connection point hps_i2c0
#
add_interface hps_i2c0 conduit end
set_interface_property hps_i2c0 associatedClock ""
set_interface_property hps_i2c0 associatedReset ""
set_interface_property hps_i2c0 ENABLED true
set_interface_property hps_i2c0 EXPORT_OF ""
set_interface_property hps_i2c0 PORT_NAME_MAP ""
set_interface_property hps_i2c0 CMSIS_SVD_VARIABLES ""
set_interface_property hps_i2c0 SVD_ADDRESS_GROUP ""
set_interface_property hps_i2c0 IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port hps_i2c0 i2c0_sda_i sda_i Output 1
add_interface_port hps_i2c0 i2c0_sda_oe sda_oe Input 1


#
# connection point i2cmaster_to_avmm_bridge_io
#
add_interface i2cmaster_to_avmm_bridge_io conduit end
set_interface_property i2cmaster_to_avmm_bridge_io associatedClock ""
set_interface_property i2cmaster_to_avmm_bridge_io associatedReset ""
set_interface_property i2cmaster_to_avmm_bridge_io ENABLED true
set_interface_property i2cmaster_to_avmm_bridge_io EXPORT_OF ""
set_interface_property i2cmaster_to_avmm_bridge_io PORT_NAME_MAP ""
set_interface_property i2cmaster_to_avmm_bridge_io CMSIS_SVD_VARIABLES ""
set_interface_property i2cmaster_to_avmm_bridge_io SVD_ADDRESS_GROUP ""
set_interface_property i2cmaster_to_avmm_bridge_io IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port i2cmaster_to_avmm_bridge_io i2cslave_to_avmm_bridge_io_conduit_data_out conduit_data_in Output 1
add_interface_port i2cmaster_to_avmm_bridge_io i2cslave_to_avmm_bridge_io_conduit_clk_out conduit_clk_in Output 1
add_interface_port i2cmaster_to_avmm_bridge_io i2cmaster_to_avmm_bridge_io_conduit_data_oe conduit_data_oe Input 1
add_interface_port i2cmaster_to_avmm_bridge_io i2cmaster_to_avmm_bridge_io_conduit_clk_oe conduit_clk_oe Input 1

proc generate_verilog { output_name } {
set verilog_code {
/*
 * Copyright (C) 2023 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1 ps / 1 ps
module ${output_name} (
		output wire  i2c0_scl_i,                                  //             hps_i2c0_scl_in.clk
		input  wire  i2c0_scl_oe,                                 //                hps_i2c0_clk.clk
		output wire  i2c0_sda_i,                                  //                    hps_i2c0.sda_i
		input  wire  i2c0_sda_oe,                                 //                            .sda_oe
		output wire  i2cslave_to_avmm_bridge_io_conduit_data_out, // i2cmaster_to_avmm_bridge_io.conduit_data_in
		output wire  i2cslave_to_avmm_bridge_io_conduit_clk_out,  //                            .conduit_clk_in
		input  wire  i2cmaster_to_avmm_bridge_io_conduit_data_oe, //                            .conduit_data_oe
		input  wire  i2cmaster_to_avmm_bridge_io_conduit_clk_oe   //                            .conduit_clk_oe
	);

wire clk_out;
wire data_out;

assign clk_out  = 1'b1 ^ (i2c0_scl_oe | i2cmaster_to_avmm_bridge_io_conduit_clk_oe);
assign data_out = 1'b1 ^ (i2c0_sda_oe | i2cmaster_to_avmm_bridge_io_conduit_data_oe);

assign i2c0_scl_i = clk_out;
assign i2cslave_to_avmm_bridge_io_conduit_clk_out = clk_out;

assign i2c0_sda_i = data_out;
assign i2cslave_to_avmm_bridge_io_conduit_data_out = data_out;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}

