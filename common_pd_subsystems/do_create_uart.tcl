#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_uart {} {
	# create the system
	create_system uart
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED065BB32AE5SR0}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component clk_250m ip/no_pins_pd_top/clk_250m.ip altera_clock_bridge clk_250m 19.2.0
	load_component clk_250m
	set_component_parameter_value EXPLICIT_CLOCK_RATE {250000000.0}
	set_component_parameter_value NUM_CLOCK_OUTPUTS {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation clk_250m
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface in_clk clock INPUT
	set_instantiation_interface_parameter_value in_clk clockRate {0}
	set_instantiation_interface_parameter_value in_clk externallyDriven {false}
	set_instantiation_interface_parameter_value in_clk ptfSchematicName {}
	add_instantiation_interface_port in_clk in_clk clk 1 STD_LOGIC Input
	add_instantiation_interface out_clk clock OUTPUT
	set_instantiation_interface_parameter_value out_clk associatedDirectClock {in_clk}
	set_instantiation_interface_parameter_value out_clk clockRate {250000000}
	set_instantiation_interface_parameter_value out_clk clockRateKnown {true}
	set_instantiation_interface_parameter_value out_clk externallyDriven {false}
	set_instantiation_interface_parameter_value out_clk ptfSchematicName {}
	set_instantiation_interface_sysinfo_parameter_value out_clk clock_rate {250000000}
	add_instantiation_interface_port out_clk out_clk clk 1 STD_LOGIC Output
	save_instantiation
	add_component gp_in_const ip/no_pins_pd_top/gp_in_const.ip hps_gp_in_constant gp_in_const 1.0
	load_component gp_in_const
	set_component_parameter_value GPIN_CONSTANT {1414676821}
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
	add_component lw_uart ip/no_pins_pd_top/lw_uart.ip intel_lw_uart lw_uart 1.0.7
	load_component lw_uart
	set_component_parameter_value baud {115200}
	set_component_parameter_value dataBits {8}
	set_component_parameter_value fixedBaud {1}
	set_component_parameter_value parity {NONE}
	set_component_parameter_value rxfifoAlmostFullValue {1}
	set_component_parameter_value rxfifoDepth {8}
	set_component_parameter_value simTrueBaud {0}
	set_component_parameter_value stopBits {1}
	set_component_parameter_value syncRegDepth {2}
	set_component_parameter_value txfifoDepth {8}
	set_component_parameter_value useCtsRts {0}
	set_component_parameter_value useEopRegister {0}
	set_component_parameter_value useRegRXFIFO {0}
	set_component_parameter_value useRegTXFIFO {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation lw_uart
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.BAUD {115200}
	set_instantiation_assignment_value embeddedsw.CMacro.DATA_BITS {8}
	set_instantiation_assignment_value embeddedsw.CMacro.FIXED_BAUD {1}
	set_instantiation_assignment_value embeddedsw.CMacro.FREQ {250000000}
	set_instantiation_assignment_value embeddedsw.CMacro.PARITY {'N'}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DEPTH {2048}
	set_instantiation_assignment_value embeddedsw.CMacro.SIM_TRUE_BAUD {0}
	set_instantiation_assignment_value embeddedsw.CMacro.STOP_BITS {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SYNC_REG_DEPTH {2}
	set_instantiation_assignment_value embeddedsw.CMacro.USE_CTS_RTS {0}
	set_instantiation_assignment_value embeddedsw.CMacro.USE_EOP_REGISTER {0}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITE_DEPTH {2048}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clk}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface s1 avalon INPUT
	set_instantiation_interface_parameter_value s1 addressAlignment {NATIVE}
	set_instantiation_interface_parameter_value s1 addressGroup {0}
	set_instantiation_interface_parameter_value s1 addressSpan {8}
	set_instantiation_interface_parameter_value s1 addressUnits {WORDS}
	set_instantiation_interface_parameter_value s1 alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value s1 associatedClock {clk}
	set_instantiation_interface_parameter_value s1 associatedReset {reset}
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
	set_instantiation_interface_parameter_value s1 explicitAddressSpan {0}
	set_instantiation_interface_parameter_value s1 holdTime {0}
	set_instantiation_interface_parameter_value s1 interleaveBursts {false}
	set_instantiation_interface_parameter_value s1 isBigEndian {false}
	set_instantiation_interface_parameter_value s1 isFlash {false}
	set_instantiation_interface_parameter_value s1 isMemoryDevice {false}
	set_instantiation_interface_parameter_value s1 isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value s1 linewrapBursts {false}
	set_instantiation_interface_parameter_value s1 maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value s1 maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value s1 minimumReadLatency {1}
	set_instantiation_interface_parameter_value s1 minimumResponseLatency {1}
	set_instantiation_interface_parameter_value s1 minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value s1 prSafe {false}
	set_instantiation_interface_parameter_value s1 printableDevice {true}
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
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isMemoryDevice {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isPrintableDevice {1}
	set_instantiation_interface_sysinfo_parameter_value s1 address_map {<address-map><slave name='s1' start='0x0' end='0x20' datawidth='16' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value s1 address_width {5}
	set_instantiation_interface_sysinfo_parameter_value s1 max_slave_data_width {16}
	add_instantiation_interface_port s1 address address 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 read read 1 STD_LOGIC Input
	add_instantiation_interface_port s1 write write 1 STD_LOGIC Input
	add_instantiation_interface_port s1 writedata writedata 16 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 readdata readdata 16 STD_LOGIC_VECTOR Output
	add_instantiation_interface external_connection conduit INPUT
	set_instantiation_interface_parameter_value external_connection associatedClock {}
	set_instantiation_interface_parameter_value external_connection associatedReset {}
	set_instantiation_interface_parameter_value external_connection prSafe {false}
	add_instantiation_interface_port external_connection rxd rxd 1 STD_LOGIC Input
	add_instantiation_interface_port external_connection txd txd 1 STD_LOGIC Output
	add_instantiation_interface irq interrupt INPUT
	set_instantiation_interface_parameter_value irq associatedAddressablePoint {s1}
	set_instantiation_interface_parameter_value irq associatedClock {clk}
	set_instantiation_interface_parameter_value irq associatedReset {reset}
	set_instantiation_interface_parameter_value irq bridgedReceiverOffset {0}
	set_instantiation_interface_parameter_value irq bridgesToReceiver {}
	set_instantiation_interface_parameter_value irq irqScheme {NONE}
	add_instantiation_interface_port irq irq irq 1 STD_LOGIC Output
	save_instantiation
	add_component niosv_c ip/no_pins_pd_top/niosv_c.ip intel_niosv_c niosv_c 1.2.0
	load_component niosv_c
	set_component_parameter_value enableECCLite {0}
	set_component_parameter_value numGpr {32}
	set_component_parameter_value resetOffset {0}
	set_component_parameter_value resetSlave {ocram_8k.axi_s1}
	set_component_parameter_value useResetReq {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation niosv_c
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.CPU_FREQ {250000000u}
	set_instantiation_assignment_value embeddedsw.CMacro.DATA_ADDR_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.CMacro.DCACHE_LINE_SIZE {0}
	set_instantiation_assignment_value embeddedsw.CMacro.DCACHE_LINE_SIZE_LOG2 {0}
	set_instantiation_assignment_value embeddedsw.CMacro.DCACHE_SIZE {0}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_CSR_SUPPORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.ICACHE_LINE_SIZE {0}
	set_instantiation_assignment_value embeddedsw.CMacro.ICACHE_LINE_SIZE_LOG2 {0}
	set_instantiation_assignment_value embeddedsw.CMacro.ICACHE_SIZE {0}
	set_instantiation_assignment_value embeddedsw.CMacro.INST_ADDR_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.CMacro.NIOSV_CORE_VARIANT {4}
	set_instantiation_assignment_value embeddedsw.CMacro.NUM_GPR {32}
	set_instantiation_assignment_value embeddedsw.CMacro.RESET_ADDR {0x00002000}
	set_instantiation_assignment_value embeddedsw.configuration.HDLSimCachesCleared {1}
	set_instantiation_assignment_value embeddedsw.configuration.cpuArchitecture {Small Core}
	set_instantiation_assignment_value embeddedsw.configuration.fpuEnabled {0}
	set_instantiation_assignment_value embeddedsw.configuration.numGpr {32}
	set_instantiation_assignment_value embeddedsw.configuration.resetOffset {0}
	set_instantiation_assignment_value embeddedsw.configuration.resetSlave {ocram_8k.axi_s1}
	set_instantiation_assignment_value embeddedsw.dts.params.altr,reset-addr {0x00002000}
	set_instantiation_assignment_value embeddedsw.dts.params.clock-frequency {250000000u}
	set_instantiation_assignment_value embeddedsw.dts.params.dcache-line-size {0}
	set_instantiation_assignment_value embeddedsw.dts.params.dcache-size {0}
	set_instantiation_assignment_value embeddedsw.dts.params.icache-line-size {0}
	set_instantiation_assignment_value embeddedsw.dts.params.icache-size {0}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clk}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset reset_reset reset 1 STD_LOGIC Input
	add_instantiation_interface instruction_manager axi4lite OUTPUT
	set_instantiation_interface_parameter_value instruction_manager addressCheck {false}
	set_instantiation_interface_parameter_value instruction_manager associatedClock {clk}
	set_instantiation_interface_parameter_value instruction_manager associatedReset {reset}
	set_instantiation_interface_parameter_value instruction_manager combinedIssuingCapability {1}
	set_instantiation_interface_parameter_value instruction_manager dataCheck {false}
	set_instantiation_interface_parameter_value instruction_manager maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value instruction_manager maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value instruction_manager maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value instruction_manager poison {false}
	set_instantiation_interface_parameter_value instruction_manager readIssuingCapability {1}
	set_instantiation_interface_parameter_value instruction_manager securityAttribute {false}
	set_instantiation_interface_parameter_value instruction_manager traceSignals {false}
	set_instantiation_interface_parameter_value instruction_manager trustzoneAware {true}
	set_instantiation_interface_parameter_value instruction_manager uniqueIdSupport {false}
	set_instantiation_interface_parameter_value instruction_manager userData {false}
	set_instantiation_interface_parameter_value instruction_manager wakeupSignals {false}
	set_instantiation_interface_parameter_value instruction_manager writeIssuingCapability {1}
	add_instantiation_interface_port instruction_manager instruction_manager_awaddr awaddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_awprot awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port instruction_manager instruction_manager_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_wdata wdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_wstrb wstrb 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port instruction_manager instruction_manager_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port instruction_manager instruction_manager_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port instruction_manager instruction_manager_araddr araddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port instruction_manager instruction_manager_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_rdata rdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port instruction_manager instruction_manager_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port instruction_manager instruction_manager_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_rready rready 1 STD_LOGIC Output
	add_instantiation_interface data_manager axi4lite OUTPUT
	set_instantiation_interface_parameter_value data_manager addressCheck {false}
	set_instantiation_interface_parameter_value data_manager associatedClock {clk}
	set_instantiation_interface_parameter_value data_manager associatedReset {reset}
	set_instantiation_interface_parameter_value data_manager combinedIssuingCapability {1}
	set_instantiation_interface_parameter_value data_manager dataCheck {false}
	set_instantiation_interface_parameter_value data_manager maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value data_manager maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value data_manager maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value data_manager poison {false}
	set_instantiation_interface_parameter_value data_manager readIssuingCapability {1}
	set_instantiation_interface_parameter_value data_manager securityAttribute {false}
	set_instantiation_interface_parameter_value data_manager traceSignals {false}
	set_instantiation_interface_parameter_value data_manager trustzoneAware {true}
	set_instantiation_interface_parameter_value data_manager uniqueIdSupport {false}
	set_instantiation_interface_parameter_value data_manager userData {false}
	set_instantiation_interface_parameter_value data_manager wakeupSignals {false}
	set_instantiation_interface_parameter_value data_manager writeIssuingCapability {1}
	add_instantiation_interface_port data_manager data_manager_awaddr awaddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_awprot awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port data_manager data_manager_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_wdata wdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_wstrb wstrb 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port data_manager data_manager_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port data_manager data_manager_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port data_manager data_manager_araddr araddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port data_manager data_manager_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_rdata rdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port data_manager data_manager_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port data_manager data_manager_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_rready rready 1 STD_LOGIC Output
	save_instantiation
	add_component ocram_8k ip/no_pins_pd_top/ocram_8k.ip intel_onchip_memory ocram_8k 1.4.8
	load_component ocram_8k
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
	set_component_parameter_value idWidth {2}
	set_component_parameter_value initMemContent {1}
	set_component_parameter_value initializationFileName {onchip_mem.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {1}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {8192.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation ocram_8k
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {ocram_8k_ocram_8k}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {8192}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {ocram_8k_ocram_8k}
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
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_map {<address-map><slave name='axi_s1' start='0x0' end='0x2000' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 address_width {13}
	set_instantiation_interface_sysinfo_parameter_value axi_s1 max_slave_data_width {32}
	add_instantiation_interface_port axi_s1 s1_arid arid 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_araddr araddr 13 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_awid awid 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awaddr awaddr 13 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi_s1 s1_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port axi_s1 s1_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_rid rid 2 STD_LOGIC_VECTOR Output
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
	add_instantiation_interface_port axi_s1 s1_bid bid 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi_s1 s1_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port axi_s1 s1_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
	save_instantiation
	add_component reset_br ip/uart/reset_br.ip altera_reset_bridge reset_br 19.2.0
	load_component reset_br
	set_component_parameter_value ACTIVE_LOW_RESET {0}
	set_component_parameter_value NUM_RESET_OUTPUTS {1}
	set_component_parameter_value SYNCHRONOUS_EDGES {none}
	set_component_parameter_value SYNC_RESET {0}
	set_component_parameter_value USE_RESET_REQUEST {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation reset_br
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
	add_component xlate_uart ip/no_pins_pd_top/xlate_uart.ip conduit_xlate_uart xlate_uart 1.0
	load_component xlate_uart
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation xlate_uart
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface hps_uart conduit INPUT
	set_instantiation_interface_parameter_value hps_uart associatedClock {}
	set_instantiation_interface_parameter_value hps_uart associatedReset {}
	set_instantiation_interface_parameter_value hps_uart prSafe {false}
	add_instantiation_interface_port hps_uart uart_cts_n cts_n 1 STD_LOGIC Output
	add_instantiation_interface_port hps_uart uart_dsr_n dsr_n 1 STD_LOGIC Output
	add_instantiation_interface_port hps_uart uart_dcd_n dcd_n 1 STD_LOGIC Output
	add_instantiation_interface_port hps_uart uart_ri_n ri_n 1 STD_LOGIC Output
	add_instantiation_interface_port hps_uart uart_rx rx 1 STD_LOGIC Output
	add_instantiation_interface_port hps_uart uart_dtr_n dtr_n 1 STD_LOGIC Input
	add_instantiation_interface_port hps_uart uart_rts_n rts_n 1 STD_LOGIC Input
	add_instantiation_interface_port hps_uart uart_in1_n out1_n 1 STD_LOGIC Input
	add_instantiation_interface_port hps_uart uart_in2_n out2_n 1 STD_LOGIC Input
	add_instantiation_interface_port hps_uart uart_tx tx 1 STD_LOGIC Input
	add_instantiation_interface fpga_uart_io conduit INPUT
	set_instantiation_interface_parameter_value fpga_uart_io associatedClock {}
	set_instantiation_interface_parameter_value fpga_uart_io associatedReset {}
	set_instantiation_interface_parameter_value fpga_uart_io prSafe {false}
	add_instantiation_interface_port fpga_uart_io uart_io_rxd rxd 1 STD_LOGIC Output
	add_instantiation_interface_port fpga_uart_io uart_io_txd txd 1 STD_LOGIC Input
	save_instantiation

	# add wirelevel expressions

	# preserve ports for debug

	# add the connections
	add_connection clk_250m.out_clk/lw_uart.clk
	set_connection_parameter_value clk_250m.out_clk/lw_uart.clk clockDomainSysInfo {1}
	set_connection_parameter_value clk_250m.out_clk/lw_uart.clk clockRateSysInfo {250000000.0}
	set_connection_parameter_value clk_250m.out_clk/lw_uart.clk clockResetSysInfo {}
	set_connection_parameter_value clk_250m.out_clk/lw_uart.clk resetDomainSysInfo {1}
	add_connection clk_250m.out_clk/niosv_c.clk
	set_connection_parameter_value clk_250m.out_clk/niosv_c.clk clockDomainSysInfo {1}
	set_connection_parameter_value clk_250m.out_clk/niosv_c.clk clockRateSysInfo {250000000.0}
	set_connection_parameter_value clk_250m.out_clk/niosv_c.clk clockResetSysInfo {}
	set_connection_parameter_value clk_250m.out_clk/niosv_c.clk resetDomainSysInfo {1}
	add_connection clk_250m.out_clk/ocram_8k.clk1
	set_connection_parameter_value clk_250m.out_clk/ocram_8k.clk1 clockDomainSysInfo {1}
	set_connection_parameter_value clk_250m.out_clk/ocram_8k.clk1 clockRateSysInfo {250000000.0}
	set_connection_parameter_value clk_250m.out_clk/ocram_8k.clk1 clockResetSysInfo {}
	set_connection_parameter_value clk_250m.out_clk/ocram_8k.clk1 resetDomainSysInfo {1}
	add_connection gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in endPort {}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in endPortLSB {0}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in startPort {}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in startPortLSB {0}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in width {0}
	add_connection lw_uart.external_connection/xlate_uart.fpga_uart_io
	set_connection_parameter_value lw_uart.external_connection/xlate_uart.fpga_uart_io endPort {}
	set_connection_parameter_value lw_uart.external_connection/xlate_uart.fpga_uart_io endPortLSB {0}
	set_connection_parameter_value lw_uart.external_connection/xlate_uart.fpga_uart_io startPort {}
	set_connection_parameter_value lw_uart.external_connection/xlate_uart.fpga_uart_io startPortLSB {0}
	set_connection_parameter_value lw_uart.external_connection/xlate_uart.fpga_uart_io width {0}
	add_connection niosv_c.data_manager/lw_uart.s1
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 addressMapSysInfo {<address-map><slave name='lw_uart.s1' start='0x1000' end='0x1020' datawidth='16' /><slave name='ocram_8k.axi_s1' start='0x2000' end='0x4000' datawidth='32' /></address-map>}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 addressWidthSysInfo {14}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 arbitrationPriority {1}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 baseAddress {0x1000}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 defaultConnection {0}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 domainAlias {}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_c.data_manager/lw_uart.s1 slaveDataWidthSysInfo {-1}
	add_connection niosv_c.data_manager/ocram_8k.axi_s1
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 addressMapSysInfo {<address-map><slave name='lw_uart.s1' start='0x1000' end='0x1020' datawidth='16' /><slave name='ocram_8k.axi_s1' start='0x2000' end='0x4000' datawidth='32' /></address-map>}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 addressWidthSysInfo {14}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 arbitrationPriority {1}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 baseAddress {0x2000}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 defaultConnection {0}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 domainAlias {}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_c.data_manager/ocram_8k.axi_s1 slaveDataWidthSysInfo {-1}
	add_connection niosv_c.instruction_manager/ocram_8k.axi_s1
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 addressMapSysInfo {<address-map><slave name='ocram_8k.axi_s1' start='0x2000' end='0x4000' datawidth='32' /></address-map>}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 addressWidthSysInfo {14}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 arbitrationPriority {1}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 baseAddress {0x2000}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 defaultConnection {0}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 domainAlias {}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_c.instruction_manager/ocram_8k.axi_s1 slaveDataWidthSysInfo {-1}
	add_connection reset_br.out_reset/lw_uart.reset
	set_connection_parameter_value reset_br.out_reset/lw_uart.reset clockDomainSysInfo {2}
	set_connection_parameter_value reset_br.out_reset/lw_uart.reset clockResetSysInfo {}
	set_connection_parameter_value reset_br.out_reset/lw_uart.reset resetDomainSysInfo {2}
	add_connection reset_br.out_reset/niosv_c.reset
	set_connection_parameter_value reset_br.out_reset/niosv_c.reset clockDomainSysInfo {2}
	set_connection_parameter_value reset_br.out_reset/niosv_c.reset clockResetSysInfo {}
	set_connection_parameter_value reset_br.out_reset/niosv_c.reset resetDomainSysInfo {2}
	add_connection reset_br.out_reset/ocram_8k.reset1
	set_connection_parameter_value reset_br.out_reset/ocram_8k.reset1 clockDomainSysInfo {2}
	set_connection_parameter_value reset_br.out_reset/ocram_8k.reset1 clockResetSysInfo {}
	set_connection_parameter_value reset_br.out_reset/ocram_8k.reset1 resetDomainSysInfo {2}

	# add the exports
	set_interface_property clk_250m_in_clk EXPORT_OF clk_250m.in_clk
	set_interface_property hps_gp_split_hps_gp EXPORT_OF hps_gp_split.hps_gp
	set_interface_property hps_gp_split_hps_gp_out EXPORT_OF hps_gp_split.hps_gp_out
	set_interface_property lw_uart_irq EXPORT_OF lw_uart.irq
	set_interface_property reset_br_in_reset EXPORT_OF reset_br.in_reset
	set_interface_property xlate_uart_hps_uart EXPORT_OF xlate_uart.hps_uart

	# set values for exposed HDL parameters
	set_domain_assignment niosv_c.data_manager qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment niosv_c.data_manager qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment niosv_c.data_manager qsys_mm.enableAllPipelines FALSE
	set_domain_assignment niosv_c.data_manager qsys_mm.enableEccProtection FALSE
	set_domain_assignment niosv_c.data_manager qsys_mm.enableInstrumentation FALSE
	set_domain_assignment niosv_c.data_manager qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment niosv_c.data_manager qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment niosv_c.data_manager qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment niosv_c.data_manager qsys_mm.interconnectType STANDARD
	set_domain_assignment niosv_c.data_manager qsys_mm.maxAdditionalLatency 1
	set_domain_assignment niosv_c.data_manager qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment niosv_c.data_manager qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment niosv_c.data_manager qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment niosv_c.data_manager qsys_mm.syncResets TRUE
	set_domain_assignment niosv_c.data_manager qsys_mm.widthAdapterImplementation GENERIC_CONVERTER

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="clk_250m">
  <datum __value="_sortIndex" value="4" type="int" />
 </element>
 <element __value="gp_in_const">
  <datum __value="_sortIndex" value="7" type="int" />
 </element>
 <element __value="hps_gp_split">
  <datum __value="_sortIndex" value="6" type="int" />
 </element>
 <element __value="lw_uart">
  <datum __value="_sortIndex" value="1" type="int" />
 </element>
 <element __value="lw_uart.s1">
  <datum __value="baseAddress" value="4096" type="String" />
 </element>
 <element __value="niosv_c">
  <datum __value="_sortIndex" value="2" type="int" />
 </element>
 <element __value="ocram_8k">
  <datum __value="_sortIndex" value="3" type="int" />
 </element>
 <element __value="ocram_8k.axi_s1">
  <datum __value="baseAddress" value="8192" type="String" />
 </element>
 <element __value="reset_br">
  <datum __value="_sortIndex" value="5" type="int" />
 </element>
 <element __value="xlate_uart">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
</bonusData>
}
	set_module_property FILE {uart.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {uart}

	# save the system
	sync_sysinfo_parameters
	save_system uart
}
