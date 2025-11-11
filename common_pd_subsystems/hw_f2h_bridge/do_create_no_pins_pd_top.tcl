#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_no_pins_pd_top {} {
	# create the system
	create_system no_pins_pd_top
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED013BM16AE4SCS}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component config_clk_250m ip/no_pins_pd_top/config_clk_250m.ip altera_s10_configuration_clock config_clk_250m 19.1.6
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
	add_instance f2h_bridge f2h_bridge
	add_component lwh2f_br ip/no_pins_pd_top/lwh2f_br.ip altera_axi_bridge lwh2f_br 19.10.0
	load_component lwh2f_br
	set_component_parameter_value ACE5_LITE_SUPPORT {0}
	set_component_parameter_value ACE_LITE_SUPPORT {0}
	set_component_parameter_value ADDR_WIDTH {29}
	set_component_parameter_value ATOMIC_TXN {0}
	set_component_parameter_value AXI_VERSION {AXI4}
	set_component_parameter_value BACKPRESSURE_DURING_RESET {0}
	set_component_parameter_value BITSPERBYTE {0}
	set_component_parameter_value CACHESTASHING_TXN {0}
	set_component_parameter_value COMBINED_ACCEPTANCE_CAPABILITY {16}
	set_component_parameter_value COMBINED_ISSUING_CAPABILITY {16}
	set_component_parameter_value DATA_WIDTH {32}
	set_component_parameter_value ENABLE_CONCURRENT_SUBORDINATE_ACCESS {0}
	set_component_parameter_value ENABLE_OOO {0}
	set_component_parameter_value M0_ID_WIDTH {4}
	set_component_parameter_value NO_REPEATED_IDS_BETWEEN_SUBORDINATES {0}
	set_component_parameter_value READ_ACCEPTANCE_CAPABILITY {16}
	set_component_parameter_value READ_ADDR_USER_WIDTH {64}
	set_component_parameter_value READ_DATA_REORDERING_DEPTH {1}
	set_component_parameter_value READ_DATA_USER_WIDTH {16}
	set_component_parameter_value READ_ISSUING_CAPABILITY {16}
	set_component_parameter_value S0_ID_WIDTH {4}
	set_component_parameter_value SAI_WIDTH {1}
	set_component_parameter_value SID_WIDTH {1}
	set_component_parameter_value SYNC_RESET {0}
	set_component_parameter_value UNTRANSLATED_TXN {0}
	set_component_parameter_value USE_M0_ADDRCHK {0}
	set_component_parameter_value USE_M0_ARBURST {1}
	set_component_parameter_value USE_M0_ARCACHE {1}
	set_component_parameter_value USE_M0_ARID {1}
	set_component_parameter_value USE_M0_ARLEN {1}
	set_component_parameter_value USE_M0_ARLOCK {1}
	set_component_parameter_value USE_M0_ARQOS {0}
	set_component_parameter_value USE_M0_ARREGION {0}
	set_component_parameter_value USE_M0_ARSIZE {1}
	set_component_parameter_value USE_M0_ARSNOOP {0}
	set_component_parameter_value USE_M0_ARUSER {0}
	set_component_parameter_value USE_M0_AWAKEUP {0}
	set_component_parameter_value USE_M0_AWBURST {1}
	set_component_parameter_value USE_M0_AWCACHE {1}
	set_component_parameter_value USE_M0_AWID {1}
	set_component_parameter_value USE_M0_AWLEN {1}
	set_component_parameter_value USE_M0_AWLOCK {1}
	set_component_parameter_value USE_M0_AWQOS {0}
	set_component_parameter_value USE_M0_AWREGION {0}
	set_component_parameter_value USE_M0_AWSIZE {1}
	set_component_parameter_value USE_M0_AWSNOOP {0}
	set_component_parameter_value USE_M0_AWUNIQUE {0}
	set_component_parameter_value USE_M0_AWUSER {0}
	set_component_parameter_value USE_M0_BID {1}
	set_component_parameter_value USE_M0_BRESP {1}
	set_component_parameter_value USE_M0_BUSER {0}
	set_component_parameter_value USE_M0_DATACHK {0}
	set_component_parameter_value USE_M0_POISON {0}
	set_component_parameter_value USE_M0_RID {1}
	set_component_parameter_value USE_M0_RLAST {1}
	set_component_parameter_value USE_M0_RRESP {1}
	set_component_parameter_value USE_M0_RUSER {0}
	set_component_parameter_value USE_M0_SAI {0}
	set_component_parameter_value USE_M0_TRACE {0}
	set_component_parameter_value USE_M0_USER_DATA {0}
	set_component_parameter_value USE_M0_WSTRB {1}
	set_component_parameter_value USE_M0_WUSER {0}
	set_component_parameter_value USE_PIPELINE {1}
	set_component_parameter_value USE_S0_ADDRCHK {0}
	set_component_parameter_value USE_S0_ARCACHE {1}
	set_component_parameter_value USE_S0_ARLOCK {1}
	set_component_parameter_value USE_S0_ARPROT {1}
	set_component_parameter_value USE_S0_ARQOS {0}
	set_component_parameter_value USE_S0_ARREGION {0}
	set_component_parameter_value USE_S0_ARSIZE {0}
	set_component_parameter_value USE_S0_ARUSER {0}
	set_component_parameter_value USE_S0_AWAKEUP {0}
	set_component_parameter_value USE_S0_AWCACHE {1}
	set_component_parameter_value USE_S0_AWLOCK {1}
	set_component_parameter_value USE_S0_AWPROT {1}
	set_component_parameter_value USE_S0_AWQOS {0}
	set_component_parameter_value USE_S0_AWREGION {0}
	set_component_parameter_value USE_S0_AWSIZE {0}
	set_component_parameter_value USE_S0_AWUSER {0}
	set_component_parameter_value USE_S0_BID {0}
	set_component_parameter_value USE_S0_BRESP {1}
	set_component_parameter_value USE_S0_BUSER {0}
	set_component_parameter_value USE_S0_DATACHK {0}
	set_component_parameter_value USE_S0_POISON {0}
	set_component_parameter_value USE_S0_RID {0}
	set_component_parameter_value USE_S0_RRESP {1}
	set_component_parameter_value USE_S0_RUSER {0}
	set_component_parameter_value USE_S0_SAI {0}
	set_component_parameter_value USE_S0_TRACE {0}
	set_component_parameter_value USE_S0_USER_DATA {0}
	set_component_parameter_value USE_S0_WLAST {1}
	set_component_parameter_value USE_S0_WUSER {0}
	set_component_parameter_value WRITE_ACCEPTANCE_CAPABILITY {16}
	set_component_parameter_value WRITE_ADDR_USER_WIDTH {64}
	set_component_parameter_value WRITE_DATA_USER_WIDTH {16}
	set_component_parameter_value WRITE_ISSUING_CAPABILITY {16}
	set_component_parameter_value WRITE_RESP_USER_WIDTH {16}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation lwh2f_br
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.dts.compatible {simple-bus}
	set_instantiation_assignment_value embeddedsw.dts.group {bridge}
	set_instantiation_assignment_value embeddedsw.dts.name {bridge}
	set_instantiation_assignment_value embeddedsw.dts.vendor {altr}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk aclk clk 1 STD_LOGIC Input
	add_instantiation_interface clk_reset reset INPUT
	set_instantiation_interface_parameter_value clk_reset associatedClock {clk}
	set_instantiation_interface_parameter_value clk_reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port clk_reset aresetn reset_n 1 STD_LOGIC Input
	add_instantiation_interface s0 axi4 INPUT
	set_instantiation_interface_parameter_value s0 addressCheck {false}
	set_instantiation_interface_parameter_value s0 associatedClock {clk}
	set_instantiation_interface_parameter_value s0 associatedReset {clk_reset}
	set_instantiation_interface_parameter_value s0 bridgesToMaster {m0}
	set_instantiation_interface_parameter_value s0 combinedAcceptanceCapability {16}
	set_instantiation_interface_parameter_value s0 dataCheck {false}
	set_instantiation_interface_parameter_value s0 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s0 dfhFeatureId {35}
	set_instantiation_interface_parameter_value s0 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s0 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s0 dfhFeatureType {3}
	set_instantiation_interface_parameter_value s0 dfhGroupId {0}
	set_instantiation_interface_parameter_value s0 dfhParameterData {}
	set_instantiation_interface_parameter_value s0 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s0 dfhParameterId {}
	set_instantiation_interface_parameter_value s0 dfhParameterName {}
	set_instantiation_interface_parameter_value s0 dfhParameterVersion {}
	set_instantiation_interface_parameter_value s0 isTranslator {false}
	set_instantiation_interface_parameter_value s0 maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value s0 maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value s0 maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value s0 optionalAssociatedReset {false}
	set_instantiation_interface_parameter_value s0 poison {false}
	set_instantiation_interface_parameter_value s0 readAcceptanceCapability {16}
	set_instantiation_interface_parameter_value s0 readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value s0 securityAttribute {false}
	set_instantiation_interface_parameter_value s0 traceSignals {false}
	set_instantiation_interface_parameter_value s0 trustzoneAware {true}
	set_instantiation_interface_parameter_value s0 uniqueIdSupport {false}
	set_instantiation_interface_parameter_value s0 userData {false}
	set_instantiation_interface_parameter_value s0 wakeupSignals {false}
	set_instantiation_interface_parameter_value s0 writeAcceptanceCapability {16}
	set_instantiation_interface_sysinfo_parameter_value s0 address_map {}
	set_instantiation_interface_sysinfo_parameter_value s0 address_width {}
	set_instantiation_interface_sysinfo_parameter_value s0 max_slave_data_width {}
	add_instantiation_interface_port s0 s0_awid awid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_awaddr awaddr 29 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_awlock awlock 1 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_awcache awcache 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_awprot awprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port s0 s0_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port s0 s0_wdata wdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_wstrb wstrb 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port s0 s0_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port s0 s0_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port s0 s0_bid bid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0 s0_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0 s0_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port s0 s0_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port s0 s0_arid arid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_araddr araddr 29 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_arlock arlock 1 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_arcache arcache 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_arprot arprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port s0 s0_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port s0 s0_rid rid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0 s0_rdata rdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0 s0_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0 s0_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port s0 s0_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port s0 s0_rready rready 1 STD_LOGIC Input
	add_instantiation_interface m0 axi4 OUTPUT
	set_instantiation_interface_parameter_value m0 addressCheck {false}
	set_instantiation_interface_parameter_value m0 associatedClock {clk}
	set_instantiation_interface_parameter_value m0 associatedReset {clk_reset}
	set_instantiation_interface_parameter_value m0 combinedIssuingCapability {16}
	set_instantiation_interface_parameter_value m0 dataCheck {false}
	set_instantiation_interface_parameter_value m0 enableConcurrentSubordinateAccess {0}
	set_instantiation_interface_parameter_value m0 isTranslator {false}
	set_instantiation_interface_parameter_value m0 issuesFIXEDBursts {true}
	set_instantiation_interface_parameter_value m0 issuesINCRBursts {true}
	set_instantiation_interface_parameter_value m0 issuesWRAPBursts {true}
	set_instantiation_interface_parameter_value m0 maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value m0 maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value m0 maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value m0 noRepeatedIdsBetweenSubordinates {0}
	set_instantiation_interface_parameter_value m0 optionalAssociatedReset {false}
	set_instantiation_interface_parameter_value m0 poison {false}
	set_instantiation_interface_parameter_value m0 readIssuingCapability {16}
	set_instantiation_interface_parameter_value m0 securityAttribute {false}
	set_instantiation_interface_parameter_value m0 traceSignals {false}
	set_instantiation_interface_parameter_value m0 trustzoneAware {true}
	set_instantiation_interface_parameter_value m0 uniqueIdSupport {false}
	set_instantiation_interface_parameter_value m0 userData {false}
	set_instantiation_interface_parameter_value m0 wakeupSignals {false}
	set_instantiation_interface_parameter_value m0 writeIssuingCapability {16}
	add_instantiation_interface_port m0 m0_awid awid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_awaddr awaddr 29 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_awlen awlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_awsize awsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_awburst awburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_awlock awlock 1 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_awcache awcache 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_awprot awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port m0 m0_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port m0 m0_wdata wdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_wstrb wstrb 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_wlast wlast 1 STD_LOGIC Output
	add_instantiation_interface_port m0 m0_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port m0 m0_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port m0 m0_bid bid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port m0 m0_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port m0 m0_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port m0 m0_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port m0 m0_arid arid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_araddr araddr 29 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_arlen arlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_arsize arsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_arburst arburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_arlock arlock 1 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_arcache arcache 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port m0 m0_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port m0 m0_rid rid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port m0 m0_rdata rdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port m0 m0_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port m0 m0_rlast rlast 1 STD_LOGIC Input
	add_instantiation_interface_port m0 m0_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port m0 m0_rready rready 1 STD_LOGIC Output
	save_instantiation
	add_instance no_periph no_periph
	add_instance no_pins_hps no_pins_hps
	add_component usermode_entry ip/no_pins_pd_top/usermode_entry.ip intel_user_rst_clkgate usermode_entry 1.0.1
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
	add_connection config_clk_250m.clkout/f2h_bridge.clock_br_in_clk
	set_connection_parameter_value config_clk_250m.clkout/f2h_bridge.clock_br_in_clk clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/f2h_bridge.clock_br_in_clk clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/f2h_bridge.clock_br_in_clk clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/f2h_bridge.clock_br_in_clk resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/lwh2f_br.clk
	set_connection_parameter_value config_clk_250m.clkout/lwh2f_br.clk clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/lwh2f_br.clk clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/lwh2f_br.clk clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/lwh2f_br.clk resetDomainSysInfo {1}
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
	add_connection config_clk_250m.clkout/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_clock
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_clock clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_clock clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_clock clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_clock resetDomainSysInfo {1}
	add_connection f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps addressMapSysInfo {<address-map><slave name='no_pins_hps/agilex_5_soc.fpga2hps' start='0x0' end='0x100000000' datawidth='256' /></address-map>}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps addressWidthSysInfo {32}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps arbitrationPriority {1}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps baseAddress {0x0000}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps cpuInfoIdSysInfo {}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps defaultConnection {0}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps domainAlias {}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2h_bridge.f2h_adapt_256b_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps slaveDataWidthSysInfo {256}
	add_connection f2h_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp
	set_connection_parameter_value f2h_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp endPort {}
	set_connection_parameter_value f2h_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp endPortLSB {0}
	set_connection_parameter_value f2h_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp startPort {}
	set_connection_parameter_value f2h_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp startPortLSB {0}
	set_connection_parameter_value f2h_bridge.hps_gp_split_hps_gp/no_pins_hps.agilex_5_soc_hps_gp width {0}
	add_connection f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 addressMapSysInfo {<address-map><slave name='f2h_bridge.limiter_removal_256b.s0' start='0x0' end='0x100000000' datawidth='256' /><slave name='f2h_bridge.ocram_32k.s1' start='0x100000000' end='0x100008000' datawidth='256' /></address-map>}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 addressWidthSysInfo {33}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 arbitrationPriority {1}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 baseAddress {0x0000}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 cpuInfoIdSysInfo {}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 defaultConnection {0}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 domainAlias {}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.limiter_removal_256b_s0 slaveDataWidthSysInfo {256}
	add_connection f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 addressMapSysInfo {<address-map><slave name='f2h_bridge.limiter_removal_256b.s0' start='0x0' end='0x100000000' datawidth='256' /><slave name='f2h_bridge.ocram_32k.s1' start='0x100000000' end='0x100008000' datawidth='256' /></address-map>}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 addressWidthSysInfo {33}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 arbitrationPriority {1}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 baseAddress {0x0000000100000000}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 defaultConnection {0}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 domainAlias {}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_read/f2h_bridge.ocram_32k_s1 slaveDataWidthSysInfo {256}
	add_connection f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 addressMapSysInfo {<address-map><slave name='f2h_bridge.limiter_removal_256b.s1' start='0x0' end='0x100000000' datawidth='256' /><slave name='f2h_bridge.ocram_32k.s1' start='0x100000000' end='0x100008000' datawidth='256' /></address-map>}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 addressWidthSysInfo {33}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 arbitrationPriority {1}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 baseAddress {0x0000}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 defaultConnection {0}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 domainAlias {}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.limiter_removal_256b_s1 slaveDataWidthSysInfo {256}
	add_connection f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 addressMapSysInfo {<address-map><slave name='f2h_bridge.limiter_removal_256b.s1' start='0x0' end='0x100000000' datawidth='256' /><slave name='f2h_bridge.ocram_32k.s1' start='0x100000000' end='0x100008000' datawidth='256' /></address-map>}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 addressWidthSysInfo {33}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 arbitrationPriority {1}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 baseAddress {0x0000000100000000}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 defaultConnection {0}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 domainAlias {}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2h_bridge.msgdma_256b_mm_write/f2h_bridge.ocram_32k_s1 slaveDataWidthSysInfo {256}
	add_connection lwh2f_br.m0/f2h_bridge.def_sub_default_sub
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub addressMapSysInfo {<address-map><slave name='f2h_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2h_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub addressWidthSysInfo {16}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub arbitrationPriority {1}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub baseAddress {0x0000}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub cpuInfoIdSysInfo {}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub defaultConnection {1}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub domainAlias {}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.syncResets {TRUE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.def_sub_default_sub slaveDataWidthSysInfo {256}
	add_connection lwh2f_br.m0/f2h_bridge.msgdma_256b_csr
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr addressMapSysInfo {<address-map><slave name='f2h_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2h_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr addressWidthSysInfo {16}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr arbitrationPriority {1}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr baseAddress {0x1000}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr cpuInfoIdSysInfo {}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr defaultConnection {0}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr domainAlias {}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.syncResets {TRUE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_csr slaveDataWidthSysInfo {256}
	add_connection lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave addressMapSysInfo {<address-map><slave name='f2h_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2h_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave addressWidthSysInfo {16}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave arbitrationPriority {1}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave baseAddress {0x2000}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave cpuInfoIdSysInfo {}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave defaultConnection {0}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave domainAlias {}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.syncResets {TRUE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.msgdma_256b_descriptor_slave slaveDataWidthSysInfo {256}
	add_connection lwh2f_br.m0/f2h_bridge.ocram_32k_s1
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 addressMapSysInfo {<address-map><slave name='f2h_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2h_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 addressWidthSysInfo {16}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 arbitrationPriority {1}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 baseAddress {0x8000}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 defaultConnection {0}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 domainAlias {}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.ocram_32k_s1 slaveDataWidthSysInfo {256}
	add_connection lwh2f_br.m0/f2h_bridge.sysid_control_slave
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave addressMapSysInfo {<address-map><slave name='f2h_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2h_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave addressWidthSysInfo {16}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave arbitrationPriority {1}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave baseAddress {0x0000}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave cpuInfoIdSysInfo {}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave defaultConnection {0}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave domainAlias {}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.syncResets {TRUE}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value lwh2f_br.m0/f2h_bridge.sysid_control_slave slaveDataWidthSysInfo {256}
	add_connection no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram addressMapSysInfo {<address-map><slave name='no_pins_hps.agilex_5_soc.f2sdram' start='0x0' end='0x100000000' datawidth='256' /></address-map>}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram addressWidthSysInfo {32}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram arbitrationPriority {1}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram baseAddress {0x0000}
	set_connection_parameter_value no_periph.f2sdram_term_axi4_man/no_pins_hps.agilex_5_soc_f2sdram cpuInfoIdSysInfo {}
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
	add_connection no_pins_hps.agilex_5_soc_fpga2hps_interrupt_irq0/f2h_bridge.msgdma_256b_csr_irq
	set_connection_parameter_value no_pins_hps.agilex_5_soc_fpga2hps_interrupt_irq0/f2h_bridge.msgdma_256b_csr_irq interruptsUsedSysInfo {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_fpga2hps_interrupt_irq0/f2h_bridge.msgdma_256b_csr_irq irqNumber {0}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/f2h_bridge.reset_br_in_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/f2h_bridge.reset_br_in_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/f2h_bridge.reset_br_in_reset clockResetSysInfo {<info><reset name="reset_br_in_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/f2h_bridge.reset_br_in_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/lwh2f_br.clk_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/lwh2f_br.clk_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/lwh2f_br.clk_reset clockResetSysInfo {<info><reset name="clk_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/lwh2f_br.clk_reset resetDomainSysInfo {2}
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
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_reset clockResetSysInfo {<info><reset name="agilex_5_soc_lwhps2fpga_axi_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 addressMapSysInfo {<address-map><slave name='f2h_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2h_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2h_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 addressWidthSysInfo {29}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 baseAddress {0x0000}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 cpuInfoIdSysInfo {5cf00ee8}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/lwh2f_br.s0 slaveDataWidthSysInfo {-1}
	add_connection usermode_entry.ninit_done/f2h_bridge.reset_br_in_reset
	set_connection_parameter_value usermode_entry.ninit_done/f2h_bridge.reset_br_in_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/f2h_bridge.reset_br_in_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/f2h_bridge.reset_br_in_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/lwh2f_br.clk_reset
	set_connection_parameter_value usermode_entry.ninit_done/lwh2f_br.clk_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/lwh2f_br.clk_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/lwh2f_br.clk_reset resetDomainSysInfo {14}
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
	add_connection usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_reset
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/no_pins_hps.agilex_5_soc_lwhps2fpga_axi_reset resetDomainSysInfo {14}

	# add the exports
	set_interface_property hps2fpga_axi_clock EXPORT_OF no_pins_hps.agilex_5_soc_hps2fpga_axi_clock
	set_interface_property hps2fpga_axi_reset EXPORT_OF no_pins_hps.agilex_5_soc_hps2fpga_axi_reset
	set_interface_property hps2fpga EXPORT_OF no_pins_hps.agilex_5_soc_hps2fpga
	set_interface_property emac_ptp_clk EXPORT_OF no_pins_hps.agilex_5_soc_emac_ptp_clk
	set_interface_property emac_timestamp_clk EXPORT_OF no_pins_hps.agilex_5_soc_emac_timestamp_clk
	set_interface_property emac_timestamp_data EXPORT_OF no_pins_hps.agilex_5_soc_emac_timestamp_data
	set_interface_property emac0_app_rst EXPORT_OF no_pins_hps.agilex_5_soc_emac0_app_rst
	set_interface_property emac0 EXPORT_OF no_pins_hps.agilex_5_soc_emac0
	set_interface_property spim0 EXPORT_OF no_pins_hps.agilex_5_soc_spim0
	set_interface_property spim0_sclk_out EXPORT_OF no_pins_hps.agilex_5_soc_spim0_sclk_out
	set_interface_property uart1 EXPORT_OF no_pins_hps.agilex_5_soc_uart1
	set_interface_property i2c0_scl_i EXPORT_OF no_pins_hps.agilex_5_soc_i2c0_scl_i
	set_interface_property i2c0_scl_oe EXPORT_OF no_pins_hps.agilex_5_soc_i2c0_scl_oe
	set_interface_property i2c0 EXPORT_OF no_pins_hps.agilex_5_soc_i2c0
	set_interface_property h2f_user0_clk EXPORT_OF no_pins_hps.agilex_5_soc_h2f_user0_clk
	set_interface_property h2f_user1_clk EXPORT_OF no_pins_hps.agilex_5_soc_h2f_user1_clk
	set_interface_property hps_io EXPORT_OF no_pins_hps.agilex_5_soc_hps_io
	set_interface_property emif_bank3a_hps_mem_0 EXPORT_OF no_pins_hps.emif_bank3a_hps_mem_0
	set_interface_property emif_bank3a_hps_mem_ck_0 EXPORT_OF no_pins_hps.emif_bank3a_hps_mem_ck_0
	set_interface_property emif_bank3a_hps_mem_reset_n EXPORT_OF no_pins_hps.emif_bank3a_hps_mem_reset_n
	set_interface_property emif_bank3a_hps_oct_0 EXPORT_OF no_pins_hps.emif_bank3a_hps_oct_0
	set_interface_property emif_bank3a_hps_ref_clk EXPORT_OF no_pins_hps.emif_bank3a_hps_ref_clk

	# set values for exposed HDL parameters
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.enableAllPipelines FALSE
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.enableEccProtection FALSE
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.enableInstrumentation FALSE
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.interconnectType STANDARD
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.maxAdditionalLatency 1
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.syncResets TRUE
	set_domain_assignment f2h_bridge.f2h_adapt_256b_ace5lite_manager qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.enableAllPipelines FALSE
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.enableEccProtection FALSE
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.enableInstrumentation FALSE
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.interconnectType STANDARD
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.maxAdditionalLatency 4
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.syncResets TRUE
	set_domain_assignment f2h_bridge.msgdma_256b_mm_read qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
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
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.enableAllPipelines FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.enableEccProtection FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.enableInstrumentation FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.interconnectType STANDARD
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.maxAdditionalLatency 4
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.syncResets TRUE
	set_domain_assignment no_pins_hps.agilex_5_soc_lwhps2fpga qsys_mm.widthAdapterImplementation GENERIC_CONVERTER

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="config_clk_250m">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
 <element __value="f2h_bridge">
  <datum __value="_sortIndex" value="4" type="int" />
 </element>
 <element __value="f2h_bridge.msgdma_256b_csr">
  <datum __value="baseAddress" value="4096" type="String" />
 </element>
 <element __value="f2h_bridge.msgdma_256b_descriptor_slave">
  <datum __value="baseAddress" value="8192" type="String" />
 </element>
 <element __value="lwh2f_br">
  <datum __value="_sortIndex" value="5" type="int" />
 </element>
 <element __value="no_periph">
  <datum __value="_sortIndex" value="3" type="int" />
 </element>
 <element __value="no_pins_hps">
  <datum __value="_sortIndex" value="2" type="int" />
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
