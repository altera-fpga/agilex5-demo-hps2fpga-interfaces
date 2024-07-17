#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 23.4


#
# module hps_gp_out_mux_sel
#
set_module_property DESCRIPTION ""
set_module_property NAME hps_gp_out_mux_sel
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME hps_gp_out_mux_sel
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
# connection point reset_out
#
add_interface reset_out reset start
set_interface_property reset_out associatedClock ""
set_interface_property reset_out associatedDirectReset ""
set_interface_property reset_out associatedResetSinks ""
set_interface_property reset_out synchronousEdges NONE
set_interface_property reset_out ENABLED true
set_interface_property reset_out EXPORT_OF ""
set_interface_property reset_out PORT_NAME_MAP ""
set_interface_property reset_out CMSIS_SVD_VARIABLES ""
set_interface_property reset_out SVD_ADDRESS_GROUP ""
set_interface_property reset_out IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property reset_out SV_INTERFACE_TYPE ""
set_interface_property reset_out SV_INTERFACE_MODPORT_TYPE ""

add_interface_port reset_out reset_n reset_n Output 1


#
# connection point mux_sel_0
#
add_interface mux_sel_0 conduit end
set_interface_property mux_sel_0 associatedClock ""
set_interface_property mux_sel_0 associatedReset ""
set_interface_property mux_sel_0 ENABLED true
set_interface_property mux_sel_0 EXPORT_OF ""
set_interface_property mux_sel_0 PORT_NAME_MAP ""
set_interface_property mux_sel_0 CMSIS_SVD_VARIABLES ""
set_interface_property mux_sel_0 SVD_ADDRESS_GROUP ""
set_interface_property mux_sel_0 IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property mux_sel_0 SV_INTERFACE_TYPE ""
set_interface_property mux_sel_0 SV_INTERFACE_MODPORT_TYPE ""

add_interface_port mux_sel_0 mux_sel_0 mux_sel Output 1

#
# connection point mux_sel_1
#
add_interface mux_sel_1 conduit end
set_interface_property mux_sel_1 associatedClock ""
set_interface_property mux_sel_1 associatedReset ""
set_interface_property mux_sel_1 ENABLED true
set_interface_property mux_sel_1 EXPORT_OF ""
set_interface_property mux_sel_1 PORT_NAME_MAP ""
set_interface_property mux_sel_1 CMSIS_SVD_VARIABLES ""
set_interface_property mux_sel_1 SVD_ADDRESS_GROUP ""
set_interface_property mux_sel_1 IPXACT_REGISTER_MAP_VARIABLES ""
set_interface_property mux_sel_1 SV_INTERFACE_TYPE ""
set_interface_property mux_sel_1 SV_INTERFACE_MODPORT_TYPE ""

add_interface_port mux_sel_1 mux_sel_1 mux_sel Output 1

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

	// reset output interface
	output wire        reset_n,

	// mux_sel conduits
	output wire        mux_sel_0,
	output wire        mux_sel_1
);

assign reset_n = gp_in\[0\];
assign mux_sel_0 = gp_in\[1\];
assign mux_sel_1 = gp_in\[2\];

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
