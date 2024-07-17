#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 23.4


#
# module hps_gp_out_irq
#
set_module_property DESCRIPTION ""
set_module_property NAME hps_gp_out_irq
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME hps_gp_out_irq
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
# connection point f2h_irq
#
for {set x 0} {${x} < 64} {incr x} {
	add_interface f2h_irq_${x} interrupt end
	set_interface_property f2h_irq_${x} bridgedReceiverOffset ""
	set_interface_property f2h_irq_${x} bridgesToReceiver ""
	set_interface_property f2h_irq_${x} ENABLED true
	set_interface_property f2h_irq_${x} EXPORT_OF ""
	set_interface_property f2h_irq_${x} PORT_NAME_MAP ""
	set_interface_property f2h_irq_${x} CMSIS_SVD_VARIABLES ""
	set_interface_property f2h_irq_${x} SVD_ADDRESS_GROUP ""
	set_interface_property f2h_irq_${x} IPXACT_REGISTER_MAP_VARIABLES ""
	set_interface_property f2h_irq_${x} SV_INTERFACE_TYPE ""
	set_interface_property f2h_irq_${x} SV_INTERFACE_MODPORT_TYPE ""

	add_interface_port f2h_irq_${x} irq_${x} irq Output 1
}

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

	// f2h_irq irq interfaces
	output wire        irq_0,
	output wire        irq_1,
	output wire        irq_2,
	output wire        irq_3,
	output wire        irq_4,
	output wire        irq_5,
	output wire        irq_6,
	output wire        irq_7,
	output wire        irq_8,
	output wire        irq_9,
	output wire        irq_10,
	output wire        irq_11,
	output wire        irq_12,
	output wire        irq_13,
	output wire        irq_14,
	output wire        irq_15,
	output wire        irq_16,
	output wire        irq_17,
	output wire        irq_18,
	output wire        irq_19,
	output wire        irq_20,
	output wire        irq_21,
	output wire        irq_22,
	output wire        irq_23,
	output wire        irq_24,
	output wire        irq_25,
	output wire        irq_26,
	output wire        irq_27,
	output wire        irq_28,
	output wire        irq_29,
	output wire        irq_30,
	output wire        irq_31,
	output wire        irq_32,
	output wire        irq_33,
	output wire        irq_34,
	output wire        irq_35,
	output wire        irq_36,
	output wire        irq_37,
	output wire        irq_38,
	output wire        irq_39,
	output wire        irq_40,
	output wire        irq_41,
	output wire        irq_42,
	output wire        irq_43,
	output wire        irq_44,
	output wire        irq_45,
	output wire        irq_46,
	output wire        irq_47,
	output wire        irq_48,
	output wire        irq_49,
	output wire        irq_50,
	output wire        irq_51,
	output wire        irq_52,
	output wire        irq_53,
	output wire        irq_54,
	output wire        irq_55,
	output wire        irq_56,
	output wire        irq_57,
	output wire        irq_58,
	output wire        irq_59,
	output wire        irq_60,
	output wire        irq_61,
	output wire        irq_62,
	output wire        irq_63
);

assign irq_0  = (gp_in\[5:0\] ==  'd0) ? &gp_in\[31:6\] : 1'b0;
assign irq_1  = (gp_in\[5:0\] ==  'd1) ? &gp_in\[31:6\] : 1'b0;
assign irq_2  = (gp_in\[5:0\] ==  'd2) ? &gp_in\[31:6\] : 1'b0;
assign irq_3  = (gp_in\[5:0\] ==  'd3) ? &gp_in\[31:6\] : 1'b0;
assign irq_4  = (gp_in\[5:0\] ==  'd4) ? &gp_in\[31:6\] : 1'b0;
assign irq_5  = (gp_in\[5:0\] ==  'd5) ? &gp_in\[31:6\] : 1'b0;
assign irq_6  = (gp_in\[5:0\] ==  'd6) ? &gp_in\[31:6\] : 1'b0;
assign irq_7  = (gp_in\[5:0\] ==  'd7) ? &gp_in\[31:6\] : 1'b0;
assign irq_8  = (gp_in\[5:0\] ==  'd8) ? &gp_in\[31:6\] : 1'b0;
assign irq_9  = (gp_in\[5:0\] ==  'd9) ? &gp_in\[31:6\] : 1'b0;
assign irq_10 = (gp_in\[5:0\] == 'd10) ? &gp_in\[31:6\] : 1'b0;
assign irq_11 = (gp_in\[5:0\] == 'd11) ? &gp_in\[31:6\] : 1'b0;
assign irq_12 = (gp_in\[5:0\] == 'd12) ? &gp_in\[31:6\] : 1'b0;
assign irq_13 = (gp_in\[5:0\] == 'd13) ? &gp_in\[31:6\] : 1'b0;
assign irq_14 = (gp_in\[5:0\] == 'd14) ? &gp_in\[31:6\] : 1'b0;
assign irq_15 = (gp_in\[5:0\] == 'd15) ? &gp_in\[31:6\] : 1'b0;
assign irq_16 = (gp_in\[5:0\] == 'd16) ? &gp_in\[31:6\] : 1'b0;
assign irq_17 = (gp_in\[5:0\] == 'd17) ? &gp_in\[31:6\] : 1'b0;
assign irq_18 = (gp_in\[5:0\] == 'd18) ? &gp_in\[31:6\] : 1'b0;
assign irq_19 = (gp_in\[5:0\] == 'd19) ? &gp_in\[31:6\] : 1'b0;
assign irq_20 = (gp_in\[5:0\] == 'd20) ? &gp_in\[31:6\] : 1'b0;
assign irq_21 = (gp_in\[5:0\] == 'd21) ? &gp_in\[31:6\] : 1'b0;
assign irq_22 = (gp_in\[5:0\] == 'd22) ? &gp_in\[31:6\] : 1'b0;
assign irq_23 = (gp_in\[5:0\] == 'd23) ? &gp_in\[31:6\] : 1'b0;
assign irq_24 = (gp_in\[5:0\] == 'd24) ? &gp_in\[31:6\] : 1'b0;
assign irq_25 = (gp_in\[5:0\] == 'd25) ? &gp_in\[31:6\] : 1'b0;
assign irq_26 = (gp_in\[5:0\] == 'd26) ? &gp_in\[31:6\] : 1'b0;
assign irq_27 = (gp_in\[5:0\] == 'd27) ? &gp_in\[31:6\] : 1'b0;
assign irq_28 = (gp_in\[5:0\] == 'd28) ? &gp_in\[31:6\] : 1'b0;
assign irq_29 = (gp_in\[5:0\] == 'd29) ? &gp_in\[31:6\] : 1'b0;
assign irq_30 = (gp_in\[5:0\] == 'd30) ? &gp_in\[31:6\] : 1'b0;
assign irq_31 = (gp_in\[5:0\] == 'd31) ? &gp_in\[31:6\] : 1'b0;
assign irq_32 = (gp_in\[5:0\] == 'd32) ? &gp_in\[31:6\] : 1'b0;
assign irq_33 = (gp_in\[5:0\] == 'd33) ? &gp_in\[31:6\] : 1'b0;
assign irq_34 = (gp_in\[5:0\] == 'd34) ? &gp_in\[31:6\] : 1'b0;
assign irq_35 = (gp_in\[5:0\] == 'd35) ? &gp_in\[31:6\] : 1'b0;
assign irq_36 = (gp_in\[5:0\] == 'd36) ? &gp_in\[31:6\] : 1'b0;
assign irq_37 = (gp_in\[5:0\] == 'd37) ? &gp_in\[31:6\] : 1'b0;
assign irq_38 = (gp_in\[5:0\] == 'd38) ? &gp_in\[31:6\] : 1'b0;
assign irq_39 = (gp_in\[5:0\] == 'd39) ? &gp_in\[31:6\] : 1'b0;
assign irq_40 = (gp_in\[5:0\] == 'd40) ? &gp_in\[31:6\] : 1'b0;
assign irq_41 = (gp_in\[5:0\] == 'd41) ? &gp_in\[31:6\] : 1'b0;
assign irq_42 = (gp_in\[5:0\] == 'd42) ? &gp_in\[31:6\] : 1'b0;
assign irq_43 = (gp_in\[5:0\] == 'd43) ? &gp_in\[31:6\] : 1'b0;
assign irq_44 = (gp_in\[5:0\] == 'd44) ? &gp_in\[31:6\] : 1'b0;
assign irq_45 = (gp_in\[5:0\] == 'd45) ? &gp_in\[31:6\] : 1'b0;
assign irq_46 = (gp_in\[5:0\] == 'd46) ? &gp_in\[31:6\] : 1'b0;
assign irq_47 = (gp_in\[5:0\] == 'd47) ? &gp_in\[31:6\] : 1'b0;
assign irq_48 = (gp_in\[5:0\] == 'd48) ? &gp_in\[31:6\] : 1'b0;
assign irq_49 = (gp_in\[5:0\] == 'd49) ? &gp_in\[31:6\] : 1'b0;
assign irq_50 = (gp_in\[5:0\] == 'd50) ? &gp_in\[31:6\] : 1'b0;
assign irq_51 = (gp_in\[5:0\] == 'd51) ? &gp_in\[31:6\] : 1'b0;
assign irq_52 = (gp_in\[5:0\] == 'd52) ? &gp_in\[31:6\] : 1'b0;
assign irq_53 = (gp_in\[5:0\] == 'd53) ? &gp_in\[31:6\] : 1'b0;
assign irq_54 = (gp_in\[5:0\] == 'd54) ? &gp_in\[31:6\] : 1'b0;
assign irq_55 = (gp_in\[5:0\] == 'd55) ? &gp_in\[31:6\] : 1'b0;
assign irq_56 = (gp_in\[5:0\] == 'd56) ? &gp_in\[31:6\] : 1'b0;
assign irq_57 = (gp_in\[5:0\] == 'd57) ? &gp_in\[31:6\] : 1'b0;
assign irq_58 = (gp_in\[5:0\] == 'd58) ? &gp_in\[31:6\] : 1'b0;
assign irq_59 = (gp_in\[5:0\] == 'd59) ? &gp_in\[31:6\] : 1'b0;
assign irq_60 = (gp_in\[5:0\] == 'd60) ? &gp_in\[31:6\] : 1'b0;
assign irq_61 = (gp_in\[5:0\] == 'd61) ? &gp_in\[31:6\] : 1'b0;
assign irq_62 = (gp_in\[5:0\] == 'd62) ? &gp_in\[31:6\] : 1'b0;
assign irq_63 = (gp_in\[5:0\] == 'd63) ? &gp_in\[31:6\] : 1'b0;

endmodule
}

add_fileset_file "${output_name}.v" VERILOG TEXT [subst ${verilog_code}]

}
