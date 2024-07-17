#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 23.4


#
# module hps_gp_in_constant
#
set_module_property DESCRIPTION ""
set_module_property NAME hps_gp_in_constant
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME hps_gp_in_constant
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
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
add_parameter GPIN_CONSTANT INTEGER 1414284868 ""
set_parameter_property GPIN_CONSTANT DEFAULT_VALUE 1414284868
set_parameter_property GPIN_CONSTANT DISPLAY_NAME GPIN_CONSTANT
set_parameter_property GPIN_CONSTANT WIDTH ""
set_parameter_property GPIN_CONSTANT UNITS None
set_parameter_property GPIN_CONSTANT ALLOWED_RANGES -2147483648:2147483647
set_parameter_property GPIN_CONSTANT DESCRIPTION "This value is driven out the gp_in port."
set_parameter_property GPIN_CONSTANT DISPLAY_HINT hexadecimal
set_parameter_property GPIN_CONSTANT AFFECTS_GENERATION false
set_parameter_property GPIN_CONSTANT HDL_PARAMETER true
set_parameter_property GPIN_CONSTANT EXPORT true


#
# display items
#


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

add_interface_port hps_gp_in gp_in gp_exp Output 32

proc generate_verilog { output_name } {
set verilog_code {
//
// SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
// SPDX-License-Identifier: MIT-0
//

`timescale 1 ps / 1 ps
module ${output_name} #(
	parameter GPIN_CONSTANT = 1414284868
) (
	output wire \[31:0\] gp_in
);

assign gp_in = GPIN_CONSTANT;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
