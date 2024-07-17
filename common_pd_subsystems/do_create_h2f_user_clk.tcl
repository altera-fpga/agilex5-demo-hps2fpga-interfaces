#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_h2f_user_clk {} {
	# create the system
	create_system h2f_user_clk
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED065BB32AE5SR0}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component clk_br_0 ip/h2f_user_clk/clk_br_0.ip altera_clock_bridge clk_br_0 19.2.0
	load_component clk_br_0
	set_component_parameter_value EXPLICIT_CLOCK_RATE {0.0}
	set_component_parameter_value NUM_CLOCK_OUTPUTS {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation clk_br_0
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface in_clk clock INPUT
	set_instantiation_interface_parameter_value in_clk clockRate {0}
	set_instantiation_interface_parameter_value in_clk externallyDriven {false}
	set_instantiation_interface_parameter_value in_clk ptfSchematicName {}
	add_instantiation_interface_port in_clk in_clk clk 1 STD_LOGIC Input
	add_instantiation_interface out_clk clock OUTPUT
	set_instantiation_interface_parameter_value out_clk associatedDirectClock {in_clk}
	set_instantiation_interface_parameter_value out_clk clockRate {0}
	set_instantiation_interface_parameter_value out_clk clockRateKnown {false}
	set_instantiation_interface_parameter_value out_clk externallyDriven {false}
	set_instantiation_interface_parameter_value out_clk ptfSchematicName {}
	set_instantiation_interface_sysinfo_parameter_value out_clk clock_rate {0}
	add_instantiation_interface_port out_clk out_clk clk 1 STD_LOGIC Output
	save_instantiation
	add_component clk_br_1 ip/h2f_user_clk/clk_br_1.ip altera_clock_bridge clk_br_1 19.2.0
	load_component clk_br_1
	set_component_parameter_value EXPLICIT_CLOCK_RATE {0.0}
	set_component_parameter_value NUM_CLOCK_OUTPUTS {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation clk_br_1
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface in_clk clock INPUT
	set_instantiation_interface_parameter_value in_clk clockRate {0}
	set_instantiation_interface_parameter_value in_clk externallyDriven {false}
	set_instantiation_interface_parameter_value in_clk ptfSchematicName {}
	add_instantiation_interface_port in_clk in_clk clk 1 STD_LOGIC Input
	add_instantiation_interface out_clk clock OUTPUT
	set_instantiation_interface_parameter_value out_clk associatedDirectClock {in_clk}
	set_instantiation_interface_parameter_value out_clk clockRate {0}
	set_instantiation_interface_parameter_value out_clk clockRateKnown {false}
	set_instantiation_interface_parameter_value out_clk externallyDriven {false}
	set_instantiation_interface_parameter_value out_clk ptfSchematicName {}
	set_instantiation_interface_sysinfo_parameter_value out_clk clock_rate {0}
	add_instantiation_interface_port out_clk out_clk clk 1 STD_LOGIC Output
	save_instantiation
	add_component gp_in_const ip/no_pins_pd_top/gp_in_const.ip hps_gp_in_constant gp_in_const 1.0
	load_component gp_in_const
	set_component_parameter_value GPIN_CONSTANT {1263289173}
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
	add_component gp_in_count_0 ip/no_pins_pd_top/gp_in_count_0.ip hps_gp_in_counter gp_in_count_0 1.0
	load_component gp_in_count_0
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation gp_in_count_0
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface clock clock INPUT
	set_instantiation_interface_parameter_value clock clockRate {0}
	set_instantiation_interface_parameter_value clock externallyDriven {false}
	set_instantiation_interface_parameter_value clock ptfSchematicName {}
	add_instantiation_interface_port clock clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clock}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset reset reset 1 STD_LOGIC Input
	add_instantiation_interface hps_gp_in conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_in associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_in associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_in prSafe {false}
	add_instantiation_interface_port hps_gp_in gp_in gp_exp 32 STD_LOGIC_VECTOR Output
	save_instantiation
	add_component gp_in_count_1 ip/no_pins_pd_top/gp_in_count_1.ip hps_gp_in_counter gp_in_count_1 1.0
	load_component gp_in_count_1
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation gp_in_count_1
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface clock clock INPUT
	set_instantiation_interface_parameter_value clock clockRate {0}
	set_instantiation_interface_parameter_value clock externallyDriven {false}
	set_instantiation_interface_parameter_value clock ptfSchematicName {}
	add_instantiation_interface_port clock clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clock}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset reset reset 1 STD_LOGIC Input
	add_instantiation_interface hps_gp_in conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_in associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_in associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_in prSafe {false}
	add_instantiation_interface_port hps_gp_in gp_in gp_exp 32 STD_LOGIC_VECTOR Output
	save_instantiation
	add_component gp_in_mux_0 ip/no_pins_pd_top/gp_in_mux_0.ip hps_gp_in_mux gp_in_mux_0 1.0
	load_component gp_in_mux_0
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation gp_in_mux_0
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
	add_component gp_in_mux_1 ip/no_pins_pd_top/gp_in_mux_1.ip hps_gp_in_mux gp_in_mux_1 1.0
	load_component gp_in_mux_1
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation gp_in_mux_1
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
	add_component gp_out_mux_sel ip/no_pins_pd_top/gp_out_mux_sel.ip hps_gp_out_mux_sel gp_out_mux_sel 1.0
	load_component gp_out_mux_sel
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation gp_out_mux_sel
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface hps_gp_out conduit INPUT
	set_instantiation_interface_parameter_value hps_gp_out associatedClock {}
	set_instantiation_interface_parameter_value hps_gp_out associatedReset {}
	set_instantiation_interface_parameter_value hps_gp_out prSafe {false}
	add_instantiation_interface_port hps_gp_out gp_in gp_exp 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface reset_out reset OUTPUT
	set_instantiation_interface_parameter_value reset_out associatedClock {}
	set_instantiation_interface_parameter_value reset_out associatedDirectReset {}
	set_instantiation_interface_parameter_value reset_out associatedResetSinks {none}
	set_instantiation_interface_parameter_value reset_out synchronousEdges {NONE}
	add_instantiation_interface_port reset_out reset_n reset_n 1 STD_LOGIC Output
	add_instantiation_interface mux_sel_0 conduit INPUT
	set_instantiation_interface_parameter_value mux_sel_0 associatedClock {}
	set_instantiation_interface_parameter_value mux_sel_0 associatedReset {}
	set_instantiation_interface_parameter_value mux_sel_0 prSafe {false}
	add_instantiation_interface_port mux_sel_0 mux_sel_0 mux_sel 1 STD_LOGIC Output
	add_instantiation_interface mux_sel_1 conduit INPUT
	set_instantiation_interface_parameter_value mux_sel_1 associatedClock {}
	set_instantiation_interface_parameter_value mux_sel_1 associatedReset {}
	set_instantiation_interface_parameter_value mux_sel_1 prSafe {false}
	add_instantiation_interface_port mux_sel_1 mux_sel_1 mux_sel 1 STD_LOGIC Output
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
	add_connection clk_br_0.out_clk/gp_in_count_0.clock
	set_connection_parameter_value clk_br_0.out_clk/gp_in_count_0.clock clockDomainSysInfo {-1}
	set_connection_parameter_value clk_br_0.out_clk/gp_in_count_0.clock clockRateSysInfo {}
	set_connection_parameter_value clk_br_0.out_clk/gp_in_count_0.clock clockResetSysInfo {}
	set_connection_parameter_value clk_br_0.out_clk/gp_in_count_0.clock resetDomainSysInfo {-1}
	add_connection clk_br_1.out_clk/gp_in_count_1.clock
	set_connection_parameter_value clk_br_1.out_clk/gp_in_count_1.clock clockDomainSysInfo {-1}
	set_connection_parameter_value clk_br_1.out_clk/gp_in_count_1.clock clockRateSysInfo {}
	set_connection_parameter_value clk_br_1.out_clk/gp_in_count_1.clock clockResetSysInfo {}
	set_connection_parameter_value clk_br_1.out_clk/gp_in_count_1.clock resetDomainSysInfo {-1}
	add_connection gp_in_const.hps_gp_in/gp_in_mux_0.hps_gp_in_0
	set_connection_parameter_value gp_in_const.hps_gp_in/gp_in_mux_0.hps_gp_in_0 endPort {}
	set_connection_parameter_value gp_in_const.hps_gp_in/gp_in_mux_0.hps_gp_in_0 endPortLSB {0}
	set_connection_parameter_value gp_in_const.hps_gp_in/gp_in_mux_0.hps_gp_in_0 startPort {}
	set_connection_parameter_value gp_in_const.hps_gp_in/gp_in_mux_0.hps_gp_in_0 startPortLSB {0}
	set_connection_parameter_value gp_in_const.hps_gp_in/gp_in_mux_0.hps_gp_in_0 width {0}
	add_connection gp_in_count_0.hps_gp_in/gp_in_mux_1.hps_gp_in_1
	set_connection_parameter_value gp_in_count_0.hps_gp_in/gp_in_mux_1.hps_gp_in_1 endPort {}
	set_connection_parameter_value gp_in_count_0.hps_gp_in/gp_in_mux_1.hps_gp_in_1 endPortLSB {0}
	set_connection_parameter_value gp_in_count_0.hps_gp_in/gp_in_mux_1.hps_gp_in_1 startPort {}
	set_connection_parameter_value gp_in_count_0.hps_gp_in/gp_in_mux_1.hps_gp_in_1 startPortLSB {0}
	set_connection_parameter_value gp_in_count_0.hps_gp_in/gp_in_mux_1.hps_gp_in_1 width {0}
	add_connection gp_in_count_1.hps_gp_in/gp_in_mux_1.hps_gp_in_0
	set_connection_parameter_value gp_in_count_1.hps_gp_in/gp_in_mux_1.hps_gp_in_0 endPort {}
	set_connection_parameter_value gp_in_count_1.hps_gp_in/gp_in_mux_1.hps_gp_in_0 endPortLSB {0}
	set_connection_parameter_value gp_in_count_1.hps_gp_in/gp_in_mux_1.hps_gp_in_0 startPort {}
	set_connection_parameter_value gp_in_count_1.hps_gp_in/gp_in_mux_1.hps_gp_in_0 startPortLSB {0}
	set_connection_parameter_value gp_in_count_1.hps_gp_in/gp_in_mux_1.hps_gp_in_0 width {0}
	add_connection gp_in_mux_1.hps_gp_in/gp_in_mux_0.hps_gp_in_1
	set_connection_parameter_value gp_in_mux_1.hps_gp_in/gp_in_mux_0.hps_gp_in_1 endPort {}
	set_connection_parameter_value gp_in_mux_1.hps_gp_in/gp_in_mux_0.hps_gp_in_1 endPortLSB {0}
	set_connection_parameter_value gp_in_mux_1.hps_gp_in/gp_in_mux_0.hps_gp_in_1 startPort {}
	set_connection_parameter_value gp_in_mux_1.hps_gp_in/gp_in_mux_0.hps_gp_in_1 startPortLSB {0}
	set_connection_parameter_value gp_in_mux_1.hps_gp_in/gp_in_mux_0.hps_gp_in_1 width {0}
	add_connection gp_out_mux_sel.mux_sel_0/gp_in_mux_0.mux_sel
	set_connection_parameter_value gp_out_mux_sel.mux_sel_0/gp_in_mux_0.mux_sel endPort {}
	set_connection_parameter_value gp_out_mux_sel.mux_sel_0/gp_in_mux_0.mux_sel endPortLSB {0}
	set_connection_parameter_value gp_out_mux_sel.mux_sel_0/gp_in_mux_0.mux_sel startPort {}
	set_connection_parameter_value gp_out_mux_sel.mux_sel_0/gp_in_mux_0.mux_sel startPortLSB {0}
	set_connection_parameter_value gp_out_mux_sel.mux_sel_0/gp_in_mux_0.mux_sel width {0}
	add_connection gp_out_mux_sel.mux_sel_1/gp_in_mux_1.mux_sel
	set_connection_parameter_value gp_out_mux_sel.mux_sel_1/gp_in_mux_1.mux_sel endPort {}
	set_connection_parameter_value gp_out_mux_sel.mux_sel_1/gp_in_mux_1.mux_sel endPortLSB {0}
	set_connection_parameter_value gp_out_mux_sel.mux_sel_1/gp_in_mux_1.mux_sel startPort {}
	set_connection_parameter_value gp_out_mux_sel.mux_sel_1/gp_in_mux_1.mux_sel startPortLSB {0}
	set_connection_parameter_value gp_out_mux_sel.mux_sel_1/gp_in_mux_1.mux_sel width {0}
	add_connection gp_out_mux_sel.reset_out/gp_in_count_0.reset
	set_connection_parameter_value gp_out_mux_sel.reset_out/gp_in_count_0.reset clockDomainSysInfo {-1}
	set_connection_parameter_value gp_out_mux_sel.reset_out/gp_in_count_0.reset clockResetSysInfo {}
	set_connection_parameter_value gp_out_mux_sel.reset_out/gp_in_count_0.reset resetDomainSysInfo {-1}
	add_connection gp_out_mux_sel.reset_out/gp_in_count_1.reset
	set_connection_parameter_value gp_out_mux_sel.reset_out/gp_in_count_1.reset clockDomainSysInfo {-1}
	set_connection_parameter_value gp_out_mux_sel.reset_out/gp_in_count_1.reset clockResetSysInfo {}
	set_connection_parameter_value gp_out_mux_sel.reset_out/gp_in_count_1.reset resetDomainSysInfo {-1}
	add_connection hps_gp_split.hps_gp_in/gp_in_mux_0.hps_gp_in
	set_connection_parameter_value hps_gp_split.hps_gp_in/gp_in_mux_0.hps_gp_in endPort {}
	set_connection_parameter_value hps_gp_split.hps_gp_in/gp_in_mux_0.hps_gp_in endPortLSB {0}
	set_connection_parameter_value hps_gp_split.hps_gp_in/gp_in_mux_0.hps_gp_in startPort {}
	set_connection_parameter_value hps_gp_split.hps_gp_in/gp_in_mux_0.hps_gp_in startPortLSB {0}
	set_connection_parameter_value hps_gp_split.hps_gp_in/gp_in_mux_0.hps_gp_in width {0}
	add_connection hps_gp_split.hps_gp_out/gp_out_mux_sel.hps_gp_out
	set_connection_parameter_value hps_gp_split.hps_gp_out/gp_out_mux_sel.hps_gp_out endPort {}
	set_connection_parameter_value hps_gp_split.hps_gp_out/gp_out_mux_sel.hps_gp_out endPortLSB {0}
	set_connection_parameter_value hps_gp_split.hps_gp_out/gp_out_mux_sel.hps_gp_out startPort {}
	set_connection_parameter_value hps_gp_split.hps_gp_out/gp_out_mux_sel.hps_gp_out startPortLSB {0}
	set_connection_parameter_value hps_gp_split.hps_gp_out/gp_out_mux_sel.hps_gp_out width {0}

	# add the exports
	set_interface_property clk_br_0_in_clk EXPORT_OF clk_br_0.in_clk
	set_interface_property clk_br_1_in_clk EXPORT_OF clk_br_1.in_clk
	set_interface_property hps_gp_split_hps_gp EXPORT_OF hps_gp_split.hps_gp

	# set values for exposed HDL parameters

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="clk_br_0">
  <datum __value="_sortIndex" value="7" type="int" />
 </element>
 <element __value="clk_br_1">
  <datum __value="_sortIndex" value="8" type="int" />
 </element>
 <element __value="gp_in_const">
  <datum __value="_sortIndex" value="4" type="int" />
 </element>
 <element __value="gp_in_count_0">
  <datum __value="_sortIndex" value="5" type="int" />
 </element>
 <element __value="gp_in_count_1">
  <datum __value="_sortIndex" value="6" type="int" />
 </element>
 <element __value="gp_in_mux_0">
  <datum __value="_sortIndex" value="2" type="int" />
 </element>
 <element __value="gp_in_mux_1">
  <datum __value="_sortIndex" value="3" type="int" />
 </element>
 <element __value="gp_out_mux_sel">
  <datum __value="_sortIndex" value="1" type="int" />
 </element>
 <element __value="hps_gp_split">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
</bonusData>
}
	set_module_property FILE {h2f_user_clk.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {h2f_user_clk}

	# save the system
	sync_sysinfo_parameters
	save_system h2f_user_clk
}
