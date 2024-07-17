#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_h2f_bridge {} {
	# create the system
	create_system h2f_bridge
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED065BB32AE5SR0}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component def_sub ip/no_pins_pd_top/def_sub.ip default_subordinate def_sub 1.0
	load_component def_sub
	set_component_parameter_value ALLOW_ARREADY {1}
	set_component_parameter_value ALLOW_AWREADY {1}
	set_component_parameter_value ALLOW_BVALID {1}
	set_component_parameter_value ALLOW_RVALID {1}
	set_component_parameter_value DEFAULT_BRESP {3}
	set_component_parameter_value DEFAULT_RDATA {4207856382}
	set_component_parameter_value DEFAULT_RRESP {3}
	set_component_parameter_value USE_ANY_VALID_COND {0}
	set_component_parameter_value USE_ANY_VALID_IRQ {0}
	set_component_parameter_value USE_ANY_VALID_RESET {0}
	set_component_parameter_value USE_ARVALID_COND {0}
	set_component_parameter_value USE_ARVALID_IRQ {0}
	set_component_parameter_value USE_ARVALID_RESET {0}
	set_component_parameter_value USE_AWVALID_COND {0}
	set_component_parameter_value USE_AWVALID_IRQ {0}
	set_component_parameter_value USE_AWVALID_RESET {0}
	set_component_parameter_value USE_WVALID_COND {0}
	set_component_parameter_value USE_WVALID_IRQ {0}
	set_component_parameter_value USE_WVALID_RESET {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation def_sub
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
	add_instantiation_interface default_sub axi4lite INPUT
	set_instantiation_interface_parameter_value default_sub addressCheck {false}
	set_instantiation_interface_parameter_value default_sub associatedClock {clock}
	set_instantiation_interface_parameter_value default_sub associatedReset {reset}
	set_instantiation_interface_parameter_value default_sub bridgesToMaster {}
	set_instantiation_interface_parameter_value default_sub combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value default_sub dataCheck {false}
	set_instantiation_interface_parameter_value default_sub dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value default_sub dfhFeatureId {35}
	set_instantiation_interface_parameter_value default_sub dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value default_sub dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value default_sub dfhFeatureType {3}
	set_instantiation_interface_parameter_value default_sub dfhGroupId {0}
	set_instantiation_interface_parameter_value default_sub dfhParameterData {}
	set_instantiation_interface_parameter_value default_sub dfhParameterDataLength {}
	set_instantiation_interface_parameter_value default_sub dfhParameterId {}
	set_instantiation_interface_parameter_value default_sub dfhParameterName {}
	set_instantiation_interface_parameter_value default_sub dfhParameterVersion {}
	set_instantiation_interface_parameter_value default_sub maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value default_sub maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value default_sub maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value default_sub poison {false}
	set_instantiation_interface_parameter_value default_sub readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value default_sub readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value default_sub securityAttribute {false}
	set_instantiation_interface_parameter_value default_sub traceSignals {false}
	set_instantiation_interface_parameter_value default_sub trustzoneAware {true}
	set_instantiation_interface_parameter_value default_sub uniqueIdSupport {false}
	set_instantiation_interface_parameter_value default_sub userData {false}
	set_instantiation_interface_parameter_value default_sub wakeupSignals {false}
	set_instantiation_interface_parameter_value default_sub writeAcceptanceCapability {1}
	add_instantiation_interface_port default_sub default_sub_araddr araddr 12 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port default_sub default_sub_arprot arprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port default_sub default_sub_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port default_sub default_sub_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port default_sub default_sub_awaddr awaddr 12 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port default_sub default_sub_awprot awprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port default_sub default_sub_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port default_sub default_sub_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port default_sub default_sub_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port default_sub default_sub_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port default_sub default_sub_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port default_sub default_sub_rdata rdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port default_sub default_sub_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port default_sub default_sub_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port default_sub default_sub_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port default_sub default_sub_wdata wdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port default_sub default_sub_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port default_sub default_sub_wstrb wstrb 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port default_sub default_sub_wvalid wvalid 1 STD_LOGIC Input
	save_instantiation
	add_component gp_in_const ip/no_pins_pd_top/gp_in_const.ip hps_gp_in_constant gp_in_const 1.0
	load_component gp_in_const
	set_component_parameter_value GPIN_CONSTANT {541471304}
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
	add_component ocram_2k_00 ip/no_pins_pd_top/ocram_2k_00.ip intel_onchip_memory ocram_2k_00 1.4.8
	load_component ocram_2k_00
	set_component_parameter_value AXI_interface {1}
	set_component_parameter_value allowInSystemMemoryContentEditor {0}
	set_component_parameter_value blockType {AUTO}
	set_component_parameter_value clockEnable {0}
	set_component_parameter_value copyInitFile {0}
	set_component_parameter_value dataWidth {32}
	set_component_parameter_value dataWidth2 {32}
	set_component_parameter_value dualPort {0}
	set_component_parameter_value ecc_check {0}
	set_component_parameter_value ecc_encoder_bypass {0}
	set_component_parameter_value ecc_pipeline_reg {0}
	set_component_parameter_value enPRInitMode {0}
	set_component_parameter_value enableDiffWidth {0}
	set_component_parameter_value gui_debugaccess {0}
	set_component_parameter_value idWidth {4}
	set_component_parameter_value initMemContent {1}
	set_component_parameter_value initializationFileName {onchip_mem.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {1}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {2048.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation ocram_2k_00
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {ocram_2k_00_ocram_2k_00}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {2048}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {ocram_2k_00_ocram_2k_00}
	set_instantiation_assignment_value postgeneration.simulation.init_file.param_name {INIT_FILE}
	set_instantiation_assignment_value postgeneration.simulation.init_file.type {MEM_INIT}
	add_instantiation_interface clk1 clock INPUT
	set_instantiation_interface_parameter_value clk1 clockRate {0}
	set_instantiation_interface_parameter_value clk1 externallyDriven {false}
	set_instantiation_interface_parameter_value clk1 ptfSchematicName {}
	add_instantiation_interface_port clk1 clk clk 1 STD_LOGIC Input
	add_instantiation_interface axi_s1 axi4 INPUT
	set_instantiation_interface_parameter_value axi_s1 addressCheck {false}
	set_instantiation_interface_parameter_value axi_s1 associatedClock {clk1}
	set_instantiation_interface_parameter_value axi_s1 associatedReset {reset1}
	set_instantiation_interface_parameter_value axi_s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value axi_s1 combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 dataCheck {false}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value axi_s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterData {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterId {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterName {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value axi_s1 poison {false}
	set_instantiation_interface_parameter_value axi_s1 readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value axi_s1 securityAttribute {false}
	set_instantiation_interface_parameter_value axi_s1 traceSignals {false}
	set_instantiation_interface_parameter_value axi_s1 trustzoneAware {true}
	set_instantiation_interface_parameter_value axi_s1 uniqueIdSupport {false}
	set_instantiation_interface_parameter_value axi_s1 userData {false}
	set_instantiation_interface_parameter_value axi_s1 wakeupSignals {false}
	set_instantiation_interface_parameter_value axi_s1 writeAcceptanceCapability {1}
	set_instantiation_interface_assignment_value axi_s1 embeddedsw.configuration.isMemoryDevice {1}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_map {<address-map><slave name='axi_s1' start='0x0' end='0x800' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_width {11}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 max_slave_data_width {32}
	add_instantiation_interface_port axi_s1 s1_arid arid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_araddr araddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_awid awid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awaddr awaddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rid rid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rdata rdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_wdata wdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wstrb wstrb 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bid bid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
	save_instantiation
	add_component ocram_2k_01 ip/no_pins_pd_top/ocram_2k_01.ip intel_onchip_memory ocram_2k_01 1.4.8
	load_component ocram_2k_01
	set_component_parameter_value AXI_interface {1}
	set_component_parameter_value allowInSystemMemoryContentEditor {0}
	set_component_parameter_value blockType {AUTO}
	set_component_parameter_value clockEnable {0}
	set_component_parameter_value copyInitFile {0}
	set_component_parameter_value dataWidth {32}
	set_component_parameter_value dataWidth2 {32}
	set_component_parameter_value dualPort {0}
	set_component_parameter_value ecc_check {0}
	set_component_parameter_value ecc_encoder_bypass {0}
	set_component_parameter_value ecc_pipeline_reg {0}
	set_component_parameter_value enPRInitMode {0}
	set_component_parameter_value enableDiffWidth {0}
	set_component_parameter_value gui_debugaccess {0}
	set_component_parameter_value idWidth {4}
	set_component_parameter_value initMemContent {1}
	set_component_parameter_value initializationFileName {onchip_mem.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {1}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {2048.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation ocram_2k_01
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {ocram_2k_01_ocram_2k_01}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {2048}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {ocram_2k_01_ocram_2k_01}
	set_instantiation_assignment_value postgeneration.simulation.init_file.param_name {INIT_FILE}
	set_instantiation_assignment_value postgeneration.simulation.init_file.type {MEM_INIT}
	add_instantiation_interface clk1 clock INPUT
	set_instantiation_interface_parameter_value clk1 clockRate {0}
	set_instantiation_interface_parameter_value clk1 externallyDriven {false}
	set_instantiation_interface_parameter_value clk1 ptfSchematicName {}
	add_instantiation_interface_port clk1 clk clk 1 STD_LOGIC Input
	add_instantiation_interface axi_s1 axi4 INPUT
	set_instantiation_interface_parameter_value axi_s1 addressCheck {false}
	set_instantiation_interface_parameter_value axi_s1 associatedClock {clk1}
	set_instantiation_interface_parameter_value axi_s1 associatedReset {reset1}
	set_instantiation_interface_parameter_value axi_s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value axi_s1 combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 dataCheck {false}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value axi_s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterData {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterId {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterName {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value axi_s1 poison {false}
	set_instantiation_interface_parameter_value axi_s1 readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value axi_s1 securityAttribute {false}
	set_instantiation_interface_parameter_value axi_s1 traceSignals {false}
	set_instantiation_interface_parameter_value axi_s1 trustzoneAware {true}
	set_instantiation_interface_parameter_value axi_s1 uniqueIdSupport {false}
	set_instantiation_interface_parameter_value axi_s1 userData {false}
	set_instantiation_interface_parameter_value axi_s1 wakeupSignals {false}
	set_instantiation_interface_parameter_value axi_s1 writeAcceptanceCapability {1}
	set_instantiation_interface_assignment_value axi_s1 embeddedsw.configuration.isMemoryDevice {1}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_map {<address-map><slave name='axi_s1' start='0x0' end='0x800' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_width {11}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 max_slave_data_width {32}
	add_instantiation_interface_port axi_s1 s1_arid arid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_araddr araddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_awid awid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awaddr awaddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rid rid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rdata rdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_wdata wdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wstrb wstrb 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bid bid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
	save_instantiation
	add_component ocram_2k_10 ip/no_pins_pd_top/ocram_2k_10.ip intel_onchip_memory ocram_2k_10 1.4.8
	load_component ocram_2k_10
	set_component_parameter_value AXI_interface {1}
	set_component_parameter_value allowInSystemMemoryContentEditor {0}
	set_component_parameter_value blockType {AUTO}
	set_component_parameter_value clockEnable {0}
	set_component_parameter_value copyInitFile {0}
	set_component_parameter_value dataWidth {32}
	set_component_parameter_value dataWidth2 {32}
	set_component_parameter_value dualPort {0}
	set_component_parameter_value ecc_check {0}
	set_component_parameter_value ecc_encoder_bypass {0}
	set_component_parameter_value ecc_pipeline_reg {0}
	set_component_parameter_value enPRInitMode {0}
	set_component_parameter_value enableDiffWidth {0}
	set_component_parameter_value gui_debugaccess {0}
	set_component_parameter_value idWidth {4}
	set_component_parameter_value initMemContent {1}
	set_component_parameter_value initializationFileName {onchip_mem.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {1}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {2048.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation ocram_2k_10
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {ocram_2k_10_ocram_2k_10}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {2048}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {ocram_2k_10_ocram_2k_10}
	set_instantiation_assignment_value postgeneration.simulation.init_file.param_name {INIT_FILE}
	set_instantiation_assignment_value postgeneration.simulation.init_file.type {MEM_INIT}
	add_instantiation_interface clk1 clock INPUT
	set_instantiation_interface_parameter_value clk1 clockRate {0}
	set_instantiation_interface_parameter_value clk1 externallyDriven {false}
	set_instantiation_interface_parameter_value clk1 ptfSchematicName {}
	add_instantiation_interface_port clk1 clk clk 1 STD_LOGIC Input
	add_instantiation_interface axi_s1 axi4 INPUT
	set_instantiation_interface_parameter_value axi_s1 addressCheck {false}
	set_instantiation_interface_parameter_value axi_s1 associatedClock {clk1}
	set_instantiation_interface_parameter_value axi_s1 associatedReset {reset1}
	set_instantiation_interface_parameter_value axi_s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value axi_s1 combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 dataCheck {false}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value axi_s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterData {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterId {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterName {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value axi_s1 poison {false}
	set_instantiation_interface_parameter_value axi_s1 readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value axi_s1 securityAttribute {false}
	set_instantiation_interface_parameter_value axi_s1 traceSignals {false}
	set_instantiation_interface_parameter_value axi_s1 trustzoneAware {true}
	set_instantiation_interface_parameter_value axi_s1 uniqueIdSupport {false}
	set_instantiation_interface_parameter_value axi_s1 userData {false}
	set_instantiation_interface_parameter_value axi_s1 wakeupSignals {false}
	set_instantiation_interface_parameter_value axi_s1 writeAcceptanceCapability {1}
	set_instantiation_interface_assignment_value axi_s1 embeddedsw.configuration.isMemoryDevice {1}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_map {<address-map><slave name='axi_s1' start='0x0' end='0x800' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_width {11}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 max_slave_data_width {32}
	add_instantiation_interface_port axi_s1 s1_arid arid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_araddr araddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_awid awid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awaddr awaddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rid rid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rdata rdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_wdata wdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wstrb wstrb 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bid bid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
	save_instantiation
	add_component ocram_2k_11 ip/no_pins_pd_top/ocram_2k_11.ip intel_onchip_memory ocram_2k_11 1.4.8
	load_component ocram_2k_11
	set_component_parameter_value AXI_interface {1}
	set_component_parameter_value allowInSystemMemoryContentEditor {0}
	set_component_parameter_value blockType {AUTO}
	set_component_parameter_value clockEnable {0}
	set_component_parameter_value copyInitFile {0}
	set_component_parameter_value dataWidth {32}
	set_component_parameter_value dataWidth2 {32}
	set_component_parameter_value dualPort {0}
	set_component_parameter_value ecc_check {0}
	set_component_parameter_value ecc_encoder_bypass {0}
	set_component_parameter_value ecc_pipeline_reg {0}
	set_component_parameter_value enPRInitMode {0}
	set_component_parameter_value enableDiffWidth {0}
	set_component_parameter_value gui_debugaccess {0}
	set_component_parameter_value idWidth {4}
	set_component_parameter_value initMemContent {1}
	set_component_parameter_value initializationFileName {onchip_mem.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {1}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {2048.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation ocram_2k_11
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {ocram_2k_11_ocram_2k_11}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {2048}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {ocram_2k_11_ocram_2k_11}
	set_instantiation_assignment_value postgeneration.simulation.init_file.param_name {INIT_FILE}
	set_instantiation_assignment_value postgeneration.simulation.init_file.type {MEM_INIT}
	add_instantiation_interface clk1 clock INPUT
	set_instantiation_interface_parameter_value clk1 clockRate {0}
	set_instantiation_interface_parameter_value clk1 externallyDriven {false}
	set_instantiation_interface_parameter_value clk1 ptfSchematicName {}
	add_instantiation_interface_port clk1 clk clk 1 STD_LOGIC Input
	add_instantiation_interface axi_s1 axi4 INPUT
	set_instantiation_interface_parameter_value axi_s1 addressCheck {false}
	set_instantiation_interface_parameter_value axi_s1 associatedClock {clk1}
	set_instantiation_interface_parameter_value axi_s1 associatedReset {reset1}
	set_instantiation_interface_parameter_value axi_s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value axi_s1 combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 dataCheck {false}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value axi_s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterData {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterId {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterName {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value axi_s1 poison {false}
	set_instantiation_interface_parameter_value axi_s1 readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value axi_s1 securityAttribute {false}
	set_instantiation_interface_parameter_value axi_s1 traceSignals {false}
	set_instantiation_interface_parameter_value axi_s1 trustzoneAware {true}
	set_instantiation_interface_parameter_value axi_s1 uniqueIdSupport {false}
	set_instantiation_interface_parameter_value axi_s1 userData {false}
	set_instantiation_interface_parameter_value axi_s1 wakeupSignals {false}
	set_instantiation_interface_parameter_value axi_s1 writeAcceptanceCapability {1}
	set_instantiation_interface_assignment_value axi_s1 embeddedsw.configuration.isMemoryDevice {1}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_map {<address-map><slave name='axi_s1' start='0x0' end='0x800' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_width {11}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 max_slave_data_width {32}
	add_instantiation_interface_port axi_s1 s1_arid arid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_araddr araddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_awid awid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awaddr awaddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rid rid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rdata rdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_wdata wdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wstrb wstrb 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bid bid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
	save_instantiation
	add_component ocram_2k_20 ip/no_pins_pd_top/ocram_2k_20.ip intel_onchip_memory ocram_2k_20 1.4.8
	load_component ocram_2k_20
	set_component_parameter_value AXI_interface {1}
	set_component_parameter_value allowInSystemMemoryContentEditor {0}
	set_component_parameter_value blockType {AUTO}
	set_component_parameter_value clockEnable {0}
	set_component_parameter_value copyInitFile {0}
	set_component_parameter_value dataWidth {32}
	set_component_parameter_value dataWidth2 {32}
	set_component_parameter_value dualPort {0}
	set_component_parameter_value ecc_check {0}
	set_component_parameter_value ecc_encoder_bypass {0}
	set_component_parameter_value ecc_pipeline_reg {0}
	set_component_parameter_value enPRInitMode {0}
	set_component_parameter_value enableDiffWidth {0}
	set_component_parameter_value gui_debugaccess {0}
	set_component_parameter_value idWidth {4}
	set_component_parameter_value initMemContent {1}
	set_component_parameter_value initializationFileName {onchip_mem.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {1}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {2048.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation ocram_2k_20
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {ocram_2k_20_ocram_2k_20}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {2048}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {ocram_2k_20_ocram_2k_20}
	set_instantiation_assignment_value postgeneration.simulation.init_file.param_name {INIT_FILE}
	set_instantiation_assignment_value postgeneration.simulation.init_file.type {MEM_INIT}
	add_instantiation_interface clk1 clock INPUT
	set_instantiation_interface_parameter_value clk1 clockRate {0}
	set_instantiation_interface_parameter_value clk1 externallyDriven {false}
	set_instantiation_interface_parameter_value clk1 ptfSchematicName {}
	add_instantiation_interface_port clk1 clk clk 1 STD_LOGIC Input
	add_instantiation_interface axi_s1 axi4 INPUT
	set_instantiation_interface_parameter_value axi_s1 addressCheck {false}
	set_instantiation_interface_parameter_value axi_s1 associatedClock {clk1}
	set_instantiation_interface_parameter_value axi_s1 associatedReset {reset1}
	set_instantiation_interface_parameter_value axi_s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value axi_s1 combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 dataCheck {false}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value axi_s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterData {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterId {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterName {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value axi_s1 poison {false}
	set_instantiation_interface_parameter_value axi_s1 readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value axi_s1 securityAttribute {false}
	set_instantiation_interface_parameter_value axi_s1 traceSignals {false}
	set_instantiation_interface_parameter_value axi_s1 trustzoneAware {true}
	set_instantiation_interface_parameter_value axi_s1 uniqueIdSupport {false}
	set_instantiation_interface_parameter_value axi_s1 userData {false}
	set_instantiation_interface_parameter_value axi_s1 wakeupSignals {false}
	set_instantiation_interface_parameter_value axi_s1 writeAcceptanceCapability {1}
	set_instantiation_interface_assignment_value axi_s1 embeddedsw.configuration.isMemoryDevice {1}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_map {<address-map><slave name='axi_s1' start='0x0' end='0x800' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_width {11}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 max_slave_data_width {32}
	add_instantiation_interface_port axi_s1 s1_arid arid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_araddr araddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_awid awid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awaddr awaddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rid rid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rdata rdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_wdata wdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wstrb wstrb 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bid bid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
	save_instantiation
	add_component ocram_2k_21 ip/no_pins_pd_top/ocram_2k_21.ip intel_onchip_memory ocram_2k_21 1.4.8
	load_component ocram_2k_21
	set_component_parameter_value AXI_interface {1}
	set_component_parameter_value allowInSystemMemoryContentEditor {0}
	set_component_parameter_value blockType {AUTO}
	set_component_parameter_value clockEnable {0}
	set_component_parameter_value copyInitFile {0}
	set_component_parameter_value dataWidth {32}
	set_component_parameter_value dataWidth2 {32}
	set_component_parameter_value dualPort {0}
	set_component_parameter_value ecc_check {0}
	set_component_parameter_value ecc_encoder_bypass {0}
	set_component_parameter_value ecc_pipeline_reg {0}
	set_component_parameter_value enPRInitMode {0}
	set_component_parameter_value enableDiffWidth {0}
	set_component_parameter_value gui_debugaccess {0}
	set_component_parameter_value idWidth {4}
	set_component_parameter_value initMemContent {1}
	set_component_parameter_value initializationFileName {onchip_mem.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {1}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {2048.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation ocram_2k_21
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {ocram_2k_21_ocram_2k_21}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {2048}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {ocram_2k_21_ocram_2k_21}
	set_instantiation_assignment_value postgeneration.simulation.init_file.param_name {INIT_FILE}
	set_instantiation_assignment_value postgeneration.simulation.init_file.type {MEM_INIT}
	add_instantiation_interface clk1 clock INPUT
	set_instantiation_interface_parameter_value clk1 clockRate {0}
	set_instantiation_interface_parameter_value clk1 externallyDriven {false}
	set_instantiation_interface_parameter_value clk1 ptfSchematicName {}
	add_instantiation_interface_port clk1 clk clk 1 STD_LOGIC Input
	add_instantiation_interface axi_s1 axi4 INPUT
	set_instantiation_interface_parameter_value axi_s1 addressCheck {false}
	set_instantiation_interface_parameter_value axi_s1 associatedClock {clk1}
	set_instantiation_interface_parameter_value axi_s1 associatedReset {reset1}
	set_instantiation_interface_parameter_value axi_s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value axi_s1 combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 dataCheck {false}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value axi_s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value axi_s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterData {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterId {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterName {}
	set_instantiation_interface_parameter_value axi_s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value axi_s1 maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value axi_s1 poison {false}
	set_instantiation_interface_parameter_value axi_s1 readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi_s1 readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value axi_s1 securityAttribute {false}
	set_instantiation_interface_parameter_value axi_s1 traceSignals {false}
	set_instantiation_interface_parameter_value axi_s1 trustzoneAware {true}
	set_instantiation_interface_parameter_value axi_s1 uniqueIdSupport {false}
	set_instantiation_interface_parameter_value axi_s1 userData {false}
	set_instantiation_interface_parameter_value axi_s1 wakeupSignals {false}
	set_instantiation_interface_parameter_value axi_s1 writeAcceptanceCapability {1}
	set_instantiation_interface_assignment_value axi_s1 embeddedsw.configuration.isMemoryDevice {1}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_map {<address-map><slave name='axi_s1' start='0x0' end='0x800' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_width {11}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 max_slave_data_width {32}
	add_instantiation_interface_port axi_s1 s1_arid arid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_araddr araddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_awid awid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awaddr awaddr 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rid rid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rdata rdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_wdata wdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wstrb wstrb 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bid bid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
	save_instantiation
	add_component sysid ip/no_pins_pd_top/sysid.ip altera_avalon_sysid_qsys sysid 19.1.6
	load_component sysid
	set_component_parameter_value id {541471304}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation sysid
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ID {541471304}
	set_instantiation_assignment_value embeddedsw.CMacro.TIMESTAMP {0}
	set_instantiation_assignment_value embeddedsw.dts.compatible {altr,sysid-1.0}
	set_instantiation_assignment_value embeddedsw.dts.group {sysid}
	set_instantiation_assignment_value embeddedsw.dts.name {sysid}
	set_instantiation_assignment_value embeddedsw.dts.params.id {541471304}
	set_instantiation_assignment_value embeddedsw.dts.params.timestamp {0}
	set_instantiation_assignment_value embeddedsw.dts.vendor {altr}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clock clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clk}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface control_slave avalon INPUT
	set_instantiation_interface_parameter_value control_slave addressAlignment {DYNAMIC}
	set_instantiation_interface_parameter_value control_slave addressGroup {0}
	set_instantiation_interface_parameter_value control_slave addressSpan {8}
	set_instantiation_interface_parameter_value control_slave addressUnits {WORDS}
	set_instantiation_interface_parameter_value control_slave alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value control_slave associatedClock {clk}
	set_instantiation_interface_parameter_value control_slave associatedReset {reset}
	set_instantiation_interface_parameter_value control_slave bitsPerSymbol {8}
	set_instantiation_interface_parameter_value control_slave bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value control_slave bridgesToMaster {}
	set_instantiation_interface_parameter_value control_slave burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value control_slave burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value control_slave constantBurstBehavior {false}
	set_instantiation_interface_parameter_value control_slave dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value control_slave dfhFeatureId {35}
	set_instantiation_interface_parameter_value control_slave dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value control_slave dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value control_slave dfhFeatureType {3}
	set_instantiation_interface_parameter_value control_slave dfhGroupId {0}
	set_instantiation_interface_parameter_value control_slave dfhParameterData {}
	set_instantiation_interface_parameter_value control_slave dfhParameterDataLength {}
	set_instantiation_interface_parameter_value control_slave dfhParameterId {}
	set_instantiation_interface_parameter_value control_slave dfhParameterName {}
	set_instantiation_interface_parameter_value control_slave dfhParameterVersion {}
	set_instantiation_interface_parameter_value control_slave explicitAddressSpan {0}
	set_instantiation_interface_parameter_value control_slave holdTime {0}
	set_instantiation_interface_parameter_value control_slave interleaveBursts {false}
	set_instantiation_interface_parameter_value control_slave isBigEndian {false}
	set_instantiation_interface_parameter_value control_slave isFlash {false}
	set_instantiation_interface_parameter_value control_slave isMemoryDevice {false}
	set_instantiation_interface_parameter_value control_slave isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value control_slave linewrapBursts {false}
	set_instantiation_interface_parameter_value control_slave maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value control_slave maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value control_slave minimumReadLatency {1}
	set_instantiation_interface_parameter_value control_slave minimumResponseLatency {1}
	set_instantiation_interface_parameter_value control_slave minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value control_slave prSafe {false}
	set_instantiation_interface_parameter_value control_slave printableDevice {false}
	set_instantiation_interface_parameter_value control_slave readLatency {0}
	set_instantiation_interface_parameter_value control_slave readWaitStates {1}
	set_instantiation_interface_parameter_value control_slave readWaitTime {1}
	set_instantiation_interface_parameter_value control_slave registerIncomingSignals {false}
	set_instantiation_interface_parameter_value control_slave registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value control_slave setupTime {0}
	set_instantiation_interface_parameter_value control_slave timingUnits {Cycles}
	set_instantiation_interface_parameter_value control_slave transparentBridge {false}
	set_instantiation_interface_parameter_value control_slave waitrequestAllowance {0}
	set_instantiation_interface_parameter_value control_slave waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value control_slave wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value control_slave writeLatency {0}
	set_instantiation_interface_parameter_value control_slave writeWaitStates {0}
	set_instantiation_interface_parameter_value control_slave writeWaitTime {0}
	set_instantiation_interface_assignment_value control_slave embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value control_slave embeddedsw.configuration.isMemoryDevice {0}
	set_instantiation_interface_assignment_value control_slave embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value control_slave embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_sysinfo_parameter_value control_slave address_map {<address-map><slave name='control_slave' start='0x0' end='0x8' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value control_slave address_width {3}
	set_instantiation_interface_sysinfo_parameter_value control_slave max_slave_data_width {32}
	add_instantiation_interface_port control_slave readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port control_slave address address 1 STD_LOGIC Input
	save_instantiation

	# add wirelevel expressions

	# preserve ports for debug

	# add the connections
	add_connection gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in endPort {}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in endPortLSB {0}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in startPort {}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in startPortLSB {0}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in width {0}

	# add the exports
	set_interface_property def_sub_clock EXPORT_OF def_sub.clock
	set_interface_property def_sub_reset EXPORT_OF def_sub.reset
	set_interface_property def_sub_default_sub EXPORT_OF def_sub.default_sub
	set_interface_property hps_gp_split_hps_gp EXPORT_OF hps_gp_split.hps_gp
	set_interface_property hps_gp_split_hps_gp_out EXPORT_OF hps_gp_split.hps_gp_out
	set_interface_property ocram_2k_00_clk1 EXPORT_OF ocram_2k_00.clk1
	set_interface_property ocram_2k_00_axi_s1 EXPORT_OF ocram_2k_00.axi_s1
	set_interface_property ocram_2k_00_reset1 EXPORT_OF ocram_2k_00.reset1
	set_interface_property ocram_2k_01_clk1 EXPORT_OF ocram_2k_01.clk1
	set_interface_property ocram_2k_01_axi_s1 EXPORT_OF ocram_2k_01.axi_s1
	set_interface_property ocram_2k_01_reset1 EXPORT_OF ocram_2k_01.reset1
	set_interface_property ocram_2k_10_clk1 EXPORT_OF ocram_2k_10.clk1
	set_interface_property ocram_2k_10_axi_s1 EXPORT_OF ocram_2k_10.axi_s1
	set_interface_property ocram_2k_10_reset1 EXPORT_OF ocram_2k_10.reset1
	set_interface_property ocram_2k_11_clk1 EXPORT_OF ocram_2k_11.clk1
	set_interface_property ocram_2k_11_axi_s1 EXPORT_OF ocram_2k_11.axi_s1
	set_interface_property ocram_2k_11_reset1 EXPORT_OF ocram_2k_11.reset1
	set_interface_property ocram_2k_20_clk1 EXPORT_OF ocram_2k_20.clk1
	set_interface_property ocram_2k_20_axi_s1 EXPORT_OF ocram_2k_20.axi_s1
	set_interface_property ocram_2k_20_reset1 EXPORT_OF ocram_2k_20.reset1
	set_interface_property ocram_2k_21_clk1 EXPORT_OF ocram_2k_21.clk1
	set_interface_property ocram_2k_21_axi_s1 EXPORT_OF ocram_2k_21.axi_s1
	set_interface_property ocram_2k_21_reset1 EXPORT_OF ocram_2k_21.reset1
	set_interface_property sysid_clk EXPORT_OF sysid.clk
	set_interface_property sysid_reset EXPORT_OF sysid.reset
	set_interface_property sysid_control_slave EXPORT_OF sysid.control_slave

	# set values for exposed HDL parameters

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="def_sub">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
 <element __value="gp_in_const">
  <datum __value="_sortIndex" value="8" type="int" />
 </element>
 <element __value="hps_gp_split">
  <datum __value="_sortIndex" value="7" type="int" />
 </element>
 <element __value="ocram_2k_00">
  <datum __value="_sortIndex" value="1" type="int" />
 </element>
 <element __value="ocram_2k_01">
  <datum __value="_sortIndex" value="2" type="int" />
 </element>
 <element __value="ocram_2k_10">
  <datum __value="_sortIndex" value="3" type="int" />
 </element>
 <element __value="ocram_2k_11">
  <datum __value="_sortIndex" value="4" type="int" />
 </element>
 <element __value="ocram_2k_20">
  <datum __value="_sortIndex" value="5" type="int" />
 </element>
 <element __value="ocram_2k_21">
  <datum __value="_sortIndex" value="6" type="int" />
 </element>
 <element __value="sysid">
  <datum __value="_sortIndex" value="9" type="int" />
 </element>
</bonusData>
}
	set_module_property FILE {h2f_bridge.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {h2f_bridge}

	# save the system
	sync_sysinfo_parameters
	save_system h2f_bridge
}
