#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_no_pins_pd_top {} {
	# create the system
	create_system no_pins_pd_top
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED065BB32AE5SR0}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component config_clk_250m ip/no_pins_pd_top/config_clk_250m.ip altera_s10_configuration_clock config_clk_250m 19.1.4
	load_component config_clk_250m
	set_component_parameter_value CBX_AUTO_BLACKBOX {ALL}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation config_clk_250m
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface clkout clock OUTPUT
	set_instantiation_interface_parameter_value clkout associatedDirectClock {}
	set_instantiation_interface_parameter_value clkout clockRate {0}
	set_instantiation_interface_parameter_value clkout clockRateKnown {false}
	set_instantiation_interface_parameter_value clkout externallyDriven {false}
	set_instantiation_interface_parameter_value clkout ptfSchematicName {}
	set_instantiation_interface_assignment_value clkout ui.blockdiagram.direction {OUTPUT}
	set_instantiation_interface_sysinfo_parameter_value clkout clock_rate {0}
	add_instantiation_interface_port clkout clkout clk 1 STD_LOGIC Output
	save_instantiation
	add_instance h2f_bridge h2f_bridge
	add_instance no_periph no_periph
	add_instance no_pins_hps no_pins_hps
	add_component usermode_entry ip/no_pins_pd_top/no_pins_pd_top_usermode_entry.ip intel_user_rst_clkgate usermode_entry 1.0.0
	load_component usermode_entry
	set_component_parameter_value outputType {Reset Interface}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation usermode_entry
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface ninit_done reset OUTPUT
	set_instantiation_interface_parameter_value ninit_done associatedClock {}
	set_instantiation_interface_parameter_value ninit_done associatedDirectReset {}
	set_instantiation_interface_parameter_value ninit_done associatedResetSinks {none}
	set_instantiation_interface_parameter_value ninit_done synchronousEdges {NONE}
	add_instantiation_interface_port ninit_done ninit_done reset 1 STD_LOGIC Output
	save_instantiation

	# add wirelevel expressions

	# preserve ports for debug

	# add the connections
	add_connection config_clk_250m.clkout/h2f_bridge.def_sub_clock
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.def_sub_clock clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.def_sub_clock clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.def_sub_clock clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.def_sub_clock resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/h2f_bridge.ocram_2k_00_clk1
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_00_clk1 clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_00_clk1 clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_00_clk1 clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_00_clk1 resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/h2f_bridge.ocram_2k_01_clk1
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_01_clk1 clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_01_clk1 clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_01_clk1 clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_01_clk1 resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/h2f_bridge.ocram_2k_10_clk1
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_10_clk1 clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_10_clk1 clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_10_clk1 clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_10_clk1 resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/h2f_bridge.ocram_2k_11_clk1
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_11_clk1 clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_11_clk1 clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_11_clk1 clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_11_clk1 resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/h2f_bridge.ocram_2k_20_clk1
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_20_clk1 clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_20_clk1 clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_20_clk1 clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_20_clk1 resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/h2f_bridge.ocram_2k_21_clk1
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_21_clk1 clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_21_clk1 clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_21_clk1 clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.ocram_2k_21_clk1 resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/h2f_bridge.sysid_clk
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.sysid_clk clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.sysid_clk clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.sysid_clk clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/h2f_bridge.sysid_clk resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/no_periph.f2h_term_clock
	set_connection_parameter_value config_clk_250m.clkout/no_periph.f2h_term_clock clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/no_periph.f2h_term_clock clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_periph.f2h_term_clock clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_periph.f2h_term_clock resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/no_periph.f2sdram_term_clock
	set_connection_parameter_value config_clk_250m.clkout/no_periph.f2sdram_term_clock clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/no_periph.f2sdram_term_clock clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_periph.f2sdram_term_clock clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_periph.f2sdram_term_clock resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/no_pins_hps.agilex_5_soc_f2sdram_axi_clock
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_f2sdram_axi_clock clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_f2sdram_axi_clock clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_f2sdram_axi_clock clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_f2sdram_axi_clock resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/no_pins_hps.agilex_5_soc_fpga2hps_clock
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_fpga2hps_clock clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_fpga2hps_clock clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_fpga2hps_clock clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_fpga2hps_clock resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/no_pins_hps.agilex_5_soc_hps2fpga_axi_clock
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_hps2fpga_axi_clock clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_hps2fpga_axi_clock clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_hps2fpga_axi_clock clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_hps2fpga_axi_clock resetDomainSysInfo {1}
	add_connection h2f_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp
	set_connection_parameter_value h2f_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp endPort {}
	set_connection_parameter_value h2f_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp endPortLSB {0}
	set_connection_parameter_value h2f_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp startPort {}
	set_connection_parameter_value h2f_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp startPortLSB {0}
	set_connection_parameter_value h2f_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp width {0}
	add_connection no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps addressMapSysInfo {<address-map><slave name='no_pins_hps/agilex_5_soc.fpga2hps' start='0x0' end='0x100000000' datawidth='256' /></address-map>}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps addressWidthSysInfo {32}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps arbitrationPriority {1}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps baseAddress {0x0000}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps defaultConnection {0}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps domainAlias {}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_periph.f2h_term_acelite_manager/no_pins_hps.agilex_5_soc_fpga2hps slaveDataWidthSysInfo {256}
	add_connection no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram addressMapSysInfo {<address-map><slave name='no_pins_hps.agilex_5_soc.f2sdram' start='0x0' end='0x100000000' datawidth='256' /></address-map>}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram addressWidthSysInfo {32}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram arbitrationPriority {1}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram baseAddress {0x0000}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram defaultConnection {0}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram domainAlias {}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram slaveDataWidthSysInfo {256}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.def_sub_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.def_sub_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.def_sub_reset clockResetSysInfo {<info><reset name="def_sub_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.def_sub_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_00_reset1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_00_reset1 clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_00_reset1 clockResetSysInfo {<info><reset name="ocram_2k_00_reset1" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_00_reset1 resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_01_reset1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_01_reset1 clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_01_reset1 clockResetSysInfo {<info><reset name="ocram_2k_01_reset1" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_01_reset1 resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_10_reset1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_10_reset1 clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_10_reset1 clockResetSysInfo {<info><reset name="ocram_2k_10_reset1" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_10_reset1 resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_11_reset1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_11_reset1 clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_11_reset1 clockResetSysInfo {<info><reset name="ocram_2k_11_reset1" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_11_reset1 resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_20_reset1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_20_reset1 clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_20_reset1 clockResetSysInfo {<info><reset name="ocram_2k_20_reset1" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_20_reset1 resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_21_reset1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_21_reset1 clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_21_reset1 clockResetSysInfo {<info><reset name="ocram_2k_21_reset1" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.ocram_2k_21_reset1 resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.sysid_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.sysid_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.sysid_reset clockResetSysInfo {<info><reset name="sysid_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/h2f_bridge.sysid_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/no_periph.f2h_term_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_periph.f2h_term_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_periph.f2h_term_reset clockResetSysInfo {<info><reset name="f2h_term_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_periph.f2h_term_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/no_periph.f2sdram_term_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_periph.f2sdram_term_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_periph.f2sdram_term_reset clockResetSysInfo {<info><reset name="f2sdram_term_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_periph.f2sdram_term_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_f2sdram_axi_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_f2sdram_axi_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_f2sdram_axi_reset clockResetSysInfo {<info><reset name="agilex_5_soc_f2sdram_axi_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_f2sdram_axi_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_fpga2hps_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_fpga2hps_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_fpga2hps_reset clockResetSysInfo {<info><reset name="agilex_5_soc_fpga2hps_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_fpga2hps_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_hps2fpga_axi_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_hps2fpga_axi_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_hps2fpga_axi_reset clockResetSysInfo {<info><reset name="agilex_5_soc_hps2fpga_axi_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_hps2fpga_axi_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub addressMapSysInfo {<address-map><slave name='h2f_bridge.ocram_2k_00.axi_s1' start='0x0' end='0x800' datawidth='32' /><slave name='h2f_bridge.sysid.control_slave' start='0x800' end='0x808' datawidth='32' /><slave name='h2f_bridge.ocram_2k_01.axi_s1' start='0x3FFFF800' end='0x40000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_10.axi_s1' start='0x40000000' end='0x40000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_11.axi_s1' start='0x3FFFFF800' end='0x400000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_20.axi_s1' start='0x400000000' end='0x400000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_21.axi_s1' start='0x3FFFFFF800' end='0x4000000000' datawidth='32' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub addressWidthSysInfo {38}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub baseAddress {0x0000}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub defaultConnection {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.def_sub_default_sub slaveDataWidthSysInfo {-1}
	add_connection no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 addressMapSysInfo {<address-map><slave name='h2f_bridge.ocram_2k_00.axi_s1' start='0x0' end='0x800' datawidth='32' /><slave name='h2f_bridge.sysid.control_slave' start='0x800' end='0x808' datawidth='32' /><slave name='h2f_bridge.ocram_2k_01.axi_s1' start='0x3FFFF800' end='0x40000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_10.axi_s1' start='0x40000000' end='0x40000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_11.axi_s1' start='0x3FFFFF800' end='0x400000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_20.axi_s1' start='0x400000000' end='0x400000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_21.axi_s1' start='0x3FFFFFF800' end='0x4000000000' datawidth='32' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 addressWidthSysInfo {38}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 baseAddress {0x0000}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_00_axi_s1 slaveDataWidthSysInfo {-1}
	add_connection no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 addressMapSysInfo {<address-map><slave name='h2f_bridge.ocram_2k_00.axi_s1' start='0x0' end='0x800' datawidth='32' /><slave name='h2f_bridge.sysid.control_slave' start='0x800' end='0x808' datawidth='32' /><slave name='h2f_bridge.ocram_2k_01.axi_s1' start='0x3FFFF800' end='0x40000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_10.axi_s1' start='0x40000000' end='0x40000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_11.axi_s1' start='0x3FFFFF800' end='0x400000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_20.axi_s1' start='0x400000000' end='0x400000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_21.axi_s1' start='0x3FFFFFF800' end='0x4000000000' datawidth='32' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 addressWidthSysInfo {38}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 baseAddress {0x3ffff800}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_01_axi_s1 slaveDataWidthSysInfo {-1}
	add_connection no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 addressMapSysInfo {<address-map><slave name='h2f_bridge.ocram_2k_00.axi_s1' start='0x0' end='0x800' datawidth='32' /><slave name='h2f_bridge.sysid.control_slave' start='0x800' end='0x808' datawidth='32' /><slave name='h2f_bridge.ocram_2k_01.axi_s1' start='0x3FFFF800' end='0x40000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_10.axi_s1' start='0x40000000' end='0x40000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_11.axi_s1' start='0x3FFFFF800' end='0x400000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_20.axi_s1' start='0x400000000' end='0x400000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_21.axi_s1' start='0x3FFFFFF800' end='0x4000000000' datawidth='32' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 addressWidthSysInfo {38}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 baseAddress {0x40000000}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_10_axi_s1 slaveDataWidthSysInfo {-1}
	add_connection no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 addressMapSysInfo {<address-map><slave name='h2f_bridge.ocram_2k_00.axi_s1' start='0x0' end='0x800' datawidth='32' /><slave name='h2f_bridge.sysid.control_slave' start='0x800' end='0x808' datawidth='32' /><slave name='h2f_bridge.ocram_2k_01.axi_s1' start='0x3FFFF800' end='0x40000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_10.axi_s1' start='0x40000000' end='0x40000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_11.axi_s1' start='0x3FFFFF800' end='0x400000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_20.axi_s1' start='0x400000000' end='0x400000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_21.axi_s1' start='0x3FFFFFF800' end='0x4000000000' datawidth='32' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 addressWidthSysInfo {38}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 baseAddress {0x00000003fffff800}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_11_axi_s1 slaveDataWidthSysInfo {-1}
	add_connection no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 addressMapSysInfo {<address-map><slave name='h2f_bridge.ocram_2k_00.axi_s1' start='0x0' end='0x800' datawidth='32' /><slave name='h2f_bridge.sysid.control_slave' start='0x800' end='0x808' datawidth='32' /><slave name='h2f_bridge.ocram_2k_01.axi_s1' start='0x3FFFF800' end='0x40000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_10.axi_s1' start='0x40000000' end='0x40000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_11.axi_s1' start='0x3FFFFF800' end='0x400000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_20.axi_s1' start='0x400000000' end='0x400000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_21.axi_s1' start='0x3FFFFFF800' end='0x4000000000' datawidth='32' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 addressWidthSysInfo {38}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 baseAddress {0x0000000400000000}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_20_axi_s1 slaveDataWidthSysInfo {-1}
	add_connection no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 addressMapSysInfo {<address-map><slave name='h2f_bridge.ocram_2k_00.axi_s1' start='0x0' end='0x800' datawidth='32' /><slave name='h2f_bridge.sysid.control_slave' start='0x800' end='0x808' datawidth='32' /><slave name='h2f_bridge.ocram_2k_01.axi_s1' start='0x3FFFF800' end='0x40000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_10.axi_s1' start='0x40000000' end='0x40000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_11.axi_s1' start='0x3FFFFF800' end='0x400000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_20.axi_s1' start='0x400000000' end='0x400000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_21.axi_s1' start='0x3FFFFFF800' end='0x4000000000' datawidth='32' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 addressWidthSysInfo {38}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 baseAddress {0x0000003ffffff800}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.ocram_2k_21_axi_s1 slaveDataWidthSysInfo {-1}
	add_connection no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave addressMapSysInfo {<address-map><slave name='h2f_bridge.ocram_2k_00.axi_s1' start='0x0' end='0x800' datawidth='32' /><slave name='h2f_bridge.sysid.control_slave' start='0x800' end='0x808' datawidth='32' /><slave name='h2f_bridge.ocram_2k_01.axi_s1' start='0x3FFFF800' end='0x40000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_10.axi_s1' start='0x40000000' end='0x40000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_11.axi_s1' start='0x3FFFFF800' end='0x400000000' datawidth='32' /><slave name='h2f_bridge.ocram_2k_20.axi_s1' start='0x400000000' end='0x400000800' datawidth='32' /><slave name='h2f_bridge.ocram_2k_21.axi_s1' start='0x3FFFFFF800' end='0x4000000000' datawidth='32' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave addressWidthSysInfo {38}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave baseAddress {0x0800}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps2fpga/h2f_bridge.sysid_control_slave slaveDataWidthSysInfo {-1}
	add_connection usermode_entry.ninit_done/h2f_bridge.def_sub_reset
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.def_sub_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.def_sub_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.def_sub_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/h2f_bridge.ocram_2k_00_reset1
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_00_reset1 clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_00_reset1 clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_00_reset1 resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/h2f_bridge.ocram_2k_01_reset1
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_01_reset1 clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_01_reset1 clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_01_reset1 resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/h2f_bridge.ocram_2k_10_reset1
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_10_reset1 clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_10_reset1 clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_10_reset1 resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/h2f_bridge.ocram_2k_11_reset1
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_11_reset1 clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_11_reset1 clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_11_reset1 resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/h2f_bridge.ocram_2k_20_reset1
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_20_reset1 clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_20_reset1 clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_20_reset1 resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/h2f_bridge.ocram_2k_21_reset1
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_21_reset1 clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_21_reset1 clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.ocram_2k_21_reset1 resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/h2f_bridge.sysid_reset
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.sysid_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.sysid_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/h2f_bridge.sysid_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/no_periph.f2h_term_reset
	set_connection_parameter_value usermode_entry.ninit_done/no_periph.f2h_term_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/no_periph.f2h_term_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/no_periph.f2h_term_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/no_periph.f2sdram_term_reset
	set_connection_parameter_value usermode_entry.ninit_done/no_periph.f2sdram_term_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/no_periph.f2sdram_term_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/no_periph.f2sdram_term_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_f2sdram_axi_reset
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_f2sdram_axi_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_f2sdram_axi_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_f2sdram_axi_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_fpga2hps_reset
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_fpga2hps_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_fpga2hps_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_fpga2hps_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_hps2fpga_axi_reset
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_hps2fpga_axi_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_hps2fpga_axi_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_hps2fpga_axi_reset resetDomainSysInfo {14}

	# add the exports
	set_interface_property lwhps2fpga_axi_clock EXPORT_OF no_pins_hps.agilex_5_soc_lwhps2fpga_axi_clock
	set_interface_property lwhps2fpga_axi_reset EXPORT_OF no_pins_hps.agilex_5_soc_lwhps2fpga_axi_reset
	set_interface_property lwhps2fpga EXPORT_OF no_pins_hps.agilex_5_soc_lwhps2fpga
	set_interface_property emac_ptp_clk EXPORT_OF no_pins_hps.agilex_5_soc_emac_ptp_clk
	set_interface_property emac_timestamp_clk EXPORT_OF no_pins_hps.agilex_5_soc_emac_timestamp_clk
	set_interface_property emac_timestamp_data EXPORT_OF no_pins_hps.agilex_5_soc_emac_timestamp_data
	set_interface_property emac0_app_rst EXPORT_OF no_pins_hps.agilex_5_soc_emac0_app_rst
	set_interface_property emac0 EXPORT_OF no_pins_hps.agilex_5_soc_emac0
	set_interface_property spim0 EXPORT_OF no_pins_hps.agilex_5_soc_spim0
	set_interface_property spim0_sclk_out EXPORT_OF no_pins_hps.agilex_5_soc_spim0_sclk_out
	set_interface_property uart1 EXPORT_OF no_pins_hps.agilex_5_soc_uart1
	set_interface_property i2c0_scl_i EXPORT_OF no_pins_hps.agilex_5_soc_I2C0_scl_i
	set_interface_property i2c0_scl_oe EXPORT_OF no_pins_hps.agilex_5_soc_I2C0_scl_oe
	set_interface_property i2c0 EXPORT_OF no_pins_hps.agilex_5_soc_I2C0
	set_interface_property h2f_user0_clk EXPORT_OF no_pins_hps.agilex_5_soc_h2f_user0_clk
	set_interface_property h2f_user1_clk EXPORT_OF no_pins_hps.agilex_5_soc_h2f_user1_clk
	set_interface_property hps_io EXPORT_OF no_pins_hps.agilex_5_soc_hps_io
	set_interface_property fpga2hps_interrupt EXPORT_OF no_pins_hps.agilex_5_soc_fpga2hps_interrupt
	set_interface_property emif_bank3a_hps_emif_mem_0 EXPORT_OF no_pins_hps.emif_bank3a_hps_emif_mem_0
	set_interface_property emif_bank3a_hps_emif_oct_0 EXPORT_OF no_pins_hps.emif_bank3a_hps_emif_oct_0
	set_interface_property emif_bank3a_hps_emif_ref_clk_0 EXPORT_OF no_pins_hps.emif_bank3a_hps_emif_ref_clk_0

	# set values for exposed HDL parameters
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.enableAllPipelines FALSE
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.enableEccProtection FALSE
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.enableInstrumentation FALSE
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.interconnectType STANDARD
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.maxAdditionalLatency 1
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.syncResets TRUE
	set_domain_assignment no_periph.f2h_term_acelite_manager qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.enableAllPipelines FALSE
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.enableEccProtection FALSE
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.enableInstrumentation FALSE
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.interconnectType STANDARD
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.maxAdditionalLatency 1
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.syncResets TRUE
	set_domain_assignment no_periph.f2sdram_term_axi4_man qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.enableAllPipelines FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.enableEccProtection FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.enableInstrumentation FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.interconnectType STANDARD
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.maxAdditionalLatency 1
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.syncResets TRUE
	set_domain_assignment no_pins_hps.agilex_5_soc_hps2fpga qsys_mm.widthAdapterImplementation GENERIC_CONVERTER

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="config_clk_250m">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
 <element __value="h2f_bridge">
  <datum __value="_sortIndex" value="4" type="int" />
 </element>
 <element __value="no_periph">
  <datum __value="_sortIndex" value="3" type="int" />
 </element>
 <element __value="no_pins_hps">
  <datum __value="_sortIndex" value="2" type="int" />
 </element>
 <element __value="onchip_M20Kx64.axi_s1">
  <datum __value="baseAddress" value="65536" type="String" />
 </element>
 <element __value="usermode_entry">
  <datum __value="_sortIndex" value="1" type="int" />
 </element>
</bonusData>
}
	set_module_property FILE {no_pins_pd_top.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {no_pins_pd_top}

	# save the system
	sync_sysinfo_parameters
	save_system no_pins_pd_top
}
