#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
# SPDX-FileCopyrightText: Copyright (C) 2026 Altera Corporation
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
	add_instance f2sdram_bridge f2sdram_bridge
	add_component hash_jamb ip/no_pins_pd_top/hash_jamb.ip altera_jtag_avalon_master hash_jamb 19.1
	load_component hash_jamb
	set_component_parameter_value FAST_VER {0}
	set_component_parameter_value FIFO_DEPTHS {2}
	set_component_parameter_value PLI_PORT {50000}
	set_component_parameter_value USE_PLI {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation hash_jamb
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
	set_instantiation_interface_parameter_value master enableConcurrentSubordinateAccess {0}
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
	set_instantiation_interface_parameter_value master optimizedReadsWithBE {0}
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
	add_component hash_jamb_1 ip/no_pins_pd_top/hash_jamb_1.ip altera_jtag_avalon_master hash_jamb_1 19.1
	load_component hash_jamb_1
	set_component_parameter_value FAST_VER {0}
	set_component_parameter_value FIFO_DEPTHS {2}
	set_component_parameter_value PLI_PORT {50000}
	set_component_parameter_value USE_PLI {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation hash_jamb_1
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
	set_instantiation_interface_parameter_value master enableConcurrentSubordinateAccess {0}
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
	set_instantiation_interface_parameter_value master optimizedReadsWithBE {0}
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
	add_component hash_jamb_2 ip/no_pins_pd_top/hash_jamb_2.ip altera_jtag_avalon_master hash_jamb_2 19.1
	load_component hash_jamb_2
	set_component_parameter_value FAST_VER {0}
	set_component_parameter_value FIFO_DEPTHS {2}
	set_component_parameter_value PLI_PORT {50000}
	set_component_parameter_value USE_PLI {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation hash_jamb_2
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
	set_instantiation_interface_parameter_value master enableConcurrentSubordinateAccess {0}
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
	set_instantiation_interface_parameter_value master optimizedReadsWithBE {0}
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
	add_component hash_ram ip/no_pins_pd_top/hash_ram.ip intel_onchip_memory hash_ram 1.4.10
	load_component hash_ram
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
	set_component_parameter_value idWidth {1}
	set_component_parameter_value initMemContent {1}
	set_component_parameter_value initializationFileName {onchip_mem.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {0}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {4096.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation hash_ram
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {hash_ram_hash_ram}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {4096}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {hash_ram_hash_ram}
	set_instantiation_assignment_value postgeneration.simulation.init_file.param_name {INIT_FILE}
	set_instantiation_assignment_value postgeneration.simulation.init_file.type {MEM_INIT}
	add_instantiation_interface clk1 clock INPUT
	set_instantiation_interface_parameter_value clk1 clockRate {0}
	set_instantiation_interface_parameter_value clk1 externallyDriven {false}
	set_instantiation_interface_parameter_value clk1 ptfSchematicName {}
	add_instantiation_interface_port clk1 clk clk 1 STD_LOGIC Input
	add_instantiation_interface s1 avalon INPUT
	set_instantiation_interface_parameter_value s1 addressAlignment {DYNAMIC}
	set_instantiation_interface_parameter_value s1 addressGroup {0}
	set_instantiation_interface_parameter_value s1 addressSpan {4096}
	set_instantiation_interface_parameter_value s1 addressUnits {WORDS}
	set_instantiation_interface_parameter_value s1 alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value s1 associatedClock {clk1}
	set_instantiation_interface_parameter_value s1 associatedReset {reset1}
	set_instantiation_interface_parameter_value s1 bitsPerSymbol {8}
	set_instantiation_interface_parameter_value s1 bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value s1 burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value s1 burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value s1 constantBurstBehavior {false}
	set_instantiation_interface_parameter_value s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value s1 dfhParameterData {}
	set_instantiation_interface_parameter_value s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s1 dfhParameterId {}
	set_instantiation_interface_parameter_value s1 dfhParameterName {}
	set_instantiation_interface_parameter_value s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value s1 explicitAddressSpan {4096}
	set_instantiation_interface_parameter_value s1 holdTime {0}
	set_instantiation_interface_parameter_value s1 interleaveBursts {false}
	set_instantiation_interface_parameter_value s1 isBigEndian {false}
	set_instantiation_interface_parameter_value s1 isFlash {false}
	set_instantiation_interface_parameter_value s1 isMemoryDevice {true}
	set_instantiation_interface_parameter_value s1 isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value s1 linewrapBursts {false}
	set_instantiation_interface_parameter_value s1 maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value s1 maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value s1 minimumReadLatency {1}
	set_instantiation_interface_parameter_value s1 minimumResponseLatency {1}
	set_instantiation_interface_parameter_value s1 minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value s1 prSafe {false}
	set_instantiation_interface_parameter_value s1 printableDevice {false}
	set_instantiation_interface_parameter_value s1 readLatency {1}
	set_instantiation_interface_parameter_value s1 readWaitStates {0}
	set_instantiation_interface_parameter_value s1 readWaitTime {0}
	set_instantiation_interface_parameter_value s1 registerIncomingSignals {false}
	set_instantiation_interface_parameter_value s1 registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value s1 setupTime {0}
	set_instantiation_interface_parameter_value s1 timingUnits {Cycles}
	set_instantiation_interface_parameter_value s1 transparentBridge {false}
	set_instantiation_interface_parameter_value s1 waitrequestAllowance {0}
	set_instantiation_interface_parameter_value s1 waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value s1 wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value s1 writeLatency {0}
	set_instantiation_interface_parameter_value s1 writeWaitStates {0}
	set_instantiation_interface_parameter_value s1 writeWaitTime {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isMemoryDevice {1}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_sysinfo_parameter_value s1 address_map {<address-map><slave name='s1' start='0x0' end='0x1000' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value s1 address_width {12}
	set_instantiation_interface_sysinfo_parameter_value s1 max_slave_data_width {32}
	add_instantiation_interface_port s1 address address 10 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 read read 1 STD_LOGIC Input
	add_instantiation_interface_port s1 readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s1 byteenable byteenable 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 write write 1 STD_LOGIC Input
	add_instantiation_interface_port s1 writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
	save_instantiation
	add_component hash_ram_1 ip/no_pins_pd_top/hash_ram_1.ip intel_onchip_memory hash_ram_1 1.4.10
	load_component hash_ram_1
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
	set_component_parameter_value idWidth {1}
	set_component_parameter_value initMemContent {1}
	set_component_parameter_value initializationFileName {onchip_mem.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {0}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {4096.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation hash_ram_1
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {hash_ram_1_hash_ram_1}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {4096}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {hash_ram_1_hash_ram_1}
	set_instantiation_assignment_value postgeneration.simulation.init_file.param_name {INIT_FILE}
	set_instantiation_assignment_value postgeneration.simulation.init_file.type {MEM_INIT}
	add_instantiation_interface clk1 clock INPUT
	set_instantiation_interface_parameter_value clk1 clockRate {0}
	set_instantiation_interface_parameter_value clk1 externallyDriven {false}
	set_instantiation_interface_parameter_value clk1 ptfSchematicName {}
	add_instantiation_interface_port clk1 clk clk 1 STD_LOGIC Input
	add_instantiation_interface s1 avalon INPUT
	set_instantiation_interface_parameter_value s1 addressAlignment {DYNAMIC}
	set_instantiation_interface_parameter_value s1 addressGroup {0}
	set_instantiation_interface_parameter_value s1 addressSpan {4096}
	set_instantiation_interface_parameter_value s1 addressUnits {WORDS}
	set_instantiation_interface_parameter_value s1 alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value s1 associatedClock {clk1}
	set_instantiation_interface_parameter_value s1 associatedReset {reset1}
	set_instantiation_interface_parameter_value s1 bitsPerSymbol {8}
	set_instantiation_interface_parameter_value s1 bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value s1 burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value s1 burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value s1 constantBurstBehavior {false}
	set_instantiation_interface_parameter_value s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value s1 dfhParameterData {}
	set_instantiation_interface_parameter_value s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s1 dfhParameterId {}
	set_instantiation_interface_parameter_value s1 dfhParameterName {}
	set_instantiation_interface_parameter_value s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value s1 explicitAddressSpan {4096}
	set_instantiation_interface_parameter_value s1 holdTime {0}
	set_instantiation_interface_parameter_value s1 interleaveBursts {false}
	set_instantiation_interface_parameter_value s1 isBigEndian {false}
	set_instantiation_interface_parameter_value s1 isFlash {false}
	set_instantiation_interface_parameter_value s1 isMemoryDevice {true}
	set_instantiation_interface_parameter_value s1 isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value s1 linewrapBursts {false}
	set_instantiation_interface_parameter_value s1 maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value s1 maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value s1 minimumReadLatency {1}
	set_instantiation_interface_parameter_value s1 minimumResponseLatency {1}
	set_instantiation_interface_parameter_value s1 minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value s1 prSafe {false}
	set_instantiation_interface_parameter_value s1 printableDevice {false}
	set_instantiation_interface_parameter_value s1 readLatency {1}
	set_instantiation_interface_parameter_value s1 readWaitStates {0}
	set_instantiation_interface_parameter_value s1 readWaitTime {0}
	set_instantiation_interface_parameter_value s1 registerIncomingSignals {false}
	set_instantiation_interface_parameter_value s1 registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value s1 setupTime {0}
	set_instantiation_interface_parameter_value s1 timingUnits {Cycles}
	set_instantiation_interface_parameter_value s1 transparentBridge {false}
	set_instantiation_interface_parameter_value s1 waitrequestAllowance {0}
	set_instantiation_interface_parameter_value s1 waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value s1 wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value s1 writeLatency {0}
	set_instantiation_interface_parameter_value s1 writeWaitStates {0}
	set_instantiation_interface_parameter_value s1 writeWaitTime {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isMemoryDevice {1}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_sysinfo_parameter_value s1 address_map {<address-map><slave name='s1' start='0x0' end='0x1000' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value s1 address_width {12}
	set_instantiation_interface_sysinfo_parameter_value s1 max_slave_data_width {32}
	add_instantiation_interface_port s1 address address 10 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 read read 1 STD_LOGIC Input
	add_instantiation_interface_port s1 readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s1 byteenable byteenable 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 write write 1 STD_LOGIC Input
	add_instantiation_interface_port s1 writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
	save_instantiation
	add_component hash_ram_2 ip/no_pins_pd_top/hash_ram_2.ip intel_onchip_memory hash_ram_2 1.4.10
	load_component hash_ram_2
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
	set_component_parameter_value idWidth {1}
	set_component_parameter_value initMemContent {1}
	set_component_parameter_value initializationFileName {onchip_mem.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {0}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {4096.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation hash_ram_2
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {hash_ram_2_hash_ram_2}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {4096}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {hash_ram_2_hash_ram_2}
	set_instantiation_assignment_value postgeneration.simulation.init_file.param_name {INIT_FILE}
	set_instantiation_assignment_value postgeneration.simulation.init_file.type {MEM_INIT}
	add_instantiation_interface clk1 clock INPUT
	set_instantiation_interface_parameter_value clk1 clockRate {0}
	set_instantiation_interface_parameter_value clk1 externallyDriven {false}
	set_instantiation_interface_parameter_value clk1 ptfSchematicName {}
	add_instantiation_interface_port clk1 clk clk 1 STD_LOGIC Input
	add_instantiation_interface s1 avalon INPUT
	set_instantiation_interface_parameter_value s1 addressAlignment {DYNAMIC}
	set_instantiation_interface_parameter_value s1 addressGroup {0}
	set_instantiation_interface_parameter_value s1 addressSpan {4096}
	set_instantiation_interface_parameter_value s1 addressUnits {WORDS}
	set_instantiation_interface_parameter_value s1 alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value s1 associatedClock {clk1}
	set_instantiation_interface_parameter_value s1 associatedReset {reset1}
	set_instantiation_interface_parameter_value s1 bitsPerSymbol {8}
	set_instantiation_interface_parameter_value s1 bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value s1 burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value s1 burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value s1 constantBurstBehavior {false}
	set_instantiation_interface_parameter_value s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value s1 dfhParameterData {}
	set_instantiation_interface_parameter_value s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s1 dfhParameterId {}
	set_instantiation_interface_parameter_value s1 dfhParameterName {}
	set_instantiation_interface_parameter_value s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value s1 explicitAddressSpan {4096}
	set_instantiation_interface_parameter_value s1 holdTime {0}
	set_instantiation_interface_parameter_value s1 interleaveBursts {false}
	set_instantiation_interface_parameter_value s1 isBigEndian {false}
	set_instantiation_interface_parameter_value s1 isFlash {false}
	set_instantiation_interface_parameter_value s1 isMemoryDevice {true}
	set_instantiation_interface_parameter_value s1 isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value s1 linewrapBursts {false}
	set_instantiation_interface_parameter_value s1 maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value s1 maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value s1 minimumReadLatency {1}
	set_instantiation_interface_parameter_value s1 minimumResponseLatency {1}
	set_instantiation_interface_parameter_value s1 minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value s1 prSafe {false}
	set_instantiation_interface_parameter_value s1 printableDevice {false}
	set_instantiation_interface_parameter_value s1 readLatency {1}
	set_instantiation_interface_parameter_value s1 readWaitStates {0}
	set_instantiation_interface_parameter_value s1 readWaitTime {0}
	set_instantiation_interface_parameter_value s1 registerIncomingSignals {false}
	set_instantiation_interface_parameter_value s1 registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value s1 setupTime {0}
	set_instantiation_interface_parameter_value s1 timingUnits {Cycles}
	set_instantiation_interface_parameter_value s1 transparentBridge {false}
	set_instantiation_interface_parameter_value s1 waitrequestAllowance {0}
	set_instantiation_interface_parameter_value s1 waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value s1 wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value s1 writeLatency {0}
	set_instantiation_interface_parameter_value s1 writeWaitStates {0}
	set_instantiation_interface_parameter_value s1 writeWaitTime {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isMemoryDevice {1}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_sysinfo_parameter_value s1 address_map {<address-map><slave name='s1' start='0x0' end='0x1000' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value s1 address_width {12}
	set_instantiation_interface_sysinfo_parameter_value s1 max_slave_data_width {32}
	add_instantiation_interface_port s1 address address 10 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 read read 1 STD_LOGIC Input
	add_instantiation_interface_port s1 readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s1 byteenable byteenable 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 write write 1 STD_LOGIC Input
	add_instantiation_interface_port s1 writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
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
	add_connection config_clk_250m.clkout/f2sdram_bridge.clock_br_in_clk
	set_connection_parameter_value config_clk_250m.clkout/f2sdram_bridge.clock_br_in_clk clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/f2sdram_bridge.clock_br_in_clk clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/f2sdram_bridge.clock_br_in_clk clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/f2sdram_bridge.clock_br_in_clk resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/hash_jamb.clk
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb.clk clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb.clk clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb.clk clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb.clk resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/hash_jamb_1.clk
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb_1.clk clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb_1.clk clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb_1.clk clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb_1.clk resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/hash_jamb_2.clk
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb_2.clk clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb_2.clk clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb_2.clk clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_jamb_2.clk resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/hash_ram.clk1
	set_connection_parameter_value config_clk_250m.clkout/hash_ram.clk1 clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/hash_ram.clk1 clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_ram.clk1 clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_ram.clk1 resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/hash_ram_1.clk1
	set_connection_parameter_value config_clk_250m.clkout/hash_ram_1.clk1 clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/hash_ram_1.clk1 clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_ram_1.clk1 clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_ram_1.clk1 resetDomainSysInfo {1}
	add_connection config_clk_250m.clkout/hash_ram_2.clk1
	set_connection_parameter_value config_clk_250m.clkout/hash_ram_2.clk1 clockDomainSysInfo {1}
	set_connection_parameter_value config_clk_250m.clkout/hash_ram_2.clk1 clockRateSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_ram_2.clk1 clockResetSysInfo {}
	set_connection_parameter_value config_clk_250m.clkout/hash_ram_2.clk1 resetDomainSysInfo {1}
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
	add_connection f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram addressMapSysInfo {<address-map><slave name='no_pins_hps.agilex_5_soc.f2sdram' start='0x0' end='0x100000000' datawidth='256' /></address-map>}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram addressWidthSysInfo {32}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram arbitrationPriority {1}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram baseAddress {0x0000}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram cpuInfoIdSysInfo {}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram defaultConnection {0}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram domainAlias {}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_bridge.f2sdram_adapt_256b_axi4_man/no_pins_hps.agilex_5_soc_f2sdram slaveDataWidthSysInfo {256}
	add_connection f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 addressMapSysInfo {<address-map><slave name='f2sdram_bridge.limiter_removal_256b.s0' start='0x0' end='0x100000000' datawidth='256' /><slave name='f2sdram_bridge.ocram_32k.s1' start='0x100000000' end='0x100008000' datawidth='256' /></address-map>}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 addressWidthSysInfo {33}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 arbitrationPriority {1}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 baseAddress {0x0000}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 cpuInfoIdSysInfo {}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 defaultConnection {0}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 domainAlias {}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.limiter_removal_256b_s0 slaveDataWidthSysInfo {256}
	add_connection f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 addressMapSysInfo {<address-map><slave name='f2sdram_bridge.limiter_removal_256b.s0' start='0x0' end='0x100000000' datawidth='256' /><slave name='f2sdram_bridge.ocram_32k.s1' start='0x100000000' end='0x100008000' datawidth='256' /></address-map>}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 addressWidthSysInfo {33}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 arbitrationPriority {1}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 baseAddress {0x0000000100000000}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 defaultConnection {0}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 domainAlias {}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_read/f2sdram_bridge.ocram_32k_s1 slaveDataWidthSysInfo {256}
	add_connection f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 addressMapSysInfo {<address-map><slave name='f2sdram_bridge.limiter_removal_256b.s1' start='0x0' end='0x100000000' datawidth='256' /><slave name='f2sdram_bridge.ocram_32k.s1' start='0x100000000' end='0x100008000' datawidth='256' /></address-map>}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 addressWidthSysInfo {33}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 arbitrationPriority {1}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 baseAddress {0x0000}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 defaultConnection {0}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 domainAlias {}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.limiter_removal_256b_s1 slaveDataWidthSysInfo {256}
	add_connection f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 addressMapSysInfo {<address-map><slave name='f2sdram_bridge.limiter_removal_256b.s1' start='0x0' end='0x100000000' datawidth='256' /><slave name='f2sdram_bridge.ocram_32k.s1' start='0x100000000' end='0x100008000' datawidth='256' /></address-map>}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 addressWidthSysInfo {33}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 arbitrationPriority {1}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 baseAddress {0x0000000100000000}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 defaultConnection {0}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 domainAlias {}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value f2sdram_bridge.msgdma_256b_mm_write/f2sdram_bridge.ocram_32k_s1 slaveDataWidthSysInfo {256}
	add_connection hash_jamb.master/hash_ram.s1
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 addressMapSysInfo {<address-map><slave name='hash_ram.s1' start='0x0' end='0x1000' datawidth='32' /></address-map>}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 addressWidthSysInfo {12}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 arbitrationPriority {1}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 baseAddress {0x0000}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 defaultConnection {0}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 domainAlias {}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value hash_jamb.master/hash_ram.s1 slaveDataWidthSysInfo {-1}
	add_connection hash_jamb_1.master/hash_ram_1.s1
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 addressMapSysInfo {<address-map><slave name='hash_ram_1.s1' start='0x0' end='0x1000' datawidth='32' /></address-map>}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 addressWidthSysInfo {12}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 arbitrationPriority {1}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 baseAddress {0x0000}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 defaultConnection {0}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 domainAlias {}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value hash_jamb_1.master/hash_ram_1.s1 slaveDataWidthSysInfo {-1}
	add_connection hash_jamb_2.master/hash_ram_2.s1
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 addressMapSysInfo {<address-map><slave name='hash_ram_2.s1' start='0x0' end='0x1000' datawidth='32' /></address-map>}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 addressWidthSysInfo {12}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 arbitrationPriority {1}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 baseAddress {0x0000}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 defaultConnection {0}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 domainAlias {}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value hash_jamb_2.master/hash_ram_2.s1 slaveDataWidthSysInfo {-1}
	add_connection no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps addressMapSysInfo {<address-map><slave name='no_pins_hps/agilex_5_soc.fpga2hps' start='0x0' end='0x100000000' datawidth='256' /></address-map>}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps addressWidthSysInfo {32}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps arbitrationPriority {1}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps baseAddress {0x0000}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps cpuInfoIdSysInfo {}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps defaultConnection {0}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps domainAlias {}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_periph.f2h_term_ace5lite_manager/no_pins_hps.agilex_5_soc_fpga2hps slaveDataWidthSysInfo {256}
	add_connection no_pins_hps.agilex_5_soc_fpga2hps_interrupt_irq0/f2sdram_bridge.msgdma_256b_csr_irq
	set_connection_parameter_value no_pins_hps.agilex_5_soc_fpga2hps_interrupt_irq0/f2sdram_bridge.msgdma_256b_csr_irq interruptsUsedSysInfo {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_fpga2hps_interrupt_irq0/f2sdram_bridge.msgdma_256b_csr_irq irqNumber {0}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/f2sdram_bridge.reset_br_in_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/f2sdram_bridge.reset_br_in_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/f2sdram_bridge.reset_br_in_reset clockResetSysInfo {<info><reset name="reset_br_in_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/f2sdram_bridge.reset_br_in_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb.clk_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb.clk_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb.clk_reset clockResetSysInfo {<info><reset name="clk_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb.clk_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb_1.clk_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb_1.clk_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb_1.clk_reset clockResetSysInfo {<info><reset name="clk_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb_1.clk_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb_2.clk_reset
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb_2.clk_reset clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb_2.clk_reset clockResetSysInfo {<info><reset name="clk_reset" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_jamb_2.clk_reset resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/hash_ram.reset1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_ram.reset1 clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_ram.reset1 clockResetSysInfo {<info><reset name="reset1" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_ram.reset1 resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/hash_ram_1.reset1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_ram_1.reset1 clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_ram_1.reset1 clockResetSysInfo {<info><reset name="reset1" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_ram_1.reset1 resetDomainSysInfo {2}
	add_connection no_pins_hps.agilex_5_soc_h2f_reset/hash_ram_2.reset1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_ram_2.reset1 clockDomainSysInfo {2}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_ram_2.reset1 clockResetSysInfo {<info><reset name="reset1" domain="0" /></info>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_h2f_reset/hash_ram_2.reset1 resetDomainSysInfo {2}
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
	add_connection no_pins_hps.agilex_5_soc_hps_gp/f2sdram_bridge.hps_gp_split_hps_gp
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps_gp/f2sdram_bridge.hps_gp_split_hps_gp endPort {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps_gp/f2sdram_bridge.hps_gp_split_hps_gp endPortLSB {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps_gp/f2sdram_bridge.hps_gp_split_hps_gp startPort {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps_gp/f2sdram_bridge.hps_gp_split_hps_gp startPortLSB {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_hps_gp/f2sdram_bridge.hps_gp_split_hps_gp width {0}
	add_connection no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub addressMapSysInfo {<address-map><slave name='f2sdram_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2sdram_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2sdram_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2sdram_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub addressWidthSysInfo {16}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub baseAddress {0x0000}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub cpuInfoIdSysInfo {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub defaultConnection {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.def_sub_default_sub slaveDataWidthSysInfo {256}
	add_connection no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr addressMapSysInfo {<address-map><slave name='f2sdram_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2sdram_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2sdram_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2sdram_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr addressWidthSysInfo {16}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr baseAddress {0x1000}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr cpuInfoIdSysInfo {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_csr slaveDataWidthSysInfo {256}
	add_connection no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave addressMapSysInfo {<address-map><slave name='f2sdram_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2sdram_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2sdram_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2sdram_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave addressWidthSysInfo {16}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave baseAddress {0x2000}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave cpuInfoIdSysInfo {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.msgdma_256b_descriptor_slave slaveDataWidthSysInfo {256}
	add_connection no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 addressMapSysInfo {<address-map><slave name='f2sdram_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2sdram_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2sdram_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2sdram_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 addressWidthSysInfo {16}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 baseAddress {0x8000}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.ocram_32k_s1 slaveDataWidthSysInfo {256}
	add_connection no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave addressMapSysInfo {<address-map><slave name='f2sdram_bridge.sysid.control_slave' start='0x0' end='0x8' datawidth='32' /><slave name='f2sdram_bridge.msgdma_256b.csr' start='0x1000' end='0x1020' datawidth='32' /><slave name='f2sdram_bridge.msgdma_256b.descriptor_slave' start='0x2000' end='0x2020' datawidth='256' /><slave name='f2sdram_bridge.ocram_32k.s1' start='0x8000' end='0x10000' datawidth='256' /></address-map>}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave addressWidthSysInfo {16}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave arbitrationPriority {1}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave baseAddress {0x0000}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave cpuInfoIdSysInfo {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave defaultConnection {0}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave domainAlias {}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.maxAdditionalLatency {4}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.syncResets {TRUE}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value no_pins_hps.agilex_5_soc_lwhps2fpga/f2sdram_bridge.sysid_control_slave slaveDataWidthSysInfo {256}
	add_connection usermode_entry.ninit_done/f2sdram_bridge.reset_br_in_reset
	set_connection_parameter_value usermode_entry.ninit_done/f2sdram_bridge.reset_br_in_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/f2sdram_bridge.reset_br_in_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/f2sdram_bridge.reset_br_in_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/hash_jamb.clk_reset
	set_connection_parameter_value usermode_entry.ninit_done/hash_jamb.clk_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/hash_jamb.clk_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/hash_jamb.clk_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/hash_jamb_1.clk_reset
	set_connection_parameter_value usermode_entry.ninit_done/hash_jamb_1.clk_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/hash_jamb_1.clk_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/hash_jamb_1.clk_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/hash_jamb_2.clk_reset
	set_connection_parameter_value usermode_entry.ninit_done/hash_jamb_2.clk_reset clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/hash_jamb_2.clk_reset clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/hash_jamb_2.clk_reset resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/hash_ram.reset1
	set_connection_parameter_value usermode_entry.ninit_done/hash_ram.reset1 clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/hash_ram.reset1 clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/hash_ram.reset1 resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/hash_ram_1.reset1
	set_connection_parameter_value usermode_entry.ninit_done/hash_ram_1.reset1 clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/hash_ram_1.reset1 clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/hash_ram_1.reset1 resetDomainSysInfo {14}
	add_connection usermode_entry.ninit_done/hash_ram_2.reset1
	set_connection_parameter_value usermode_entry.ninit_done/hash_ram_2.reset1 clockDomainSysInfo {14}
	set_connection_parameter_value usermode_entry.ninit_done/hash_ram_2.reset1 clockResetSysInfo {}
	set_connection_parameter_value usermode_entry.ninit_done/hash_ram_2.reset1 resetDomainSysInfo {14}
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
	set_interface_property fpga2hps_interrupt_irq1 EXPORT_OF no_pins_hps.agilex_5_soc_fpga2hps_interrupt_irq1
	set_interface_property emif_bank3a_hps_mem_0 EXPORT_OF no_pins_hps.emif_bank3a_hps_mem_0
	set_interface_property emif_bank3a_hps_mem_ck_0 EXPORT_OF no_pins_hps.emif_bank3a_hps_mem_ck_0
	set_interface_property emif_bank3a_hps_mem_reset_n EXPORT_OF no_pins_hps.emif_bank3a_hps_mem_reset_n
	set_interface_property emif_bank3a_hps_oct_0 EXPORT_OF no_pins_hps.emif_bank3a_hps_oct_0
	set_interface_property emif_bank3a_hps_ref_clk EXPORT_OF no_pins_hps.emif_bank3a_hps_ref_clk

	# set values for exposed HDL parameters
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.enableAllPipelines FALSE
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.enableEccProtection FALSE
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.enableInstrumentation FALSE
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.interconnectType STANDARD
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.maxAdditionalLatency 1
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.splitCommandsFor4KBoundary FALSE
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.syncResets TRUE
	set_domain_assignment f2sdram_bridge.f2sdram_adapt_256b_axi4_man qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.enableAllPipelines FALSE
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.enableEccProtection FALSE
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.enableInstrumentation FALSE
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.interconnectType STANDARD
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.maxAdditionalLatency 4
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.splitCommandsFor4KBoundary FALSE
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.syncResets TRUE
	set_domain_assignment f2sdram_bridge.msgdma_256b_mm_read qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment hash_jamb.master qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment hash_jamb.master qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment hash_jamb.master qsys_mm.enableAllPipelines FALSE
	set_domain_assignment hash_jamb.master qsys_mm.enableEccProtection FALSE
	set_domain_assignment hash_jamb.master qsys_mm.enableInstrumentation FALSE
	set_domain_assignment hash_jamb.master qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment hash_jamb.master qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment hash_jamb.master qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment hash_jamb.master qsys_mm.interconnectType STANDARD
	set_domain_assignment hash_jamb.master qsys_mm.maxAdditionalLatency 1
	set_domain_assignment hash_jamb.master qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment hash_jamb.master qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment hash_jamb.master qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment hash_jamb.master qsys_mm.splitCommandsFor4KBoundary FALSE
	set_domain_assignment hash_jamb.master qsys_mm.syncResets TRUE
	set_domain_assignment hash_jamb.master qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment hash_jamb_1.master qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment hash_jamb_1.master qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment hash_jamb_1.master qsys_mm.enableAllPipelines FALSE
	set_domain_assignment hash_jamb_1.master qsys_mm.enableEccProtection FALSE
	set_domain_assignment hash_jamb_1.master qsys_mm.enableInstrumentation FALSE
	set_domain_assignment hash_jamb_1.master qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment hash_jamb_1.master qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment hash_jamb_1.master qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment hash_jamb_1.master qsys_mm.interconnectType STANDARD
	set_domain_assignment hash_jamb_1.master qsys_mm.maxAdditionalLatency 1
	set_domain_assignment hash_jamb_1.master qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment hash_jamb_1.master qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment hash_jamb_1.master qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment hash_jamb_1.master qsys_mm.splitCommandsFor4KBoundary FALSE
	set_domain_assignment hash_jamb_1.master qsys_mm.syncResets TRUE
	set_domain_assignment hash_jamb_1.master qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment hash_jamb_2.master qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment hash_jamb_2.master qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment hash_jamb_2.master qsys_mm.enableAllPipelines FALSE
	set_domain_assignment hash_jamb_2.master qsys_mm.enableEccProtection FALSE
	set_domain_assignment hash_jamb_2.master qsys_mm.enableInstrumentation FALSE
	set_domain_assignment hash_jamb_2.master qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment hash_jamb_2.master qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment hash_jamb_2.master qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment hash_jamb_2.master qsys_mm.interconnectType STANDARD
	set_domain_assignment hash_jamb_2.master qsys_mm.maxAdditionalLatency 1
	set_domain_assignment hash_jamb_2.master qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment hash_jamb_2.master qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment hash_jamb_2.master qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment hash_jamb_2.master qsys_mm.splitCommandsFor4KBoundary FALSE
	set_domain_assignment hash_jamb_2.master qsys_mm.syncResets TRUE
	set_domain_assignment hash_jamb_2.master qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.enableAllPipelines FALSE
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.enableEccProtection FALSE
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.enableInstrumentation FALSE
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.interconnectType STANDARD
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.maxAdditionalLatency 1
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.splitCommandsFor4KBoundary FALSE
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.syncResets TRUE
	set_domain_assignment no_periph.f2h_term_ace5lite_manager qsys_mm.widthAdapterImplementation GENERIC_CONVERTER

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="config_clk_250m">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
 <element __value="f2sdram_bridge">
  <datum __value="_sortIndex" value="4" type="int" />
 </element>
 <element __value="f2sdram_bridge.msgdma_256b_csr">
  <datum __value="baseAddress" value="4096" type="String" />
 </element>
 <element __value="f2sdram_bridge.msgdma_256b_descriptor_slave">
  <datum __value="baseAddress" value="8192" type="String" />
 </element>
 <element __value="f2sdram_bridge.ocram_32k_s1">
  <datum __value="baseAddress" value="32768" type="String" />
 </element>
 <element __value="hash_jamb">
  <datum __value="_sortIndex" value="5" type="int" />
 </element>
 <element __value="hash_jamb_1">
  <datum __value="_sortIndex" value="7" type="int" />
 </element>
 <element __value="hash_jamb_2">
  <datum __value="_sortIndex" value="9" type="int" />
 </element>
 <element __value="hash_ram">
  <datum __value="_sortIndex" value="6" type="int" />
 </element>
 <element __value="hash_ram_1">
  <datum __value="_sortIndex" value="8" type="int" />
 </element>
 <element __value="hash_ram_2">
  <datum __value="_sortIndex" value="10" type="int" />
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
