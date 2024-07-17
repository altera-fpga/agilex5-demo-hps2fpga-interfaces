#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_spi_bridge {} {
	# create the system
	create_system spi_bridge
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED065BB32AE5SR0}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component clock_250m ip/no_pins_pd_top/clock_250m.ip altera_clock_bridge clock_250m 19.2.0
	load_component clock_250m
	set_component_parameter_value EXPLICIT_CLOCK_RATE {250000000.0}
	set_component_parameter_value NUM_CLOCK_OUTPUTS {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation clock_250m
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
	set_component_parameter_value GPIN_CONSTANT {1112359251}
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
	add_component ocram_4k ip/no_pins_pd_top/ocram_4k.ip intel_onchip_memory ocram_4k 1.4.8
	load_component ocram_4k
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
	load_instantiation ocram_4k
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {ocram_4k_ocram_4k}
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
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {ocram_4k_ocram_4k}
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
	add_component reset_br ip/no_pins_pd_top/reset_br.ip altera_reset_bridge reset_br 19.2.0
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
	add_component samb ip/no_pins_pd_top/samb.ip spi_slave_to_avalon_mm_master_bridge samb 19.1.4
	load_component samb
	set_component_parameter_value SYNC_DEPTH {2}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation samb
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset_n reset INPUT
	set_instantiation_interface_parameter_value reset_n associatedClock {clk}
	set_instantiation_interface_parameter_value reset_n synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset_n reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface export_0 conduit INPUT
	set_instantiation_interface_parameter_value export_0 associatedClock {}
	set_instantiation_interface_parameter_value export_0 associatedReset {}
	set_instantiation_interface_parameter_value export_0 prSafe {false}
	add_instantiation_interface_port export_0 mosi_to_the_spislave_inst_for_spichain mosi_to_the_spislave_inst_for_spichain 1 STD_LOGIC Input
	add_instantiation_interface_port export_0 nss_to_the_spislave_inst_for_spichain nss_to_the_spislave_inst_for_spichain 1 STD_LOGIC Input
	add_instantiation_interface_port export_0 sclk_to_the_spislave_inst_for_spichain sclk_to_the_spislave_inst_for_spichain 1 STD_LOGIC Input
	add_instantiation_interface_port export_0 miso_to_and_from_the_spislave_inst_for_spichain miso_to_and_from_the_spislave_inst_for_spichain 1 STD_LOGIC Bidir
	add_instantiation_interface avalon_master avalon OUTPUT
	set_instantiation_interface_parameter_value avalon_master adaptsTo {}
	set_instantiation_interface_parameter_value avalon_master addressGroup {0}
	set_instantiation_interface_parameter_value avalon_master addressUnits {SYMBOLS}
	set_instantiation_interface_parameter_value avalon_master alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value avalon_master associatedClock {clk}
	set_instantiation_interface_parameter_value avalon_master associatedReset {reset_n}
	set_instantiation_interface_parameter_value avalon_master bitsPerSymbol {8}
	set_instantiation_interface_parameter_value avalon_master burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value avalon_master burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value avalon_master constantBurstBehavior {false}
	set_instantiation_interface_parameter_value avalon_master dBSBigEndian {false}
	set_instantiation_interface_parameter_value avalon_master doStreamReads {false}
	set_instantiation_interface_parameter_value avalon_master doStreamWrites {false}
	set_instantiation_interface_parameter_value avalon_master holdTime {0}
	set_instantiation_interface_parameter_value avalon_master interleaveBursts {false}
	set_instantiation_interface_parameter_value avalon_master isAsynchronous {false}
	set_instantiation_interface_parameter_value avalon_master isBigEndian {false}
	set_instantiation_interface_parameter_value avalon_master isReadable {false}
	set_instantiation_interface_parameter_value avalon_master isWriteable {false}
	set_instantiation_interface_parameter_value avalon_master linewrapBursts {false}
	set_instantiation_interface_parameter_value avalon_master maxAddressWidth {32}
	set_instantiation_interface_parameter_value avalon_master maximumPendingReadTransactions {1}
	set_instantiation_interface_parameter_value avalon_master maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value avalon_master minimumReadLatency {1}
	set_instantiation_interface_parameter_value avalon_master minimumResponseLatency {1}
	set_instantiation_interface_parameter_value avalon_master prSafe {false}
	set_instantiation_interface_parameter_value avalon_master readLatency {0}
	set_instantiation_interface_parameter_value avalon_master readWaitTime {1}
	set_instantiation_interface_parameter_value avalon_master registerIncomingSignals {false}
	set_instantiation_interface_parameter_value avalon_master registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value avalon_master setupTime {0}
	set_instantiation_interface_parameter_value avalon_master timingUnits {Cycles}
	set_instantiation_interface_parameter_value avalon_master waitrequestAllowance {0}
	set_instantiation_interface_parameter_value avalon_master waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value avalon_master writeWaitTime {0}
	add_instantiation_interface_port avalon_master address_from_the_altera_avalon_packets_to_master_inst_for_spichain address 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port avalon_master byteenable_from_the_altera_avalon_packets_to_master_inst_for_spichain byteenable 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port avalon_master read_from_the_altera_avalon_packets_to_master_inst_for_spichain read 1 STD_LOGIC Output
	add_instantiation_interface_port avalon_master readdata_to_the_altera_avalon_packets_to_master_inst_for_spichain readdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port avalon_master readdatavalid_to_the_altera_avalon_packets_to_master_inst_for_spichain readdatavalid 1 STD_LOGIC Input
	add_instantiation_interface_port avalon_master waitrequest_to_the_altera_avalon_packets_to_master_inst_for_spichain waitrequest 1 STD_LOGIC Input
	add_instantiation_interface_port avalon_master write_from_the_altera_avalon_packets_to_master_inst_for_spichain write 1 STD_LOGIC Output
	add_instantiation_interface_port avalon_master writedata_from_the_altera_avalon_packets_to_master_inst_for_spichain writedata 32 STD_LOGIC_VECTOR Output
	save_instantiation
	add_component xlate_spi ip/no_pins_pd_top/xlate_spi.ip conduit_xlate_spi xlate_spi 1.0
	load_component xlate_spi
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation xlate_spi
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface hps_spim0_sclk_out clock INPUT
	set_instantiation_interface_parameter_value hps_spim0_sclk_out clockRate {125000000}
	set_instantiation_interface_parameter_value hps_spim0_sclk_out externallyDriven {false}
	set_instantiation_interface_parameter_value hps_spim0_sclk_out ptfSchematicName {}
	add_instantiation_interface_port hps_spim0_sclk_out spim0_sclk_in clk 1 STD_LOGIC Input
	add_instantiation_interface hps_spim0 conduit INPUT
	set_instantiation_interface_parameter_value hps_spim0 associatedClock {}
	set_instantiation_interface_parameter_value hps_spim0 associatedReset {}
	set_instantiation_interface_parameter_value hps_spim0 prSafe {false}
	add_instantiation_interface_port hps_spim0 spim0_mosi_o mosi_o 1 STD_LOGIC Input
	add_instantiation_interface_port hps_spim0 spim0_miso_i miso_i 1 STD_LOGIC Output
	add_instantiation_interface_port hps_spim0 spim0_ss_out_n ss_in_n 1 STD_LOGIC Output
	add_instantiation_interface_port hps_spim0 spim0_mosi_oe mosi_oe 1 STD_LOGIC Input
	add_instantiation_interface_port hps_spim0 spim0_ss0_n_o ss0_n_o 1 STD_LOGIC Input
	add_instantiation_interface_port hps_spim0 spim0_ss1_n_o ss1_n_o 1 STD_LOGIC Input
	add_instantiation_interface_port hps_spim0 spim0_ss2_n_o ss2_n_o 1 STD_LOGIC Input
	add_instantiation_interface_port hps_spim0 spim0_ss3_n_o ss3_n_o 1 STD_LOGIC Input
	add_instantiation_interface spi_slave_to_avmm_bridge_io conduit INPUT
	set_instantiation_interface_parameter_value spi_slave_to_avmm_bridge_io associatedClock {}
	set_instantiation_interface_parameter_value spi_slave_to_avmm_bridge_io associatedReset {}
	set_instantiation_interface_parameter_value spi_slave_to_avmm_bridge_io prSafe {false}
	add_instantiation_interface_port spi_slave_to_avmm_bridge_io spi_slave_to_avmm_bridge_io_mosi_to_the_spislave_outst_for_spichain mosi_to_the_spislave_inst_for_spichain 1 STD_LOGIC Output
	add_instantiation_interface_port spi_slave_to_avmm_bridge_io spi_slave_to_avmm_bridge_io_nss_to_the_spislave_outst_for_spichain nss_to_the_spislave_inst_for_spichain 1 STD_LOGIC Output
	add_instantiation_interface_port spi_slave_to_avmm_bridge_io spi_slave_to_avmm_bridge_io_sclk_to_the_spislave_outst_for_spichain sclk_to_the_spislave_inst_for_spichain 1 STD_LOGIC Output
	add_instantiation_interface_port spi_slave_to_avmm_bridge_io spi_slave_to_avmm_bridge_io_miso_to_and_from_the_spislave_outst_for_spichain miso_to_and_from_the_spislave_inst_for_spichain 1 STD_LOGIC Bidir
	save_instantiation

	# add wirelevel expressions

	# preserve ports for debug

	# add the connections
	add_connection clock_250m.out_clk/ocram_4k.clk1
	set_connection_parameter_value clock_250m.out_clk/ocram_4k.clk1 clockDomainSysInfo {-1}
	set_connection_parameter_value clock_250m.out_clk/ocram_4k.clk1 clockRateSysInfo {250000000.0}
	set_connection_parameter_value clock_250m.out_clk/ocram_4k.clk1 clockResetSysInfo {}
	set_connection_parameter_value clock_250m.out_clk/ocram_4k.clk1 resetDomainSysInfo {-1}
	add_connection clock_250m.out_clk/samb.clk
	set_connection_parameter_value clock_250m.out_clk/samb.clk clockDomainSysInfo {-1}
	set_connection_parameter_value clock_250m.out_clk/samb.clk clockRateSysInfo {250000000.0}
	set_connection_parameter_value clock_250m.out_clk/samb.clk clockResetSysInfo {}
	set_connection_parameter_value clock_250m.out_clk/samb.clk resetDomainSysInfo {-1}
	add_connection gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in endPort {}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in endPortLSB {0}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in startPort {}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in startPortLSB {0}
	set_connection_parameter_value gp_in_const.hps_gp_in/hps_gp_split.hps_gp_in width {0}
	add_connection reset_br.out_reset/ocram_4k.reset1
	set_connection_parameter_value reset_br.out_reset/ocram_4k.reset1 clockDomainSysInfo {-1}
	set_connection_parameter_value reset_br.out_reset/ocram_4k.reset1 clockResetSysInfo {}
	set_connection_parameter_value reset_br.out_reset/ocram_4k.reset1 resetDomainSysInfo {-1}
	add_connection reset_br.out_reset/samb.reset_n
	set_connection_parameter_value reset_br.out_reset/samb.reset_n clockDomainSysInfo {-1}
	set_connection_parameter_value reset_br.out_reset/samb.reset_n clockResetSysInfo {}
	set_connection_parameter_value reset_br.out_reset/samb.reset_n resetDomainSysInfo {-1}
	add_connection samb.avalon_master/ocram_4k.s1
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 addressMapSysInfo {}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 addressWidthSysInfo {}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 arbitrationPriority {1}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 baseAddress {0x0000}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 defaultConnection {0}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 domainAlias {}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value samb.avalon_master/ocram_4k.s1 slaveDataWidthSysInfo {-1}
	add_connection xlate_spi.spi_slave_to_avmm_bridge_io/samb.export_0
	set_connection_parameter_value xlate_spi.spi_slave_to_avmm_bridge_io/samb.export_0 endPort {}
	set_connection_parameter_value xlate_spi.spi_slave_to_avmm_bridge_io/samb.export_0 endPortLSB {0}
	set_connection_parameter_value xlate_spi.spi_slave_to_avmm_bridge_io/samb.export_0 startPort {}
	set_connection_parameter_value xlate_spi.spi_slave_to_avmm_bridge_io/samb.export_0 startPortLSB {0}
	set_connection_parameter_value xlate_spi.spi_slave_to_avmm_bridge_io/samb.export_0 width {0}

	# add the exports
	set_interface_property clock_250m_in_clk EXPORT_OF clock_250m.in_clk
	set_interface_property hps_gp_split_hps_gp EXPORT_OF hps_gp_split.hps_gp
	set_interface_property hps_gp_split_hps_gp_out EXPORT_OF hps_gp_split.hps_gp_out
	set_interface_property reset_br_in_reset EXPORT_OF reset_br.in_reset
	set_interface_property xlate_spi_hps_spim0_sclk_out EXPORT_OF xlate_spi.hps_spim0_sclk_out
	set_interface_property xlate_spi_hps_spim0 EXPORT_OF xlate_spi.hps_spim0

	# set values for exposed HDL parameters
	set_domain_assignment samb.avalon_master qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment samb.avalon_master qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment samb.avalon_master qsys_mm.enableAllPipelines FALSE
	set_domain_assignment samb.avalon_master qsys_mm.enableEccProtection FALSE
	set_domain_assignment samb.avalon_master qsys_mm.enableInstrumentation FALSE
	set_domain_assignment samb.avalon_master qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment samb.avalon_master qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment samb.avalon_master qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment samb.avalon_master qsys_mm.interconnectType STANDARD
	set_domain_assignment samb.avalon_master qsys_mm.maxAdditionalLatency 1
	set_domain_assignment samb.avalon_master qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment samb.avalon_master qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment samb.avalon_master qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment samb.avalon_master qsys_mm.syncResets TRUE
	set_domain_assignment samb.avalon_master qsys_mm.widthAdapterImplementation GENERIC_CONVERTER

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="clock_250m">
  <datum __value="_sortIndex" value="5" type="int" />
 </element>
 <element __value="gp_in_const">
  <datum __value="_sortIndex" value="4" type="int" />
 </element>
 <element __value="hps_gp_split">
  <datum __value="_sortIndex" value="3" type="int" />
 </element>
 <element __value="ocram_4k">
  <datum __value="_sortIndex" value="2" type="int" />
 </element>
 <element __value="reset_br">
  <datum __value="_sortIndex" value="6" type="int" />
 </element>
 <element __value="samb">
  <datum __value="_sortIndex" value="1" type="int" />
 </element>
 <element __value="xlate_spi">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
</bonusData>
}
	set_module_property FILE {spi_bridge.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {spi_bridge}

	# save the system
	sync_sysinfo_parameters
	save_system spi_bridge
}
