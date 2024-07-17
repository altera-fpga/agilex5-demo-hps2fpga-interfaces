#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_no_periph {} {
	# create the system
	create_system no_periph
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED065BB32AE5SR0}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component f2h_term ip/no_pins_pd_top/f2h_term.ip f2h_terminator_256 f2h_term 1.0
	load_component f2h_term
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation f2h_term
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
	add_instantiation_interface acelite_manager acelite OUTPUT
	set_instantiation_interface_parameter_value acelite_manager addressCheck {false}
	set_instantiation_interface_parameter_value acelite_manager associatedClock {clock}
	set_instantiation_interface_parameter_value acelite_manager associatedReset {reset}
	set_instantiation_interface_parameter_value acelite_manager combinedIssuingCapability {16}
	set_instantiation_interface_parameter_value acelite_manager dataCheck {false}
	set_instantiation_interface_parameter_value acelite_manager issuesFIXEDBursts {true}
	set_instantiation_interface_parameter_value acelite_manager issuesINCRBursts {true}
	set_instantiation_interface_parameter_value acelite_manager issuesWRAPBursts {true}
	set_instantiation_interface_parameter_value acelite_manager maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value acelite_manager maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value acelite_manager maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value acelite_manager poison {false}
	set_instantiation_interface_parameter_value acelite_manager readIssuingCapability {8}
	set_instantiation_interface_parameter_value acelite_manager securityAttribute {false}
	set_instantiation_interface_parameter_value acelite_manager traceSignals {false}
	set_instantiation_interface_parameter_value acelite_manager trustzoneAware {true}
	set_instantiation_interface_parameter_value acelite_manager uniqueIdSupport {false}
	set_instantiation_interface_parameter_value acelite_manager userData {false}
	set_instantiation_interface_parameter_value acelite_manager wakeupSignals {false}
	set_instantiation_interface_parameter_value acelite_manager writeIssuingCapability {8}
	add_instantiation_interface_port acelite_manager m0_awid awid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awaddr awaddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awlen awlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awsize awsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awburst awburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awlock awlock 1 STD_LOGIC Output
	add_instantiation_interface_port acelite_manager m0_awcache awcache 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awprot awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port acelite_manager m0_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port acelite_manager m0_awqos awqos 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_wdata wdata 256 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_wstrb wstrb 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_wlast wlast 1 STD_LOGIC Output
	add_instantiation_interface_port acelite_manager m0_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port acelite_manager m0_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port acelite_manager m0_bid bid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port acelite_manager m0_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port acelite_manager m0_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port acelite_manager m0_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port acelite_manager m0_arid arid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_araddr araddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_arlen arlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_arsize arsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_arburst arburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_arlock arlock 1 STD_LOGIC Output
	add_instantiation_interface_port acelite_manager m0_arcache arcache 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port acelite_manager m0_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port acelite_manager m0_arqos arqos 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_rid rid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port acelite_manager m0_rdata rdata 256 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port acelite_manager m0_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port acelite_manager m0_rlast rlast 1 STD_LOGIC Input
	add_instantiation_interface_port acelite_manager m0_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port acelite_manager m0_rready rready 1 STD_LOGIC Output
	add_instantiation_interface_port acelite_manager m0_awdomain awdomain 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awbar awbar 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_ardomain ardomain 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_arbar arbar 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_arsnoop arsnoop 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awsnoop awsnoop 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_aruser aruser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awuser awuser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_buser buser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port acelite_manager m0_ruser ruser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port acelite_manager m0_wuser wuser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_arregion arregion 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port acelite_manager m0_awregion awregion 4 STD_LOGIC_VECTOR Output
	save_instantiation
	add_component f2sdram_term ip/no_pins_pd_top/f2sdram_term.ip f2sdram_terminator_64 f2sdram_term 1.0
	load_component f2sdram_term
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation f2sdram_term
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
	add_instantiation_interface axi4_man axi4 OUTPUT
	set_instantiation_interface_parameter_value axi4_man addressCheck {false}
	set_instantiation_interface_parameter_value axi4_man associatedClock {clock}
	set_instantiation_interface_parameter_value axi4_man associatedReset {reset}
	set_instantiation_interface_parameter_value axi4_man combinedIssuingCapability {1}
	set_instantiation_interface_parameter_value axi4_man dataCheck {false}
	set_instantiation_interface_parameter_value axi4_man issuesFIXEDBursts {true}
	set_instantiation_interface_parameter_value axi4_man issuesINCRBursts {true}
	set_instantiation_interface_parameter_value axi4_man issuesWRAPBursts {true}
	set_instantiation_interface_parameter_value axi4_man maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value axi4_man maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value axi4_man maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value axi4_man poison {false}
	set_instantiation_interface_parameter_value axi4_man readIssuingCapability {1}
	set_instantiation_interface_parameter_value axi4_man securityAttribute {false}
	set_instantiation_interface_parameter_value axi4_man traceSignals {false}
	set_instantiation_interface_parameter_value axi4_man trustzoneAware {true}
	set_instantiation_interface_parameter_value axi4_man uniqueIdSupport {false}
	set_instantiation_interface_parameter_value axi4_man userData {false}
	set_instantiation_interface_parameter_value axi4_man wakeupSignals {false}
	set_instantiation_interface_parameter_value axi4_man writeIssuingCapability {1}
	add_instantiation_interface_port axi4_man man_araddr araddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_arburst arburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_arcache arcache 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_arid arid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_arlen arlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_arlock arlock 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_man man_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_arqos arqos 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_man man_arsize arsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_man man_awaddr awaddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_awburst awburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_awcache awcache 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_awid awid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_awlen awlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_awlock awlock 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_man man_awprot awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_awqos awqos 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_man man_awsize awsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_man man_bid bid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_man man_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_man man_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_man man_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_man man_rdata rdata 64 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_man man_rid rid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_man man_rlast rlast 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_man man_rready rready 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_man man_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_man man_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_man man_wdata wdata 64 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_wlast wlast 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_man man_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_man man_wstrb wstrb 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_man man_aruser aruser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_awuser awuser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_wuser wuser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_buser buser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_man man_arregion arregion 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_man man_ruser ruser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_man man_awregion awregion 4 STD_LOGIC_VECTOR Output
	save_instantiation

	# add wirelevel expressions

	# preserve ports for debug

	# add the exports
	set_interface_property f2h_term_clock EXPORT_OF f2h_term.clock
	set_interface_property f2h_term_reset EXPORT_OF f2h_term.reset
	set_interface_property f2h_term_acelite_manager EXPORT_OF f2h_term.acelite_manager
	set_interface_property f2sdram_term_clock EXPORT_OF f2sdram_term.clock
	set_interface_property f2sdram_term_reset EXPORT_OF f2sdram_term.reset
	set_interface_property f2sdram_term_axi4_man EXPORT_OF f2sdram_term.axi4_man

	# set values for exposed HDL parameters

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="f2h_term">
  <datum __value="_sortIndex" value="1" type="int" />
 </element>
 <element __value="f2sdram_term">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
</bonusData>
}
	set_module_property FILE {no_periph.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {no_periph}

	# save the system
	sync_sysinfo_parameters
	save_system no_periph
}
