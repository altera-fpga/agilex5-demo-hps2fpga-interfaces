#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_emac {} {
	# create the system
	create_system emac
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED065BB32AE6SR0}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component emac_loop ip/no_pins_pd_top/emac_loop.ip hps_emac_loop emac_loop 1.0
	load_component emac_loop
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation emac_loop
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface hps_emac_loop conduit INPUT
	set_instantiation_interface_parameter_value hps_emac_loop associatedClock {}
	set_instantiation_interface_parameter_value hps_emac_loop associatedReset {}
	set_instantiation_interface_parameter_value hps_emac_loop prSafe {false}
	add_instantiation_interface_port hps_emac_loop emac_mac_tx_clk_o mac_tx_clk_o 1 STD_LOGIC Input
	add_instantiation_interface_port hps_emac_loop emac_mac_tx_clk_i mac_tx_clk_i 1 STD_LOGIC Output
	add_instantiation_interface_port hps_emac_loop emac_mac_rx_clk mac_rx_clk 1 STD_LOGIC Output
	add_instantiation_interface_port hps_emac_loop emac_mac_rst_tx_n mac_rst_tx_n 1 STD_LOGIC Input
	add_instantiation_interface_port hps_emac_loop emac_mac_rst_rx_n mac_rst_rx_n 1 STD_LOGIC Input
	add_instantiation_interface_port hps_emac_loop emac_mac_txen mac_txen 1 STD_LOGIC Input
	add_instantiation_interface_port hps_emac_loop emac_mac_txer mac_txer 1 STD_LOGIC Input
	add_instantiation_interface_port hps_emac_loop emac_mac_rxdv mac_rxdv 1 STD_LOGIC Output
	add_instantiation_interface_port hps_emac_loop emac_mac_rxer mac_rxer 1 STD_LOGIC Output
	add_instantiation_interface_port hps_emac_loop emac_mac_rxd mac_rxd 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps_emac_loop emac_mac_col mac_col 1 STD_LOGIC Output
	add_instantiation_interface_port hps_emac_loop emac_mac_crs mac_crs 1 STD_LOGIC Output
	add_instantiation_interface_port hps_emac_loop emac_mac_speed mac_speed 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port hps_emac_loop emac_mac_txd_o mac_txd_o 8 STD_LOGIC_VECTOR Input
	save_instantiation
	add_component gp_in_const ip/no_pins_pd_top/gp_in_const.ip hps_gp_in_constant gp_in_const 1.0
	load_component gp_in_const
	set_component_parameter_value GPIN_CONSTANT {1128353093}
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
	add_connection hps_gp_split.hps_gp_in/gp_in_const.hps_gp_in
	set_connection_parameter_value hps_gp_split.hps_gp_in/gp_in_const.hps_gp_in endPort {}
	set_connection_parameter_value hps_gp_split.hps_gp_in/gp_in_const.hps_gp_in endPortLSB {0}
	set_connection_parameter_value hps_gp_split.hps_gp_in/gp_in_const.hps_gp_in startPort {}
	set_connection_parameter_value hps_gp_split.hps_gp_in/gp_in_const.hps_gp_in startPortLSB {0}
	set_connection_parameter_value hps_gp_split.hps_gp_in/gp_in_const.hps_gp_in width {0}

	# add the exports
	set_interface_property emac_loop_hps_emac_loop EXPORT_OF emac_loop.hps_emac_loop
	set_interface_property hps_gp_split_hps_gp EXPORT_OF hps_gp_split.hps_gp
	set_interface_property hps_gp_split_hps_gp_out EXPORT_OF hps_gp_split.hps_gp_out

	# set values for exposed HDL parameters

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="emac_loop">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
 <element __value="gp_in_const">
  <datum __value="_sortIndex" value="2" type="int" />
 </element>
 <element __value="hps_gp_split">
  <datum __value="_sortIndex" value="1" type="int" />
 </element>
</bonusData>
}
	set_module_property FILE {emac.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {emac}

	# save the system
	sync_sysinfo_parameters
	save_system emac
}
