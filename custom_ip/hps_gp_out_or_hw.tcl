#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 23.4


#
# module hps_gp_out_or
#
set_module_property DESCRIPTION ""
set_module_property NAME hps_gp_out_or
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME hps_gp_out_or
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

add_interface_port hps_gp_out gp_in gp_exp Input 32


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

add_interface_port hps_gp_in gp_out gp_exp Output 32


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

add_interface_port mux_sel mux_sel mux_sel Output 1

proc generate_verilog { output_name } {
set verilog_code {
//
// SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
// SPDX-License-Identifier: MIT-0
//

`timescale 1 ps / 1 ps
module ${output_name} (
	// hps_gp_out conduit
	input  wire \[31:0\] gp_in,

	// hps_gp_in conduit
	output wire \[31:0\] gp_out,

	// mux_sel conduit
	output wire        mux_sel
);

assign gp_out = gp_in;

assign mux_sel = |gp_in;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
