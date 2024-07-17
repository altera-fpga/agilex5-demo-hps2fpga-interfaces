#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 23.4


#
# module hps_gp_in_mux
#
set_module_property DESCRIPTION ""
set_module_property NAME hps_gp_in_mux
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME hps_gp_in_mux
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
# connection point hps_gp_in_1
#
add_interface hps_gp_in_1 conduit end
set_interface_property hps_gp_in_1 associatedClock ""
set_interface_property hps_gp_in_1 associatedReset ""
set_interface_property hps_gp_in_1 ENABLED true
set_interface_property hps_gp_in_1 EXPORT_OF ""
set_interface_property hps_gp_in_1 PORT_NAME_MAP ""
set_interface_property hps_gp_in_1 CMSIS_SVD_VARIABLES ""
set_interface_property hps_gp_in_1 SVD_ADDRESS_GROUP ""
set_interface_property hps_gp_in_1 IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property hps_gp_in_1 SV_INTERFACE_TYPE ""
set_interface_property hps_gp_in_1 SV_INTERFACE_MODPORT_TYPE ""

add_interface_port hps_gp_in_1 gp_in_1 gp_exp Input 32


#
# connection point hps_gp_in_0
#
add_interface hps_gp_in_0 conduit end
set_interface_property hps_gp_in_0 associatedClock ""
set_interface_property hps_gp_in_0 associatedReset ""
set_interface_property hps_gp_in_0 ENABLED true
set_interface_property hps_gp_in_0 EXPORT_OF ""
set_interface_property hps_gp_in_0 PORT_NAME_MAP ""
set_interface_property hps_gp_in_0 CMSIS_SVD_VARIABLES ""
set_interface_property hps_gp_in_0 SVD_ADDRESS_GROUP ""
set_interface_property hps_gp_in_0 IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property hps_gp_in_0 SV_INTERFACE_TYPE ""
set_interface_property hps_gp_in_0 SV_INTERFACE_MODPORT_TYPE ""

add_interface_port hps_gp_in_0 gp_in_0 gp_exp Input 32


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


#
# connection point mux_sel
#
add_interface mux_sel conduit end
set_interface_property mux_sel associatedClock ""
set_interface_property mux_sel associatedReset ""
set_interface_property mux_sel ENABLED true
set_interface_property mux_sel EXPORT_OF ""
set_interface_property mux_sel PORT_NAME_MAP ""
set_interface_property mux_sel CMSIS_SVD_VARIABLES ""
set_interface_property mux_sel SVD_ADDRESS_GROUP ""
set_interface_property mux_sel IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property mux_sel SV_INTERFACE_TYPE ""
set_interface_property mux_sel SV_INTERFACE_MODPORT_TYPE ""

add_interface_port mux_sel mux_sel mux_sel Input 1

proc generate_verilog { output_name } {
set verilog_code {
//
// SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
// SPDX-License-Identifier: MIT-0
//

`timescale 1 ps / 1 ps
module ${output_name} (
	// hps_gp_in_1 conduit
	input  wire \[31:0\] gp_in_1,

	// hps_gp_in_0 conduit
	input  wire \[31:0\] gp_in_0,

	// hps_gp_in conduit
	output wire \[31:0\] gp_in,

	// mux_sel conduit
	input  wire        mux_sel
);

assign gp_in = mux_sel ? gp_in_1 : gp_in_0;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
