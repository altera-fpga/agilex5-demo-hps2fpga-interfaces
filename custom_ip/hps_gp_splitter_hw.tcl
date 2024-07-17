#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 23.4


#
# module hps_gp_splitter
#
set_module_property DESCRIPTION ""
set_module_property NAME hps_gp_splitter
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME hps_gp_splitter
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
# connection point hps_gp
#
add_interface hps_gp conduit end
set_interface_property hps_gp associatedClock ""
set_interface_property hps_gp associatedReset ""
set_interface_property hps_gp ENABLED true
set_interface_property hps_gp EXPORT_OF ""
set_interface_property hps_gp PORT_NAME_MAP ""
set_interface_property hps_gp CMSIS_SVD_VARIABLES ""
set_interface_property hps_gp SVD_ADDRESS_GROUP ""
set_interface_property hps_gp IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property hps_gp SV_INTERFACE_TYPE ""
set_interface_property hps_gp SV_INTERFACE_MODPORT_TYPE ""

add_interface_port hps_gp hps_gp_gp_in gp_in Output 32
add_interface_port hps_gp hps_gp_gp_out gp_out Input 32


#
# connection point hps_gp_in
#
add_interface hps_gp_in conduit end
set_interface_property hps_gp_in associatedClock ""
set_interface_property hps_gp_in associatedReset ""
set_interface_property hps_gp_in ENABLED true
set_interface_property hps_gp_in EXPORT_OF ""
set_interface_property hps_gp_in PORT_NAME_MAP ""
set_interface_property hps_gp_in CMSIS_SVD_VARIABLES ""
set_interface_property hps_gp_in SVD_ADDRESS_GROUP ""
set_interface_property hps_gp_in IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property hps_gp_in SV_INTERFACE_TYPE ""
set_interface_property hps_gp_in SV_INTERFACE_MODPORT_TYPE ""

add_interface_port hps_gp_in gp_in gp_exp Input 32


#
# connection point hps_gp_out
#
add_interface hps_gp_out conduit end
set_interface_property hps_gp_out associatedClock ""
set_interface_property hps_gp_out associatedReset ""
set_interface_property hps_gp_out ENABLED true
set_interface_property hps_gp_out EXPORT_OF ""
set_interface_property hps_gp_out PORT_NAME_MAP ""
set_interface_property hps_gp_out CMSIS_SVD_VARIABLES ""
set_interface_property hps_gp_out SVD_ADDRESS_GROUP ""
set_interface_property hps_gp_out IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property hps_gp_out SV_INTERFACE_TYPE ""
set_interface_property hps_gp_out SV_INTERFACE_MODPORT_TYPE ""

add_interface_port hps_gp_out gp_out gp_exp Output 32

proc generate_verilog { output_name } {
set verilog_code {
//
// SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
// SPDX-License-Identifier: MIT-0
//

`timescale 1 ps / 1 ps
module ${output_name} (
	// hps_gp conduit interface
	output wire \[31:0\] hps_gp_gp_in,
	input  wire \[31:0\] hps_gp_gp_out,

	// hps_gp_out conduit interface
	output wire \[31:0\] gp_out,

	// hps_gp_in conduit interface
	input  wire \[31:0\] gp_in
);

assign gp_out = hps_gp_gp_out;
assign hps_gp_gp_in = gp_in;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
