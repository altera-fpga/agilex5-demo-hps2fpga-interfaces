#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_hps_jamb {} {
	# create the system
	create_system hps_jamb
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED065BB32AE5SR0}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component clock_bridge ip/hps_jamb/clock_bridge.ip altera_clock_bridge clock_bridge 19.2.0
	load_component clock_bridge
	set_component_parameter_value EXPLICIT_CLOCK_RATE {0.0}
	set_component_parameter_value NUM_CLOCK_OUTPUTS {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation clock_bridge
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
	add_component f2h_term_256 ip/no_pins_pd_top/f2h_term_256.ip f2h_terminator_256 f2h_term_256 1.0
	load_component f2h_term_256
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation f2h_term_256
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
	add_component f2sdram_adapt_64 ip/no_pins_pd_top/f2sdram_adapt_64.ip f2sdram_adapter_64 f2sdram_adapt_64 1.0
	load_component f2sdram_adapt_64
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation f2sdram_adapt_64
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
	add_instantiation_interface axi4_sub axi4 INPUT
	set_instantiation_interface_parameter_value axi4_sub addressCheck {false}
	set_instantiation_interface_parameter_value axi4_sub associatedClock {clock}
	set_instantiation_interface_parameter_value axi4_sub associatedReset {reset}
	set_instantiation_interface_parameter_value axi4_sub bridgesToMaster {}
	set_instantiation_interface_parameter_value axi4_sub combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi4_sub dataCheck {false}
	set_instantiation_interface_parameter_value axi4_sub dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value axi4_sub dfhFeatureId {35}
	set_instantiation_interface_parameter_value axi4_sub dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value axi4_sub dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value axi4_sub dfhFeatureType {3}
	set_instantiation_interface_parameter_value axi4_sub dfhGroupId {0}
	set_instantiation_interface_parameter_value axi4_sub dfhParameterData {}
	set_instantiation_interface_parameter_value axi4_sub dfhParameterDataLength {}
	set_instantiation_interface_parameter_value axi4_sub dfhParameterId {}
	set_instantiation_interface_parameter_value axi4_sub dfhParameterName {}
	set_instantiation_interface_parameter_value axi4_sub dfhParameterVersion {}
	set_instantiation_interface_parameter_value axi4_sub maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value axi4_sub maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value axi4_sub maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value axi4_sub poison {false}
	set_instantiation_interface_parameter_value axi4_sub readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi4_sub readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value axi4_sub securityAttribute {false}
	set_instantiation_interface_parameter_value axi4_sub traceSignals {false}
	set_instantiation_interface_parameter_value axi4_sub trustzoneAware {true}
	set_instantiation_interface_parameter_value axi4_sub uniqueIdSupport {false}
	set_instantiation_interface_parameter_value axi4_sub userData {false}
	set_instantiation_interface_parameter_value axi4_sub wakeupSignals {false}
	set_instantiation_interface_parameter_value axi4_sub writeAcceptanceCapability {1}
	set_instantiation_interface_sysinfo_parameter_value axi4_sub address_map {<address-map><slave name='axi4_sub' start='0x0' end='0x100000000' datawidth='64' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value axi4_sub address_width {32}
	set_instantiation_interface_sysinfo_parameter_value axi4_sub max_slave_data_width {64}
	add_instantiation_interface_port axi4_sub sub_araddr araddr 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_arcache arcache 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_arid arid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_arlock arlock 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_sub sub_arprot arprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_arqos arqos 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_sub sub_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_sub sub_awaddr awaddr 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_awcache awcache 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_awid awid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_awlock awlock 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_sub sub_awprot awprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_awqos awqos 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_sub sub_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_sub sub_bid bid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_sub sub_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_sub sub_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_sub sub_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_sub sub_rdata rdata 64 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_sub sub_rid rid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_sub sub_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_sub sub_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_sub sub_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_sub sub_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_sub sub_wdata wdata 64 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_sub sub_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_sub sub_wstrb wstrb 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_sub sub_aruser aruser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_awuser awuser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_wuser wuser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_buser buser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_sub sub_arregion arregion 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_sub sub_ruser ruser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_sub sub_awregion awregion 4 STD_LOGIC_VECTOR Input
	save_instantiation
	add_component f2sdram_jamb ip/no_pins_pd_top/f2sdram_jamb.ip altera_jtag_avalon_master f2sdram_jamb 19.1
	load_component f2sdram_jamb
	set_component_parameter_value FAST_VER {0}
	set_component_parameter_value FIFO_DEPTHS {2}
	set_component_parameter_value PLI_PORT {50000}
	set_component_parameter_value USE_PLI {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation f2sdram_jamb
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value debug.hostConnection {type jtag id 110:132}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk_clk clk 1 STD_LOGIC Input
	add_instantiation_interface clk_reset reset INPUT
	set_instantiation_interface_parameter_value clk_reset associatedClock {}
	set_instantiation_interface_parameter_value clk_reset synchronousEdges {NONE}
	add_instantiation_interface_port clk_reset clk_reset_reset reset 1 STD_LOGIC Input
	add_instantiation_interface master_reset reset OUTPUT
	set_instantiation_interface_parameter_value master_reset associatedClock {}
	set_instantiation_interface_parameter_value master_reset associatedDirectReset {}
	set_instantiation_interface_parameter_value master_reset associatedResetSinks {none}
	set_instantiation_interface_parameter_value master_reset synchronousEdges {NONE}
	add_instantiation_interface_port master_reset master_reset_reset reset 1 STD_LOGIC Output
	add_instantiation_interface master avalon OUTPUT
	set_instantiation_interface_parameter_value master adaptsTo {}
	set_instantiation_interface_parameter_value master addressGroup {0}
	set_instantiation_interface_parameter_value master addressUnits {SYMBOLS}
	set_instantiation_interface_parameter_value master alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value master associatedClock {clk}
	set_instantiation_interface_parameter_value master associatedReset {clk_reset}
	set_instantiation_interface_parameter_value master bitsPerSymbol {8}
	set_instantiation_interface_parameter_value master burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value master burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value master constantBurstBehavior {false}
	set_instantiation_interface_parameter_value master dBSBigEndian {false}
	set_instantiation_interface_parameter_value master doStreamReads {false}
	set_instantiation_interface_parameter_value master doStreamWrites {false}
	set_instantiation_interface_parameter_value master holdTime {0}
	set_instantiation_interface_parameter_value master interleaveBursts {false}
	set_instantiation_interface_parameter_value master isAsynchronous {false}
	set_instantiation_interface_parameter_value master isBigEndian {false}
	set_instantiation_interface_parameter_value master isReadable {false}
	set_instantiation_interface_parameter_value master isWriteable {false}
	set_instantiation_interface_parameter_value master linewrapBursts {false}
	set_instantiation_interface_parameter_value master maxAddressWidth {32}
	set_instantiation_interface_parameter_value master maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value master maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value master minimumReadLatency {1}
	set_instantiation_interface_parameter_value master minimumResponseLatency {1}
	set_instantiation_interface_parameter_value master prSafe {false}
	set_instantiation_interface_parameter_value master readLatency {0}
	set_instantiation_interface_parameter_value master readWaitTime {1}
	set_instantiation_interface_parameter_value master registerIncomingSignals {false}
	set_instantiation_interface_parameter_value master registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value master setupTime {0}
	set_instantiation_interface_parameter_value master timingUnits {Cycles}
	set_instantiation_interface_parameter_value master waitrequestAllowance {0}
	set_instantiation_interface_parameter_value master waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value master writeWaitTime {0}
	set_instantiation_interface_assignment_value master debug.controlledBy {in_stream}
	set_instantiation_interface_assignment_value master debug.providesServices {master}
	set_instantiation_interface_assignment_value master debug.typeName {altera_jtag_avalon_master.master}
	set_instantiation_interface_assignment_value master debug.visible {true}
	add_instantiation_interface_port master master_address address 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port master master_readdata readdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port master master_read read 1 STD_LOGIC Output
	add_instantiation_interface_port master master_write write 1 STD_LOGIC Output
	add_instantiation_interface_port master master_writedata writedata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port master master_waitrequest waitrequest 1 STD_LOGIC Input
	add_instantiation_interface_port master master_readdatavalid readdatavalid 1 STD_LOGIC Input
	add_instantiation_interface_port master master_byteenable byteenable 4 STD_LOGIC_VECTOR Output
	save_instantiation
	add_component hps_gp_in_const ip/no_pins_pd_top/hps_gp_in_const.ip hps_gp_in_constant hps_gp_in_const 1.0
	load_component hps_gp_in_const
	set_component_parameter_value GPIN_CONSTANT {1112359242}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation hps_gp_in_const
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
	add_component reset_bridge ip/hps_jamb/reset_bridge.ip altera_reset_bridge reset_bridge 19.2.0
	load_component reset_bridge
	set_component_parameter_value ACTIVE_LOW_RESET {0}
	set_component_parameter_value NUM_RESET_OUTPUTS {1}
	set_component_parameter_value SYNCHRONOUS_EDGES {none}
	set_component_parameter_value SYNC_RESET {0}
	set_component_parameter_value USE_RESET_REQUEST {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation reset_bridge
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface in_reset reset INPUT
	set_instantiation_interface_parameter_value in_reset associatedClock {}
	set_instantiation_interface_parameter_value in_reset synchronousEdges {NONE}
	add_instantiation_interface_port in_reset in_reset reset 1 STD_LOGIC Input
	add_instantiation_interface out_reset reset OUTPUT
	set_instantiation_interface_parameter_value out_reset associatedClock {}
	set_instantiation_interface_parameter_value out_reset associatedDirectReset {in_reset}
	set_instantiation_interface_parameter_value out_reset associatedResetSinks {in_reset}
	set_instantiation_interface_parameter_value out_reset synchronousEdges {NONE}
	add_instantiation_interface_port out_reset out_reset reset 1 STD_LOGIC Output
	save_instantiation

	# add wirelevel expressions

	# preserve ports for debug

	# add the connections
	add_connection clock_bridge.out_clk/f2sdram_adapt_64.clock
	set_connection_parameter_value clock_bridge.out_clk/f2sdram_adapt_64.clock clockDomainSysInfo {-1}
	set_connection_parameter_value clock_bridge.out_clk/f2sdram_adapt_64.clock clockRateSysInfo {}
	set_connection_parameter_value clock_bridge.out_clk/f2sdram_adapt_64.clock clockResetSysInfo {}
	set_connection_parameter_value clock_bridge.out_clk/f2sdram_adapt_64.clock resetDomainSysInfo {-1}
	add_connection clock_bridge.out_clk/f2sdram_jamb.clk
	set_connection_parameter_value clock_bridge.out_clk/f2sdram_jamb.clk clockDomainSysInfo {-1}
	set_connection_parameter_value clock_bridge.out_clk/f2sdram_jamb.clk clockRateSysInfo {}
	set_connection_parameter_value clock_bridge.out_clk/f2sdram_jamb.clk clockResetSysInfo {}
	set_connection_parameter_value clock_bridge.out_clk/f2sdram_jamb.clk resetDomainSysInfo {-1}
	add_connection f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub addressMapSysInfo {}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub addressWidthSysInfo {}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub arbitrationPriority {1}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub baseAddress {0x0000}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub defaultConnection {0}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub domainAlias {}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_jamb.master/f2sdram_adapt_64.axi4_sub slaveDataWidthSysInfo {-1}
	add_connection hps_gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in
	set_connection_parameter_value hps_gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in endPort {}
	set_connection_parameter_value hps_gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in endPortLSB {0}
	set_connection_parameter_value hps_gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in startPort {}
	set_connection_parameter_value hps_gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in startPortLSB {0}
	set_connection_parameter_value hps_gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in width {0}
	add_connection reset_bridge.out_reset/f2sdram_adapt_64.reset
	set_connection_parameter_value reset_bridge.out_reset/f2sdram_adapt_64.reset clockDomainSysInfo {-1}
	set_connection_parameter_value reset_bridge.out_reset/f2sdram_adapt_64.reset clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/f2sdram_adapt_64.reset resetDomainSysInfo {-1}
	add_connection reset_bridge.out_reset/f2sdram_jamb.clk_reset
	set_connection_parameter_value reset_bridge.out_reset/f2sdram_jamb.clk_reset clockDomainSysInfo {-1}
	set_connection_parameter_value reset_bridge.out_reset/f2sdram_jamb.clk_reset clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/f2sdram_jamb.clk_reset resetDomainSysInfo {-1}

	# add the exports
	set_interface_property clock_bridge_in_clk EXPORT_OF clock_bridge.in_clk
	set_interface_property f2h_term_256_clock EXPORT_OF f2h_term_256.clock
	set_interface_property f2h_term_256_reset EXPORT_OF f2h_term_256.reset
	set_interface_property f2h_term_256_acelite_manager EXPORT_OF f2h_term_256.acelite_manager
	set_interface_property f2sdram_adapt_64_axi4_man EXPORT_OF f2sdram_adapt_64.axi4_man
	set_interface_property f2sdram_jamb_master_reset EXPORT_OF f2sdram_jamb.master_reset
	set_interface_property hps_gp_split_hps_gp EXPORT_OF hps_gp_split.hps_gp
	set_interface_property hps_gp_split_hps_gp_out EXPORT_OF hps_gp_split.hps_gp_out
	set_interface_property reset_bridge_in_reset EXPORT_OF reset_bridge.in_reset

	# set values for exposed HDL parameters
	set_domain_assignment f2sdram_jamb.master qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment f2sdram_jamb.master qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment f2sdram_jamb.master qsys_mm.enableAllPipelines FALSE
	set_domain_assignment f2sdram_jamb.master qsys_mm.enableEccProtection FALSE
	set_domain_assignment f2sdram_jamb.master qsys_mm.enableInstrumentation FALSE
	set_domain_assignment f2sdram_jamb.master qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment f2sdram_jamb.master qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment f2sdram_jamb.master qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment f2sdram_jamb.master qsys_mm.interconnectType STANDARD
	set_domain_assignment f2sdram_jamb.master qsys_mm.maxAdditionalLatency 1
	set_domain_assignment f2sdram_jamb.master qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment f2sdram_jamb.master qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment f2sdram_jamb.master qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment f2sdram_jamb.master qsys_mm.syncResets TRUE
	set_domain_assignment f2sdram_jamb.master qsys_mm.widthAdapterImplementation GENERIC_CONVERTER

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="clock_bridge">
  <datum __value="_sortIndex" value="6" type="int" />
 </element>
 <element __value="f2h_term_256">
  <datum __value="_sortIndex" value="2" type="int" />
 </element>
 <element __value="f2sdram_adapt_64">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
 <element __value="f2sdram_jamb">
  <datum __value="_sortIndex" value="1" type="int" />
 </element>
 <element __value="hps_gp_in_const">
  <datum __value="_sortIndex" value="4" type="int" />
 </element>
 <element __value="hps_gp_split">
  <datum __value="_sortIndex" value="3" type="int" />
 </element>
 <element __value="reset_bridge">
  <datum __value="_sortIndex" value="5" type="int" />
 </element>
</bonusData>
}
	set_module_property FILE {hps_jamb.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {hps_jamb}

	# save the system
	sync_sysinfo_parameters
	save_system hps_jamb
}
