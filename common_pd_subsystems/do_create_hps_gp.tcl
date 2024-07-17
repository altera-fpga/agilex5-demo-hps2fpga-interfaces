#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_hps_gp {} {
	# create the system
	create_system hps_gp
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED065BB32AE5SR0}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component gp_in_const ip/no_pins_pd_top/gp_in_const.ip hps_gp_in_constant gp_in_const 1.0
	load_component gp_in_const
	set_component_parameter_value GPIN_CONSTANT {1330204743}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation gp_in_const
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface hps_gp_in conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_in associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_in associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_in prSafe {false}
	add_instantiation_interface_port hps_gp_in gp_in gp_exp 32 STD_LOGIC_VECTOR Output
	save_instantiation
	add_component gp_in_mux ip/no_pins_pd_top/gp_in_mux.ip hps_gp_in_mux gp_in_mux 1.0
	load_component gp_in_mux
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation gp_in_mux
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface hps_gp_in_1 conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_in_1 associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_in_1 associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_in_1 prSafe {false}
	add_instantiation_interface_port hps_gp_in_1 gp_in_1 gp_exp 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface hps_gp_in_0 conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_in_0 associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_in_0 associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_in_0 prSafe {false}
	add_instantiation_interface_port hps_gp_in_0 gp_in_0 gp_exp 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface hps_gp_in conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_in associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_in associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_in prSafe {false}
	add_instantiation_interface_port hps_gp_in gp_in gp_exp 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface mux_sel conduit INPUT
	set_instantiation_interface_parameter_value mux_sel associatedClock {}
	set_instantiation_interface_parameter_value mux_sel associatedReset {}
	set_instantiation_interface_parameter_value mux_sel prSafe {false}
	add_instantiation_interface_port mux_sel mux_sel mux_sel 1 STD_LOGIC Input
	save_instantiation
	add_component gp_out_or ip/no_pins_pd_top/gp_out_or.ip hps_gp_out_or gp_out_or 1.0
	load_component gp_out_or
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation gp_out_or
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface hps_gp_out conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_out associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_out associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_out prSafe {false}
	add_instantiation_interface_port hps_gp_out gp_in gp_exp 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface hps_gp_in conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_in associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_in associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_in prSafe {false}
	add_instantiation_interface_port hps_gp_in gp_out gp_exp 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface mux_sel conduit INPUT
	set_instantiation_interface_parameter_value mux_sel associatedClock {}
	set_instantiation_interface_parameter_value mux_sel associatedReset {}
	set_instantiation_interface_parameter_value mux_sel prSafe {false}
	add_instantiation_interface_port mux_sel mux_sel mux_sel 1 STD_LOGIC Output
	save_instantiation
	add_component hps_gp_split ip/no_pins_pd_top/hps_gp_split.ip hps_gp_splitter hps_gp_split 1.0
	load_component hps_gp_split
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation hps_gp_split
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface hps_gp conduit INPUT
	set_instantiation_interface_parameter_value hps_gp associatedClock {}
	set_instantiation_interface_parameter_value hps_gp associatedReset {}
	set_instantiation_interface_parameter_value hps_gp prSafe {false}
	add_instantiation_interface_port hps_gp hps_gp_gp_in gp_in 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps_gp hps_gp_gp_out gp_out 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface hps_gp_in conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_in associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_in associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_in prSafe {false}
	add_instantiation_interface_port hps_gp_in gp_in gp_exp 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface hps_gp_out conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_out associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_out associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_out prSafe {false}
	add_instantiation_interface_port hps_gp_out gp_out gp_exp 32 STD_LOGIC_VECTOR Output
	save_instantiation

	# add wirelevel expressions

	# preserve ports for debug

	# add the connections
	add_connection gp_in_const.hps_gp_in/gp_in_mux.hps_gp_in_0
	set_connection_parameter_value gp_in_const.hps_gp_in/gp_in_mux.hps_gp_in_0 endPort {}
	set_connection_parameter_value gp_in_const.hps_gp_in/gp_in_mux.hps_gp_in_0 endPortLSB {0}
	set_connection_parameter_value gp_in_const.hps_gp_in/gp_in_mux.hps_gp_in_0 startPort {}
	set_connection_parameter_value gp_in_const.hps_gp_in/gp_in_mux.hps_gp_in_0 startPortLSB {0}
	set_connection_parameter_value gp_in_const.hps_gp_in/gp_in_mux.hps_gp_in_0 width {0}
	add_connection gp_in_mux.hps_gp_in/hps_gp_split.hps_gp_in
	set_connection_parameter_value gp_in_mux.hps_gp_in/hps_gp_split.hps_gp_in endPort {}
	set_connection_parameter_value gp_in_mux.hps_gp_in/hps_gp_split.hps_gp_in endPortLSB {0}
	set_connection_parameter_value gp_in_mux.hps_gp_in/hps_gp_split.hps_gp_in startPort {}
	set_connection_parameter_value gp_in_mux.hps_gp_in/hps_gp_split.hps_gp_in startPortLSB {0}
	set_connection_parameter_value gp_in_mux.hps_gp_in/hps_gp_split.hps_gp_in width {0}
	add_connection gp_in_mux.mux_sel/gp_out_or.mux_sel
	set_connection_parameter_value gp_in_mux.mux_sel/gp_out_or.mux_sel endPort {}
	set_connection_parameter_value gp_in_mux.mux_sel/gp_out_or.mux_sel endPortLSB {0}
	set_connection_parameter_value gp_in_mux.mux_sel/gp_out_or.mux_sel startPort {}
	set_connection_parameter_value gp_in_mux.mux_sel/gp_out_or.mux_sel startPortLSB {0}
	set_connection_parameter_value gp_in_mux.mux_sel/gp_out_or.mux_sel width {0}
	add_connection gp_out_or.hps_gp_in/gp_in_mux.hps_gp_in_1
	set_connection_parameter_value gp_out_or.hps_gp_in/gp_in_mux.hps_gp_in_1 endPort {}
	set_connection_parameter_value gp_out_or.hps_gp_in/gp_in_mux.hps_gp_in_1 endPortLSB {0}
	set_connection_parameter_value gp_out_or.hps_gp_in/gp_in_mux.hps_gp_in_1 startPort {}
	set_connection_parameter_value gp_out_or.hps_gp_in/gp_in_mux.hps_gp_in_1 startPortLSB {0}
	set_connection_parameter_value gp_out_or.hps_gp_in/gp_in_mux.hps_gp_in_1 width {0}
	add_connection hps_gp_split.hps_gp_out/gp_out_or.hps_gp_out
	set_connection_parameter_value hps_gp_split.hps_gp_out/gp_out_or.hps_gp_out endPort {}
	set_connection_parameter_value hps_gp_split.hps_gp_out/gp_out_or.hps_gp_out endPortLSB {0}
	set_connection_parameter_value hps_gp_split.hps_gp_out/gp_out_or.hps_gp_out startPort {}
	set_connection_parameter_value hps_gp_split.hps_gp_out/gp_out_or.hps_gp_out startPortLSB {0}
	set_connection_parameter_value hps_gp_split.hps_gp_out/gp_out_or.hps_gp_out width {0}

	# add the exports
	set_interface_property hps_gp_split_hps_gp EXPORT_OF hps_gp_split.hps_gp

	# set values for exposed HDL parameters

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="gp_in_const">
  <datum __value="_sortIndex" value="3" type="int" />
 </element>
 <element __value="gp_in_mux">
  <datum __value="_sortIndex" value="1" type="int" />
 </element>
 <element __value="gp_out_or">
  <datum __value="_sortIndex" value="2" type="int" />
 </element>
 <element __value="hps_gp_split">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
</bonusData>
}
	set_module_property FILE {hps_gp.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {hps_gp}

	# save the system
	sync_sysinfo_parameters
	save_system hps_gp
}
