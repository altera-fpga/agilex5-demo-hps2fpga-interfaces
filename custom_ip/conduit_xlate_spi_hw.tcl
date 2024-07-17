#
# SPDX-FileCopyrightText: Copyright (C) 2023-2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 22.2


#
# module conduit_xlate_spi
#
set_module_property DESCRIPTION "Translate HPS SPI conduit to FPGA SPI conduit."
set_module_property NAME conduit_xlate_spi
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME conduit_xlate_spi
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
# connection point hps_spim0_sclk_out
#
add_interface hps_spim0_sclk_out clock end
set_interface_property hps_spim0_sclk_out clockRate 125000000
set_interface_property hps_spim0_sclk_out ENABLED true
set_interface_property hps_spim0_sclk_out EXPORT_OF ""
set_interface_property hps_spim0_sclk_out PORT_NAME_MAP ""
set_interface_property hps_spim0_sclk_out CMSIS_SVD_VARIABLES ""
set_interface_property hps_spim0_sclk_out SVD_ADDRESS_GROUP ""
set_interface_property hps_spim0_sclk_out IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port hps_spim0_sclk_out spim0_sclk_in clk Input 1


#
# connection point hps_spim0
#
add_interface hps_spim0 conduit end
set_interface_property hps_spim0 associatedClock ""
set_interface_property hps_spim0 associatedReset ""
set_interface_property hps_spim0 ENABLED true
set_interface_property hps_spim0 EXPORT_OF ""
set_interface_property hps_spim0 PORT_NAME_MAP ""
set_interface_property hps_spim0 CMSIS_SVD_VARIABLES ""
set_interface_property hps_spim0 SVD_ADDRESS_GROUP ""
set_interface_property hps_spim0 IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port hps_spim0 spim0_mosi_o mosi_o Input 1
add_interface_port hps_spim0 spim0_miso_i miso_i Output 1
add_interface_port hps_spim0 spim0_ss_out_n ss_in_n Output 1
add_interface_port hps_spim0 spim0_mosi_oe mosi_oe Input 1
add_interface_port hps_spim0 spim0_ss0_n_o ss0_n_o Input 1
add_interface_port hps_spim0 spim0_ss1_n_o ss1_n_o Input 1
add_interface_port hps_spim0 spim0_ss2_n_o ss2_n_o Input 1
add_interface_port hps_spim0 spim0_ss3_n_o ss3_n_o Input 1


#
# connection point spi_slave_to_avmm_bridge_io
#
add_interface spi_slave_to_avmm_bridge_io conduit end
set_interface_property spi_slave_to_avmm_bridge_io associatedClock ""
set_interface_property spi_slave_to_avmm_bridge_io associatedReset ""
set_interface_property spi_slave_to_avmm_bridge_io ENABLED true
set_interface_property spi_slave_to_avmm_bridge_io EXPORT_OF ""
set_interface_property spi_slave_to_avmm_bridge_io PORT_NAME_MAP ""
set_interface_property spi_slave_to_avmm_bridge_io CMSIS_SVD_VARIABLES ""
set_interface_property spi_slave_to_avmm_bridge_io SVD_ADDRESS_GROUP ""
set_interface_property spi_slave_to_avmm_bridge_io IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port spi_slave_to_avmm_bridge_io spi_slave_to_avmm_bridge_io_mosi_to_the_spislave_outst_for_spichain mosi_to_the_spislave_inst_for_spichain Output 1
add_interface_port spi_slave_to_avmm_bridge_io spi_slave_to_avmm_bridge_io_nss_to_the_spislave_outst_for_spichain nss_to_the_spislave_inst_for_spichain Output 1
add_interface_port spi_slave_to_avmm_bridge_io spi_slave_to_avmm_bridge_io_sclk_to_the_spislave_outst_for_spichain sclk_to_the_spislave_inst_for_spichain Output 1
add_interface_port spi_slave_to_avmm_bridge_io spi_slave_to_avmm_bridge_io_miso_to_and_from_the_spislave_outst_for_spichain miso_to_and_from_the_spislave_inst_for_spichain Bidir 1

proc generate_verilog { output_name } {
set verilog_code {
/*
 * Copyright (C) 2023 Intel Corporation
 *
 * SPDX-License-Identifier: MIT-0
 */

`timescale 1 ps / 1 ps
module ${output_name} (
		input  wire  spim0_sclk_in,                                                                //          hps_spim0_sclk_out.clk
		input  wire  spim0_mosi_o,                                                                 //                   hps_spim0.mosi_o
		output wire  spim0_miso_i,                                                                 //                            .miso_i
		output wire  spim0_ss_out_n,                                                               //                            .ss_in_n
		input  wire  spim0_mosi_oe,                                                                //                            .mosi_oe
		input  wire  spim0_ss0_n_o,                                                                //                            .ss0_n_o
		input  wire  spim0_ss1_n_o,                                                                //                            .ss1_n_o
		input  wire  spim0_ss2_n_o,                                                                //                            .ss2_n_o
		input  wire  spim0_ss3_n_o,                                                                //                            .ss3_n_o
		output wire  spi_slave_to_avmm_bridge_io_mosi_to_the_spislave_outst_for_spichain,          // spi_slave_to_avmm_bridge_io.mosi_to_the_spislave_inst_for_spichain
		output wire  spi_slave_to_avmm_bridge_io_nss_to_the_spislave_outst_for_spichain,           //                            .nss_to_the_spislave_inst_for_spichain
		output wire  spi_slave_to_avmm_bridge_io_sclk_to_the_spislave_outst_for_spichain,          //                            .sclk_to_the_spislave_inst_for_spichain
		inout  wire  spi_slave_to_avmm_bridge_io_miso_to_and_from_the_spislave_outst_for_spichain  //                            .miso_to_and_from_the_spislave_inst_for_spichain
	);

assign spi_slave_to_avmm_bridge_io_miso_to_and_from_the_spislave_outst_for_spichain = 1'bz;

assign spim0_miso_i = spi_slave_to_avmm_bridge_io_miso_to_and_from_the_spislave_outst_for_spichain;

assign spim0_ss_out_n = 1'b1;

assign spi_slave_to_avmm_bridge_io_nss_to_the_spislave_outst_for_spichain = spim0_ss0_n_o;

assign spi_slave_to_avmm_bridge_io_sclk_to_the_spislave_outst_for_spichain = spim0_sclk_in;

assign spi_slave_to_avmm_bridge_io_mosi_to_the_spislave_outst_for_spichain = spim0_mosi_o;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}

