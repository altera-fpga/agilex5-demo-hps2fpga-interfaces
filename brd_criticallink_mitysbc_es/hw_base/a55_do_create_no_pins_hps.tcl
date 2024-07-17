#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
proc do_create_no_pins_hps {} {
	# create the system
	create_system no_pins_hps
	set_project_property BOARD {default}
	#set_project_property DEVICE {A5ED065BB32AE6SR0}
	#set_project_property DEVICE_FAMILY {Agilex 5}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component agilex_5_soc ip/no_pins_pd_top/agilex_5_soc.ip intel_agilex_5_soc agilex_5_soc 4.0.0
	load_component agilex_5_soc
	set_component_parameter_value ATB_Enable {0}
	set_component_parameter_value CM_Mode {N/A}
	set_component_parameter_value CM_PinMuxing {Unused}
	set_component_parameter_value CTI_Enable {0}
	set_component_parameter_value DMA_Enable {No No No No No No No No}
	set_component_parameter_value Debug_APB_Enable {0}
	set_component_parameter_value EMAC0_Mode {RGMII}
	set_component_parameter_value EMAC0_PPS_Enable {false}
	set_component_parameter_value EMAC0_PTP {0}
	set_component_parameter_value EMAC0_PinMuxing {FPGA}
	set_component_parameter_value EMAC1_Mode {N/A}
	set_component_parameter_value EMAC1_PPS_Enable {false}
	set_component_parameter_value EMAC1_PTP {0}
	set_component_parameter_value EMAC1_PinMuxing {Unused}
	set_component_parameter_value EMAC2_Mode {N/A}
	set_component_parameter_value EMAC2_PPS_Enable {false}
	set_component_parameter_value EMAC2_PTP {0}
	set_component_parameter_value EMAC2_PinMuxing {Unused}
	set_component_parameter_value EMIF_AXI_Enable {1}
	set_component_parameter_value EMIF_Topology {1}
	set_component_parameter_value F2H_IRQ_Enable {1}
	set_component_parameter_value F2H_free_clk_mhz {200}
	set_component_parameter_value F2H_free_clock_enable {0}
	set_component_parameter_value FPGA_EMAC0_gtx_clk_mhz {125.0}
	set_component_parameter_value FPGA_EMAC0_md_clk_mhz {2.5}
	set_component_parameter_value FPGA_EMAC1_gtx_clk_mhz {125.0}
	set_component_parameter_value FPGA_EMAC1_md_clk_mhz {2.5}
	set_component_parameter_value FPGA_EMAC2_gtx_clk_mhz {125.0}
	set_component_parameter_value FPGA_EMAC2_md_clk_mhz {2.5}
	set_component_parameter_value FPGA_I2C0_sclk_mhz {125.0}
	set_component_parameter_value FPGA_I2C1_sclk_mhz {125.0}
	set_component_parameter_value FPGA_I2CEMAC0_clk_mhz {125.0}
	set_component_parameter_value FPGA_I2CEMAC1_clk_mhz {125.0}
	set_component_parameter_value FPGA_I2CEMAC2_clk_mhz {125.0}
	set_component_parameter_value FPGA_I3C0_sclk_mhz {125.0}
	set_component_parameter_value FPGA_I3C1_sclk_mhz {125.0}
	set_component_parameter_value FPGA_SPIM0_sclk_mhz {125.0}
	set_component_parameter_value FPGA_SPIM1_sclk_mhz {125.0}
	set_component_parameter_value GP_Enable {1}
	set_component_parameter_value H2F_Address_Width {38}
	set_component_parameter_value H2F_IRQ_DMA_Enable0 {0}
	set_component_parameter_value H2F_IRQ_DMA_Enable1 {0}
	set_component_parameter_value H2F_IRQ_ECC_SERR_Enable {0}
	set_component_parameter_value H2F_IRQ_EMAC0_Enable {0}
	set_component_parameter_value H2F_IRQ_EMAC1_Enable {0}
	set_component_parameter_value H2F_IRQ_EMAC2_Enable {0}
	set_component_parameter_value H2F_IRQ_GPIO0_Enable {0}
	set_component_parameter_value H2F_IRQ_GPIO1_Enable {0}
	set_component_parameter_value H2F_IRQ_I2C0_Enable {0}
	set_component_parameter_value H2F_IRQ_I2C1_Enable {0}
	set_component_parameter_value H2F_IRQ_I2CEMAC0_Enable {0}
	set_component_parameter_value H2F_IRQ_I2CEMAC1_Enable {0}
	set_component_parameter_value H2F_IRQ_I2CEMAC2_Enable {0}
	set_component_parameter_value H2F_IRQ_I3C0_Enable {0}
	set_component_parameter_value H2F_IRQ_I3C1_Enable {0}
	set_component_parameter_value H2F_IRQ_L4Timer_Enable {0}
	set_component_parameter_value H2F_IRQ_NAND_Enable {0}
	set_component_parameter_value H2F_IRQ_PeriphClock_Enable {0}
	set_component_parameter_value H2F_IRQ_SDMMC_Enable {0}
	set_component_parameter_value H2F_IRQ_SPIM0_Enable {0}
	set_component_parameter_value H2F_IRQ_SPIM1_Enable {0}
	set_component_parameter_value H2F_IRQ_SPIS0_Enable {0}
	set_component_parameter_value H2F_IRQ_SPIS1_Enable {0}
	set_component_parameter_value H2F_IRQ_SYSTimer_Enable {0}
	set_component_parameter_value H2F_IRQ_UART0_Enable {0}
	set_component_parameter_value H2F_IRQ_UART1_Enable {0}
	set_component_parameter_value H2F_IRQ_USB0_Enable {0}
	set_component_parameter_value H2F_IRQ_USB1_Enable {0}
	set_component_parameter_value H2F_IRQ_Watchdog_Enable {0}
	set_component_parameter_value H2F_Width {32}
	set_component_parameter_value HPS_IO_Enable {NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE UART1:TX UART1:RX NONE NONE NONE NONE NONE HCLK:HPS_OSC_CLK NONE NONE}
	set_component_parameter_value I2C0_Mode {default}
	set_component_parameter_value I2C0_PinMuxing {FPGA}
	set_component_parameter_value I2C1_Mode {N/A}
	set_component_parameter_value I2C1_PinMuxing {Unused}
	set_component_parameter_value I2CEMAC0_Mode {N/A}
	set_component_parameter_value I2CEMAC0_PinMuxing {Unused}
	set_component_parameter_value I2CEMAC1_Mode {N/A}
	set_component_parameter_value I2CEMAC1_PinMuxing {Unused}
	set_component_parameter_value I2CEMAC2_Mode {N/A}
	set_component_parameter_value I2CEMAC2_PinMuxing {Unused}
	set_component_parameter_value I3C0_Mode {N/A}
	set_component_parameter_value I3C0_PinMuxing {Unused}
	set_component_parameter_value I3C1_Mode {N/A}
	set_component_parameter_value I3C1_PinMuxing {Unused}
	set_component_parameter_value IO_INPUT_DELAY0 {-1}
	set_component_parameter_value IO_INPUT_DELAY1 {-1}
	set_component_parameter_value IO_INPUT_DELAY10 {-1}
	set_component_parameter_value IO_INPUT_DELAY11 {-1}
	set_component_parameter_value IO_INPUT_DELAY12 {-1}
	set_component_parameter_value IO_INPUT_DELAY13 {-1}
	set_component_parameter_value IO_INPUT_DELAY14 {-1}
	set_component_parameter_value IO_INPUT_DELAY15 {-1}
	set_component_parameter_value IO_INPUT_DELAY16 {-1}
	set_component_parameter_value IO_INPUT_DELAY17 {-1}
	set_component_parameter_value IO_INPUT_DELAY18 {-1}
	set_component_parameter_value IO_INPUT_DELAY19 {-1}
	set_component_parameter_value IO_INPUT_DELAY2 {-1}
	set_component_parameter_value IO_INPUT_DELAY20 {-1}
	set_component_parameter_value IO_INPUT_DELAY21 {-1}
	set_component_parameter_value IO_INPUT_DELAY22 {-1}
	set_component_parameter_value IO_INPUT_DELAY23 {-1}
	set_component_parameter_value IO_INPUT_DELAY24 {-1}
	set_component_parameter_value IO_INPUT_DELAY25 {-1}
	set_component_parameter_value IO_INPUT_DELAY26 {-1}
	set_component_parameter_value IO_INPUT_DELAY27 {-1}
	set_component_parameter_value IO_INPUT_DELAY28 {-1}
	set_component_parameter_value IO_INPUT_DELAY29 {-1}
	set_component_parameter_value IO_INPUT_DELAY3 {-1}
	set_component_parameter_value IO_INPUT_DELAY30 {-1}
	set_component_parameter_value IO_INPUT_DELAY31 {-1}
	set_component_parameter_value IO_INPUT_DELAY32 {-1}
	set_component_parameter_value IO_INPUT_DELAY33 {-1}
	set_component_parameter_value IO_INPUT_DELAY34 {-1}
	set_component_parameter_value IO_INPUT_DELAY35 {-1}
	set_component_parameter_value IO_INPUT_DELAY36 {-1}
	set_component_parameter_value IO_INPUT_DELAY37 {-1}
	set_component_parameter_value IO_INPUT_DELAY38 {-1}
	set_component_parameter_value IO_INPUT_DELAY39 {-1}
	set_component_parameter_value IO_INPUT_DELAY4 {-1}
	set_component_parameter_value IO_INPUT_DELAY40 {-1}
	set_component_parameter_value IO_INPUT_DELAY41 {-1}
	set_component_parameter_value IO_INPUT_DELAY42 {-1}
	set_component_parameter_value IO_INPUT_DELAY43 {-1}
	set_component_parameter_value IO_INPUT_DELAY44 {-1}
	set_component_parameter_value IO_INPUT_DELAY45 {-1}
	set_component_parameter_value IO_INPUT_DELAY46 {-1}
	set_component_parameter_value IO_INPUT_DELAY47 {-1}
	set_component_parameter_value IO_INPUT_DELAY5 {-1}
	set_component_parameter_value IO_INPUT_DELAY6 {-1}
	set_component_parameter_value IO_INPUT_DELAY7 {-1}
	set_component_parameter_value IO_INPUT_DELAY8 {-1}
	set_component_parameter_value IO_INPUT_DELAY9 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY0 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY1 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY10 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY11 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY12 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY13 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY14 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY15 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY16 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY17 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY18 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY19 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY2 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY20 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY21 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY22 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY23 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY24 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY25 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY26 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY27 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY28 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY29 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY3 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY30 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY31 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY32 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY33 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY34 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY35 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY36 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY37 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY38 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY39 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY4 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY40 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY41 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY42 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY43 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY44 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY45 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY46 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY47 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY5 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY6 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY7 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY8 {-1}
	set_component_parameter_value IO_OUTPUT_DELAY9 {-1}
	set_component_parameter_value JTAG_Enable {0}
	set_component_parameter_value LWH2F_Address_Width {29}
	set_component_parameter_value LWH2F_Width {32}
	set_component_parameter_value MPLL_C0_Override_mhz {1600.0}
	set_component_parameter_value MPLL_C1_Override_mhz {800.0}
	set_component_parameter_value MPLL_C2_Override_mhz {1066.67}
	set_component_parameter_value MPLL_C3_Override_mhz {400.0}
	set_component_parameter_value MPLL_Clock_Source {0}
	set_component_parameter_value MPLL_Override {0}
	set_component_parameter_value MPLL_VCO_Override_mhz {3200.0}
	set_component_parameter_value MPU_Events_Enable {0}
	set_component_parameter_value MPU_clk_freq_override_mhz {1066.67}
	set_component_parameter_value MPU_clk_override {0}
	set_component_parameter_value MPU_clk_src_override {2}
	set_component_parameter_value MPU_core01_freq_override_mhz {1000.0}
	set_component_parameter_value MPU_core01_src_override {1}
	set_component_parameter_value MPU_core23_src_override {0}
	set_component_parameter_value MPU_core2_freq_override_mhz {1600.0}
	set_component_parameter_value MPU_core3_freq_override_mhz {1600.0}
	set_component_parameter_value NAND_Mode {N/A}
	set_component_parameter_value NAND_PinMuxing {Unused}
	set_component_parameter_value NOC_clk_cs_debug_div {4}
	set_component_parameter_value NOC_clk_cs_div {1}
	set_component_parameter_value NOC_clk_cs_trace_div {4}
	set_component_parameter_value NOC_clk_free_l4_div {4}
	set_component_parameter_value NOC_clk_periph_l4_div {2}
	set_component_parameter_value NOC_clk_phy_div {4}
	set_component_parameter_value NOC_clk_slow_l4_div {4}
	set_component_parameter_value NOC_clk_src_select {3}
	set_component_parameter_value PLL_CLK0 {Unused}
	set_component_parameter_value PLL_CLK1 {Unused}
	set_component_parameter_value PLL_CLK2 {Unused}
	set_component_parameter_value PLL_CLK3 {Unused}
	set_component_parameter_value PLL_CLK4 {Unused}
	set_component_parameter_value PPLL_C0_Override_mhz {1600.0}
	set_component_parameter_value PPLL_C1_Override_mhz {800.0}
	set_component_parameter_value PPLL_C2_Override_mhz {1066.67}
	set_component_parameter_value PPLL_C3_Override_mhz {400.0}
	set_component_parameter_value PPLL_Clock_Source {0}
	set_component_parameter_value PPLL_Override {0}
	set_component_parameter_value PPLL_VCO_Override_mhz {3200.0}
	set_component_parameter_value Periph_clk_emac0_sel {250}
	set_component_parameter_value Periph_clk_emac1_sel {50}
	set_component_parameter_value Periph_clk_emac2_sel {50}
	set_component_parameter_value Periph_clk_override {0}
	set_component_parameter_value Periph_emac_ptp_freq_override {400.0}
	set_component_parameter_value Periph_emac_ptp_src_override {7}
	set_component_parameter_value Periph_emaca_src_override {7}
	set_component_parameter_value Periph_emacb_src_override {7}
	set_component_parameter_value Periph_gpio_freq_override {400.0}
	set_component_parameter_value Periph_gpio_src_override {3}
	set_component_parameter_value Periph_psi_freq_override {500.0}
	set_component_parameter_value Periph_psi_src_override {7}
	set_component_parameter_value Periph_usb_freq_override {20.0}
	set_component_parameter_value Periph_usb_src_override {3}
	set_component_parameter_value Pwr_a55_core0_1_on {1}
	set_component_parameter_value Pwr_a76_core2_on {1}
	set_component_parameter_value Pwr_a76_core3_on {1}
	set_component_parameter_value Pwr_boot_core_sel {0}
	set_component_parameter_value Pwr_cpu_app_select {0}
	set_component_parameter_value Pwr_mpu_l3_cache_size {2}
	set_component_parameter_value Rst_h2f_cold_en {0}
	set_component_parameter_value Rst_hps_warm_en {0}
	set_component_parameter_value Rst_sdm_wd_config {0}
	set_component_parameter_value Rst_watchdog_en {0}
	set_component_parameter_value SDMMC_Mode {N/A}
	set_component_parameter_value SDMMC_PinMuxing {Unused}
	set_component_parameter_value SPIM0_Mode {Single_slave_selects}
	set_component_parameter_value SPIM0_PinMuxing {FPGA}
	set_component_parameter_value SPIM1_Mode {N/A}
	set_component_parameter_value SPIM1_PinMuxing {Unused}
	set_component_parameter_value SPIS0_Mode {N/A}
	set_component_parameter_value SPIS0_PinMuxing {Unused}
	set_component_parameter_value SPIS1_Mode {N/A}
	set_component_parameter_value SPIS1_PinMuxing {Unused}
	set_component_parameter_value STM_Enable {0}
	set_component_parameter_value TPIU_Select {HPS Clock Manager}
	set_component_parameter_value TRACE_Mode {N/A}
	set_component_parameter_value TRACE_PinMuxing {Unused}
	set_component_parameter_value UART0_Mode {Flow_control}
	set_component_parameter_value UART0_PinMuxing {FPGA}
	set_component_parameter_value UART1_Mode {No_flow_control}
	set_component_parameter_value UART1_PinMuxing {IO}
	set_component_parameter_value USB0_Mode {N/A}
	set_component_parameter_value USB0_PinMuxing {Unused}
	set_component_parameter_value USB1_Mode {N/A}
	set_component_parameter_value USB1_PinMuxing {Unused}
	set_component_parameter_value User0_clk_enable {1}
	set_component_parameter_value User0_clk_freq {400.0}
	set_component_parameter_value User0_clk_src_select {1}
	set_component_parameter_value User1_clk_enable {1}
	set_component_parameter_value User1_clk_freq {200.0}
	set_component_parameter_value User1_clk_src_select {1}
	set_component_parameter_value eosc1_clk_mhz {25.0}
	set_component_parameter_value f2s_SMMU {0}
	set_component_parameter_value f2s_address_width {32}
	set_component_parameter_value f2s_data_width {256}
	set_component_parameter_value f2s_mode {acelite}
	set_component_parameter_value f2sdram_address_width {32}
	set_component_parameter_value f2sdram_data_width {256}
	set_component_parameter_value hps_ioa10_opd_en {0}
	set_component_parameter_value hps_ioa11_opd_en {0}
	set_component_parameter_value hps_ioa12_opd_en {0}
	set_component_parameter_value hps_ioa13_opd_en {0}
	set_component_parameter_value hps_ioa14_opd_en {0}
	set_component_parameter_value hps_ioa15_opd_en {0}
	set_component_parameter_value hps_ioa16_opd_en {0}
	set_component_parameter_value hps_ioa17_opd_en {0}
	set_component_parameter_value hps_ioa18_opd_en {0}
	set_component_parameter_value hps_ioa19_opd_en {0}
	set_component_parameter_value hps_ioa1_opd_en {0}
	set_component_parameter_value hps_ioa20_opd_en {0}
	set_component_parameter_value hps_ioa21_opd_en {0}
	set_component_parameter_value hps_ioa22_opd_en {0}
	set_component_parameter_value hps_ioa23_opd_en {0}
	set_component_parameter_value hps_ioa24_opd_en {0}
	set_component_parameter_value hps_ioa2_opd_en {0}
	set_component_parameter_value hps_ioa3_opd_en {0}
	set_component_parameter_value hps_ioa4_opd_en {0}
	set_component_parameter_value hps_ioa5_opd_en {0}
	set_component_parameter_value hps_ioa6_opd_en {0}
	set_component_parameter_value hps_ioa7_opd_en {0}
	set_component_parameter_value hps_ioa8_opd_en {0}
	set_component_parameter_value hps_ioa9_opd_en {0}
	set_component_parameter_value hps_iob10_opd_en {0}
	set_component_parameter_value hps_iob11_opd_en {0}
	set_component_parameter_value hps_iob12_opd_en {0}
	set_component_parameter_value hps_iob13_opd_en {0}
	set_component_parameter_value hps_iob14_opd_en {0}
	set_component_parameter_value hps_iob15_opd_en {0}
	set_component_parameter_value hps_iob16_opd_en {0}
	set_component_parameter_value hps_iob17_opd_en {0}
	set_component_parameter_value hps_iob18_opd_en {0}
	set_component_parameter_value hps_iob19_opd_en {0}
	set_component_parameter_value hps_iob1_opd_en {0}
	set_component_parameter_value hps_iob20_opd_en {0}
	set_component_parameter_value hps_iob21_opd_en {0}
	set_component_parameter_value hps_iob22_opd_en {0}
	set_component_parameter_value hps_iob23_opd_en {0}
	set_component_parameter_value hps_iob24_opd_en {0}
	set_component_parameter_value hps_iob2_opd_en {0}
	set_component_parameter_value hps_iob3_opd_en {0}
	set_component_parameter_value hps_iob4_opd_en {0}
	set_component_parameter_value hps_iob5_opd_en {0}
	set_component_parameter_value hps_iob6_opd_en {0}
	set_component_parameter_value hps_iob7_opd_en {0}
	set_component_parameter_value hps_iob8_opd_en {0}
	set_component_parameter_value hps_iob9_opd_en {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation agilex_5_soc
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface h2f_reset reset OUTPUT
	set_instantiation_interface_parameter_value h2f_reset associatedClock {}
	set_instantiation_interface_parameter_value h2f_reset associatedDirectReset {}
	set_instantiation_interface_parameter_value h2f_reset associatedResetSinks {none}
	set_instantiation_interface_parameter_value h2f_reset synchronousEdges {NONE}
	add_instantiation_interface_port h2f_reset h2f_reset_reset reset 1 STD_LOGIC Output
	add_instantiation_interface hps_gp conduit INPUT
	set_instantiation_interface_parameter_value hps_gp associatedClock {}
	set_instantiation_interface_parameter_value hps_gp associatedReset {}
	set_instantiation_interface_parameter_value hps_gp prSafe {false}
	add_instantiation_interface_port hps_gp hps_gp_gp_in gp_in 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port hps_gp hps_gp_gp_out gp_out 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface hps2fpga_axi_clock clock INPUT
	set_instantiation_interface_parameter_value hps2fpga_axi_clock clockRate {0}
	set_instantiation_interface_parameter_value hps2fpga_axi_clock externallyDriven {false}
	set_instantiation_interface_parameter_value hps2fpga_axi_clock ptfSchematicName {}
	add_instantiation_interface_port hps2fpga_axi_clock hps2fpga_axi_clock_clk clk 1 STD_LOGIC Input
	add_instantiation_interface hps2fpga_axi_reset reset INPUT
	set_instantiation_interface_parameter_value hps2fpga_axi_reset associatedClock {}
	set_instantiation_interface_parameter_value hps2fpga_axi_reset synchronousEdges {NONE}
	add_instantiation_interface_port hps2fpga_axi_reset hps2fpga_axi_reset_reset reset 1 STD_LOGIC Input
	add_instantiation_interface hps2fpga axi4 OUTPUT
	set_instantiation_interface_parameter_value hps2fpga addressCheck {false}
	set_instantiation_interface_parameter_value hps2fpga associatedClock {hps2fpga_axi_clock}
	set_instantiation_interface_parameter_value hps2fpga associatedReset {hps2fpga_axi_reset}
	set_instantiation_interface_parameter_value hps2fpga combinedIssuingCapability {16}
	set_instantiation_interface_parameter_value hps2fpga dataCheck {false}
	set_instantiation_interface_parameter_value hps2fpga issuesFIXEDBursts {true}
	set_instantiation_interface_parameter_value hps2fpga issuesINCRBursts {true}
	set_instantiation_interface_parameter_value hps2fpga issuesWRAPBursts {true}
	set_instantiation_interface_parameter_value hps2fpga maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value hps2fpga maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value hps2fpga maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value hps2fpga poison {false}
	set_instantiation_interface_parameter_value hps2fpga readIssuingCapability {16}
	set_instantiation_interface_parameter_value hps2fpga securityAttribute {false}
	set_instantiation_interface_parameter_value hps2fpga traceSignals {false}
	set_instantiation_interface_parameter_value hps2fpga trustzoneAware {true}
	set_instantiation_interface_parameter_value hps2fpga uniqueIdSupport {false}
	set_instantiation_interface_parameter_value hps2fpga userData {false}
	set_instantiation_interface_parameter_value hps2fpga wakeupSignals {false}
	set_instantiation_interface_parameter_value hps2fpga writeIssuingCapability {16}
	add_instantiation_interface_port hps2fpga hps2fpga_awid awid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_awaddr awaddr 38 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_awlen awlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_awsize awsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_awburst awburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_awlock awlock 1 STD_LOGIC Output
	add_instantiation_interface_port hps2fpga hps2fpga_awcache awcache 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_awprot awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port hps2fpga hps2fpga_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port hps2fpga hps2fpga_wdata wdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_wstrb wstrb 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_wlast wlast 1 STD_LOGIC Output
	add_instantiation_interface_port hps2fpga hps2fpga_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port hps2fpga hps2fpga_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port hps2fpga hps2fpga_bid bid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port hps2fpga hps2fpga_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port hps2fpga hps2fpga_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port hps2fpga hps2fpga_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port hps2fpga hps2fpga_arid arid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_araddr araddr 38 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_arlen arlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_arsize arsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_arburst arburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_arlock arlock 1 STD_LOGIC Output
	add_instantiation_interface_port hps2fpga hps2fpga_arcache arcache 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port hps2fpga hps2fpga_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port hps2fpga hps2fpga_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port hps2fpga hps2fpga_rid rid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port hps2fpga hps2fpga_rdata rdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port hps2fpga hps2fpga_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port hps2fpga hps2fpga_rlast rlast 1 STD_LOGIC Input
	add_instantiation_interface_port hps2fpga hps2fpga_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port hps2fpga hps2fpga_rready rready 1 STD_LOGIC Output
	add_instantiation_interface lwhps2fpga_axi_clock clock INPUT
	set_instantiation_interface_parameter_value lwhps2fpga_axi_clock clockRate {0}
	set_instantiation_interface_parameter_value lwhps2fpga_axi_clock externallyDriven {false}
	set_instantiation_interface_parameter_value lwhps2fpga_axi_clock ptfSchematicName {}
	add_instantiation_interface_port lwhps2fpga_axi_clock lwhps2fpga_axi_clock_clk clk 1 STD_LOGIC Input
	add_instantiation_interface lwhps2fpga_axi_reset reset INPUT
	set_instantiation_interface_parameter_value lwhps2fpga_axi_reset associatedClock {}
	set_instantiation_interface_parameter_value lwhps2fpga_axi_reset synchronousEdges {NONE}
	add_instantiation_interface_port lwhps2fpga_axi_reset lwhps2fpga_axi_reset_reset reset 1 STD_LOGIC Input
	add_instantiation_interface lwhps2fpga axi4 OUTPUT
	set_instantiation_interface_parameter_value lwhps2fpga addressCheck {false}
	set_instantiation_interface_parameter_value lwhps2fpga associatedClock {lwhps2fpga_axi_clock}
	set_instantiation_interface_parameter_value lwhps2fpga associatedReset {lwhps2fpga_axi_reset}
	set_instantiation_interface_parameter_value lwhps2fpga combinedIssuingCapability {16}
	set_instantiation_interface_parameter_value lwhps2fpga dataCheck {false}
	set_instantiation_interface_parameter_value lwhps2fpga issuesFIXEDBursts {true}
	set_instantiation_interface_parameter_value lwhps2fpga issuesINCRBursts {true}
	set_instantiation_interface_parameter_value lwhps2fpga issuesWRAPBursts {true}
	set_instantiation_interface_parameter_value lwhps2fpga maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value lwhps2fpga maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value lwhps2fpga maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value lwhps2fpga poison {false}
	set_instantiation_interface_parameter_value lwhps2fpga readIssuingCapability {16}
	set_instantiation_interface_parameter_value lwhps2fpga securityAttribute {false}
	set_instantiation_interface_parameter_value lwhps2fpga traceSignals {false}
	set_instantiation_interface_parameter_value lwhps2fpga trustzoneAware {true}
	set_instantiation_interface_parameter_value lwhps2fpga uniqueIdSupport {false}
	set_instantiation_interface_parameter_value lwhps2fpga userData {false}
	set_instantiation_interface_parameter_value lwhps2fpga wakeupSignals {false}
	set_instantiation_interface_parameter_value lwhps2fpga writeIssuingCapability {16}
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_awid awid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_awaddr awaddr 29 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_awlen awlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_awsize awsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_awburst awburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_awlock awlock 1 STD_LOGIC Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_awcache awcache 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_awprot awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_wdata wdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_wstrb wstrb 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_wlast wlast 1 STD_LOGIC Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_bid bid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_arid arid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_araddr araddr 29 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_arlen arlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_arsize arsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_arburst arburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_arlock arlock 1 STD_LOGIC Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_arcache arcache 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_rid rid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_rdata rdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_rlast rlast 1 STD_LOGIC Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port lwhps2fpga lwhps2fpga_rready rready 1 STD_LOGIC Output
	add_instantiation_interface emac_ptp_clk clock INPUT
	set_instantiation_interface_parameter_value emac_ptp_clk clockRate {0}
	set_instantiation_interface_parameter_value emac_ptp_clk externallyDriven {false}
	set_instantiation_interface_parameter_value emac_ptp_clk ptfSchematicName {}
	add_instantiation_interface_port emac_ptp_clk emac_ptp_clk_clk clk 1 STD_LOGIC Input
	add_instantiation_interface emac_timestamp_clk clock INPUT
	set_instantiation_interface_parameter_value emac_timestamp_clk clockRate {0}
	set_instantiation_interface_parameter_value emac_timestamp_clk externallyDriven {false}
	set_instantiation_interface_parameter_value emac_timestamp_clk ptfSchematicName {}
	add_instantiation_interface_port emac_timestamp_clk emac_timestamp_clk_clk clk 1 STD_LOGIC Input
	add_instantiation_interface emac_timestamp_data conduit INPUT
	set_instantiation_interface_parameter_value emac_timestamp_data associatedClock {}
	set_instantiation_interface_parameter_value emac_timestamp_data associatedReset {}
	set_instantiation_interface_parameter_value emac_timestamp_data prSafe {false}
	add_instantiation_interface_port emac_timestamp_data emac_timestamp_data_data_in data_in 64 STD_LOGIC_VECTOR Input
	add_instantiation_interface emac0_app_rst reset OUTPUT
	set_instantiation_interface_parameter_value emac0_app_rst associatedClock {}
	set_instantiation_interface_parameter_value emac0_app_rst associatedDirectReset {}
	set_instantiation_interface_parameter_value emac0_app_rst associatedResetSinks {none}
	set_instantiation_interface_parameter_value emac0_app_rst synchronousEdges {NONE}
	add_instantiation_interface_port emac0_app_rst emac0_app_rst_reset_n reset_n 1 STD_LOGIC Output
	add_instantiation_interface emac0 conduit INPUT
	set_instantiation_interface_parameter_value emac0 associatedClock {}
	set_instantiation_interface_parameter_value emac0 associatedReset {}
	set_instantiation_interface_parameter_value emac0 prSafe {false}
	add_instantiation_interface_port emac0 emac0_mac_tx_clk_o mac_tx_clk_o 1 STD_LOGIC Output
	add_instantiation_interface_port emac0 emac0_mac_tx_clk_i mac_tx_clk_i 1 STD_LOGIC Input
	add_instantiation_interface_port emac0 emac0_mac_rx_clk mac_rx_clk 1 STD_LOGIC Input
	add_instantiation_interface_port emac0 emac0_mac_rst_tx_n mac_rst_tx_n 1 STD_LOGIC Output
	add_instantiation_interface_port emac0 emac0_mac_rst_rx_n mac_rst_rx_n 1 STD_LOGIC Output
	add_instantiation_interface_port emac0 emac0_mac_txen mac_txen 1 STD_LOGIC Output
	add_instantiation_interface_port emac0 emac0_mac_txer mac_txer 1 STD_LOGIC Output
	add_instantiation_interface_port emac0 emac0_mac_rxdv mac_rxdv 1 STD_LOGIC Input
	add_instantiation_interface_port emac0 emac0_mac_rxer mac_rxer 1 STD_LOGIC Input
	add_instantiation_interface_port emac0 emac0_mac_rxd mac_rxd 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port emac0 emac0_mac_col mac_col 1 STD_LOGIC Input
	add_instantiation_interface_port emac0 emac0_mac_crs mac_crs 1 STD_LOGIC Input
	add_instantiation_interface_port emac0 emac0_mac_speed mac_speed 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port emac0 emac0_mac_txd_o mac_txd_o 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface spim0 conduit INPUT
	set_instantiation_interface_parameter_value spim0 associatedClock {}
	set_instantiation_interface_parameter_value spim0 associatedReset {}
	set_instantiation_interface_parameter_value spim0 prSafe {false}
	add_instantiation_interface_port spim0 spim0_miso_i miso_i 1 STD_LOGIC Input
	add_instantiation_interface_port spim0 spim0_mosi_o mosi_o 1 STD_LOGIC Output
	add_instantiation_interface_port spim0 spim0_mosi_oe mosi_oe 1 STD_LOGIC Output
	add_instantiation_interface_port spim0 spim0_ss_in_n ss_in_n 1 STD_LOGIC Input
	add_instantiation_interface_port spim0 spim0_ss0_n_o ss0_n_o 1 STD_LOGIC Output
	add_instantiation_interface_port spim0 spim0_ss1_n_o ss1_n_o 1 STD_LOGIC Output
	add_instantiation_interface_port spim0 spim0_ss2_n_o ss2_n_o 1 STD_LOGIC Output
	add_instantiation_interface_port spim0 spim0_ss3_n_o ss3_n_o 1 STD_LOGIC Output
	add_instantiation_interface spim0_sclk_out clock OUTPUT
	set_instantiation_interface_parameter_value spim0_sclk_out associatedDirectClock {}
	set_instantiation_interface_parameter_value spim0_sclk_out clockRate {0}
	set_instantiation_interface_parameter_value spim0_sclk_out clockRateKnown {false}
	set_instantiation_interface_parameter_value spim0_sclk_out externallyDriven {false}
	set_instantiation_interface_parameter_value spim0_sclk_out ptfSchematicName {}
	set_instantiation_interface_sysinfo_parameter_value spim0_sclk_out clock_rate {0}
	add_instantiation_interface_port spim0_sclk_out spim0_sclk_out_clk clk 1 STD_LOGIC Output
	add_instantiation_interface uart0 conduit INPUT
	set_instantiation_interface_parameter_value uart0 associatedClock {}
	set_instantiation_interface_parameter_value uart0 associatedReset {}
	set_instantiation_interface_parameter_value uart0 prSafe {false}
	add_instantiation_interface_port uart0 uart0_cts_n cts_n 1 STD_LOGIC Input
	add_instantiation_interface_port uart0 uart0_dcd_n dcd_n 1 STD_LOGIC Input
	add_instantiation_interface_port uart0 uart0_dsr_n dsr_n 1 STD_LOGIC Input
	add_instantiation_interface_port uart0 uart0_dtr_n dtr_n 1 STD_LOGIC Output
	add_instantiation_interface_port uart0 uart0_out1_n out1_n 1 STD_LOGIC Output
	add_instantiation_interface_port uart0 uart0_out2_n out2_n 1 STD_LOGIC Output
	add_instantiation_interface_port uart0 uart0_ri_n ri_n 1 STD_LOGIC Input
	add_instantiation_interface_port uart0 uart0_rts_n rts_n 1 STD_LOGIC Output
	add_instantiation_interface_port uart0 uart0_rx rx 1 STD_LOGIC Input
	add_instantiation_interface_port uart0 uart0_tx tx 1 STD_LOGIC Output
	add_instantiation_interface I2C0_scl_i clock INPUT
	set_instantiation_interface_parameter_value I2C0_scl_i clockRate {0}
	set_instantiation_interface_parameter_value I2C0_scl_i externallyDriven {false}
	set_instantiation_interface_parameter_value I2C0_scl_i ptfSchematicName {}
	add_instantiation_interface_port I2C0_scl_i I2C0_scl_i_clk clk 1 STD_LOGIC Input
	add_instantiation_interface I2C0_scl_oe clock OUTPUT
	set_instantiation_interface_parameter_value I2C0_scl_oe associatedDirectClock {}
	set_instantiation_interface_parameter_value I2C0_scl_oe clockRate {0}
	set_instantiation_interface_parameter_value I2C0_scl_oe clockRateKnown {false}
	set_instantiation_interface_parameter_value I2C0_scl_oe externallyDriven {false}
	set_instantiation_interface_parameter_value I2C0_scl_oe ptfSchematicName {}
	set_instantiation_interface_sysinfo_parameter_value I2C0_scl_oe clock_rate {0}
	add_instantiation_interface_port I2C0_scl_oe I2C0_scl_oe_clk clk 1 STD_LOGIC Output
	add_instantiation_interface I2C0 conduit INPUT
	set_instantiation_interface_parameter_value I2C0 associatedClock {}
	set_instantiation_interface_parameter_value I2C0 associatedReset {}
	set_instantiation_interface_parameter_value I2C0 prSafe {false}
	add_instantiation_interface_port I2C0 I2C0_sda_i sda_i 1 STD_LOGIC Input
	add_instantiation_interface_port I2C0 I2C0_sda_oe sda_oe 1 STD_LOGIC Output
	add_instantiation_interface h2f_user0_clk clock OUTPUT
	set_instantiation_interface_parameter_value h2f_user0_clk associatedDirectClock {}
	set_instantiation_interface_parameter_value h2f_user0_clk clockRate {0}
	set_instantiation_interface_parameter_value h2f_user0_clk clockRateKnown {false}
	set_instantiation_interface_parameter_value h2f_user0_clk externallyDriven {false}
	set_instantiation_interface_parameter_value h2f_user0_clk ptfSchematicName {}
	set_instantiation_interface_sysinfo_parameter_value h2f_user0_clk clock_rate {0}
	add_instantiation_interface_port h2f_user0_clk h2f_user0_clk_clk clk 1 STD_LOGIC Output
	add_instantiation_interface h2f_user1_clk clock OUTPUT
	set_instantiation_interface_parameter_value h2f_user1_clk associatedDirectClock {}
	set_instantiation_interface_parameter_value h2f_user1_clk clockRate {0}
	set_instantiation_interface_parameter_value h2f_user1_clk clockRateKnown {false}
	set_instantiation_interface_parameter_value h2f_user1_clk externallyDriven {false}
	set_instantiation_interface_parameter_value h2f_user1_clk ptfSchematicName {}
	set_instantiation_interface_sysinfo_parameter_value h2f_user1_clk clock_rate {0}
	add_instantiation_interface_port h2f_user1_clk h2f_user1_clk_clk clk 1 STD_LOGIC Output
	add_instantiation_interface h2f_warm_reset_handshake conduit INPUT
	set_instantiation_interface_parameter_value h2f_warm_reset_handshake associatedClock {}
	set_instantiation_interface_parameter_value h2f_warm_reset_handshake associatedReset {}
	set_instantiation_interface_parameter_value h2f_warm_reset_handshake prSafe {false}
	add_instantiation_interface_port h2f_warm_reset_handshake h2f_warm_reset_handshake_reset_req reset_req 1 STD_LOGIC Output
	add_instantiation_interface_port h2f_warm_reset_handshake h2f_warm_reset_handshake_reset_ack reset_ack 1 STD_LOGIC Input
	add_instantiation_interface hps_io conduit INPUT
	set_instantiation_interface_parameter_value hps_io associatedClock {}
	set_instantiation_interface_parameter_value hps_io associatedReset {}
	set_instantiation_interface_parameter_value hps_io prSafe {false}
	add_instantiation_interface_port hps_io hps_io_hps_osc_clk hps_osc_clk 1 STD_LOGIC Input
	add_instantiation_interface_port hps_io hps_io_uart1_tx uart1_tx 1 STD_LOGIC Output
	add_instantiation_interface_port hps_io hps_io_uart1_rx uart1_rx 1 STD_LOGIC Input
	add_instantiation_interface fpga2hps_interrupt interrupt OUTPUT
	set_instantiation_interface_parameter_value fpga2hps_interrupt associatedAddressablePoint {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt associatedClock {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt associatedReset {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt irqMap {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt irqScheme {INDIVIDUAL_REQUESTS}
	add_instantiation_interface_port fpga2hps_interrupt fpga2hps_interrupt_irq irq 64 STD_LOGIC_VECTOR Input
	add_instantiation_interface f2sdram_axi_clock clock INPUT
	set_instantiation_interface_parameter_value f2sdram_axi_clock clockRate {0}
	set_instantiation_interface_parameter_value f2sdram_axi_clock externallyDriven {false}
	set_instantiation_interface_parameter_value f2sdram_axi_clock ptfSchematicName {}
	add_instantiation_interface_port f2sdram_axi_clock f2sdram_axi_clock_clk clk 1 STD_LOGIC Input
	add_instantiation_interface f2sdram_axi_reset reset INPUT
	set_instantiation_interface_parameter_value f2sdram_axi_reset associatedClock {}
	set_instantiation_interface_parameter_value f2sdram_axi_reset synchronousEdges {NONE}
	add_instantiation_interface_port f2sdram_axi_reset f2sdram_axi_reset_reset reset 1 STD_LOGIC Input
	add_instantiation_interface f2sdram axi4 INPUT
	set_instantiation_interface_parameter_value f2sdram addressCheck {false}
	set_instantiation_interface_parameter_value f2sdram associatedClock {f2sdram_axi_clock}
	set_instantiation_interface_parameter_value f2sdram associatedReset {f2sdram_axi_reset}
	set_instantiation_interface_parameter_value f2sdram bridgesToMaster {}
	set_instantiation_interface_parameter_value f2sdram combinedAcceptanceCapability {16}
	set_instantiation_interface_parameter_value f2sdram dataCheck {false}
	set_instantiation_interface_parameter_value f2sdram dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value f2sdram dfhFeatureId {35}
	set_instantiation_interface_parameter_value f2sdram dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value f2sdram dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value f2sdram dfhFeatureType {3}
	set_instantiation_interface_parameter_value f2sdram dfhGroupId {0}
	set_instantiation_interface_parameter_value f2sdram dfhParameterData {}
	set_instantiation_interface_parameter_value f2sdram dfhParameterDataLength {}
	set_instantiation_interface_parameter_value f2sdram dfhParameterId {}
	set_instantiation_interface_parameter_value f2sdram dfhParameterName {}
	set_instantiation_interface_parameter_value f2sdram dfhParameterVersion {}
	set_instantiation_interface_parameter_value f2sdram maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value f2sdram maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value f2sdram maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value f2sdram poison {false}
	set_instantiation_interface_parameter_value f2sdram readAcceptanceCapability {16}
	set_instantiation_interface_parameter_value f2sdram readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value f2sdram securityAttribute {false}
	set_instantiation_interface_parameter_value f2sdram traceSignals {false}
	set_instantiation_interface_parameter_value f2sdram trustzoneAware {true}
	set_instantiation_interface_parameter_value f2sdram uniqueIdSupport {false}
	set_instantiation_interface_parameter_value f2sdram userData {false}
	set_instantiation_interface_parameter_value f2sdram wakeupSignals {false}
	set_instantiation_interface_parameter_value f2sdram writeAcceptanceCapability {16}
	set_instantiation_interface_sysinfo_parameter_value f2sdram address_map {<address-map><slave name='f2sdram' start='0x0' end='0x100000000' datawidth='256' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value f2sdram address_width {32}
	set_instantiation_interface_sysinfo_parameter_value f2sdram max_slave_data_width {256}
	add_instantiation_interface_port f2sdram f2sdram_araddr araddr 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_arcache arcache 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_arid arid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_arlock arlock 1 STD_LOGIC Input
	add_instantiation_interface_port f2sdram f2sdram_arprot arprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_arqos arqos 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port f2sdram f2sdram_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port f2sdram f2sdram_awaddr awaddr 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_awcache awcache 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_awid awid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_awlock awlock 1 STD_LOGIC Input
	add_instantiation_interface_port f2sdram f2sdram_awprot awprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_awqos awqos 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port f2sdram f2sdram_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port f2sdram f2sdram_bid bid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port f2sdram f2sdram_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port f2sdram f2sdram_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port f2sdram f2sdram_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port f2sdram f2sdram_rdata rdata 256 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port f2sdram f2sdram_rid rid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port f2sdram f2sdram_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port f2sdram f2sdram_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port f2sdram f2sdram_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port f2sdram f2sdram_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port f2sdram f2sdram_wdata wdata 256 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port f2sdram f2sdram_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port f2sdram f2sdram_wstrb wstrb 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port f2sdram f2sdram_aruser aruser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_awuser awuser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_wuser wuser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_buser buser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port f2sdram f2sdram_arregion arregion 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port f2sdram f2sdram_ruser ruser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port f2sdram f2sdram_awregion awregion 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface fpga2hps_clock clock INPUT
	set_instantiation_interface_parameter_value fpga2hps_clock clockRate {0}
	set_instantiation_interface_parameter_value fpga2hps_clock externallyDriven {false}
	set_instantiation_interface_parameter_value fpga2hps_clock ptfSchematicName {}
	add_instantiation_interface_port fpga2hps_clock fpga2hps_clock_clk clk 1 STD_LOGIC Input
	add_instantiation_interface fpga2hps_reset reset INPUT
	set_instantiation_interface_parameter_value fpga2hps_reset associatedClock {}
	set_instantiation_interface_parameter_value fpga2hps_reset synchronousEdges {NONE}
	add_instantiation_interface_port fpga2hps_reset fpga2hps_reset_reset reset 1 STD_LOGIC Input
	add_instantiation_interface fpga2hps acelite INPUT
	set_instantiation_interface_parameter_value fpga2hps addressCheck {false}
	set_instantiation_interface_parameter_value fpga2hps associatedClock {fpga2hps_clock}
	set_instantiation_interface_parameter_value fpga2hps associatedReset {fpga2hps_reset}
	set_instantiation_interface_parameter_value fpga2hps bridgesToMaster {}
	set_instantiation_interface_parameter_value fpga2hps combinedAcceptanceCapability {16}
	set_instantiation_interface_parameter_value fpga2hps dataCheck {false}
	set_instantiation_interface_parameter_value fpga2hps dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value fpga2hps dfhFeatureId {35}
	set_instantiation_interface_parameter_value fpga2hps dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value fpga2hps dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value fpga2hps dfhFeatureType {3}
	set_instantiation_interface_parameter_value fpga2hps dfhGroupId {0}
	set_instantiation_interface_parameter_value fpga2hps dfhParameterData {}
	set_instantiation_interface_parameter_value fpga2hps dfhParameterDataLength {}
	set_instantiation_interface_parameter_value fpga2hps dfhParameterId {}
	set_instantiation_interface_parameter_value fpga2hps dfhParameterName {}
	set_instantiation_interface_parameter_value fpga2hps dfhParameterVersion {}
	set_instantiation_interface_parameter_value fpga2hps maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value fpga2hps maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value fpga2hps maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value fpga2hps poison {false}
	set_instantiation_interface_parameter_value fpga2hps readAcceptanceCapability {16}
	set_instantiation_interface_parameter_value fpga2hps readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value fpga2hps securityAttribute {false}
	set_instantiation_interface_parameter_value fpga2hps traceSignals {false}
	set_instantiation_interface_parameter_value fpga2hps trustzoneAware {true}
	set_instantiation_interface_parameter_value fpga2hps uniqueIdSupport {false}
	set_instantiation_interface_parameter_value fpga2hps userData {false}
	set_instantiation_interface_parameter_value fpga2hps wakeupSignals {false}
	set_instantiation_interface_parameter_value fpga2hps writeAcceptanceCapability {16}
	add_instantiation_interface_port fpga2hps fpga2hps_awid awid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awaddr awaddr 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awdomain awdomain 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awsnoop awsnoop 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awbar awbar 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awlock awlock 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_awcache awcache 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awprot awprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awqos awqos 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port fpga2hps fpga2hps_wdata wdata 256 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_wstrb wstrb 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port fpga2hps fpga2hps_bid bid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port fpga2hps fpga2hps_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port fpga2hps fpga2hps_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port fpga2hps fpga2hps_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_arid arid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_araddr araddr 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_ardomain ardomain 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arsnoop arsnoop 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arbar arbar 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arlock arlock 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_arcache arcache 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arprot arprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arqos arqos 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port fpga2hps fpga2hps_rid rid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port fpga2hps fpga2hps_rdata rdata 256 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port fpga2hps fpga2hps_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port fpga2hps fpga2hps_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port fpga2hps fpga2hps_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port fpga2hps fpga2hps_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_aruser aruser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awuser awuser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arregion arregion 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awregion awregion 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_wuser wuser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_buser buser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port fpga2hps fpga2hps_ruser ruser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface io96b0_csr_axi_clk clock INPUT
	set_instantiation_interface_parameter_value io96b0_csr_axi_clk clockRate {0}
	set_instantiation_interface_parameter_value io96b0_csr_axi_clk externallyDriven {false}
	set_instantiation_interface_parameter_value io96b0_csr_axi_clk ptfSchematicName {}
	add_instantiation_interface_port io96b0_csr_axi_clk io96b0_csr_axi_clk_clk clk 1 STD_LOGIC Input
	add_instantiation_interface io96b0_csr_axi_rst reset INPUT
	set_instantiation_interface_parameter_value io96b0_csr_axi_rst associatedClock {io96b0_csr_axi_clk}
	set_instantiation_interface_parameter_value io96b0_csr_axi_rst synchronousEdges {DEASSERT}
	add_instantiation_interface_port io96b0_csr_axi_rst io96b0_csr_axi_rst_reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface io96b0_csr_axi axi4lite OUTPUT
	set_instantiation_interface_parameter_value io96b0_csr_axi addressCheck {false}
	set_instantiation_interface_parameter_value io96b0_csr_axi associatedClock {io96b0_csr_axi_clk}
	set_instantiation_interface_parameter_value io96b0_csr_axi associatedReset {io96b0_csr_axi_rst}
	set_instantiation_interface_parameter_value io96b0_csr_axi combinedIssuingCapability {1}
	set_instantiation_interface_parameter_value io96b0_csr_axi dataCheck {false}
	set_instantiation_interface_parameter_value io96b0_csr_axi maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value io96b0_csr_axi maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value io96b0_csr_axi maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value io96b0_csr_axi poison {false}
	set_instantiation_interface_parameter_value io96b0_csr_axi readIssuingCapability {1}
	set_instantiation_interface_parameter_value io96b0_csr_axi securityAttribute {false}
	set_instantiation_interface_parameter_value io96b0_csr_axi traceSignals {false}
	set_instantiation_interface_parameter_value io96b0_csr_axi trustzoneAware {true}
	set_instantiation_interface_parameter_value io96b0_csr_axi uniqueIdSupport {false}
	set_instantiation_interface_parameter_value io96b0_csr_axi userData {false}
	set_instantiation_interface_parameter_value io96b0_csr_axi wakeupSignals {false}
	set_instantiation_interface_parameter_value io96b0_csr_axi writeIssuingCapability {1}
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_rdata rdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_araddr araddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_awaddr awaddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_rready rready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_wdata wdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_wstrb wstrb 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_csr_axi io96b0_csr_axi_awprot awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface io96b0_ch0_axi_clk clock INPUT
	set_instantiation_interface_parameter_value io96b0_ch0_axi_clk clockRate {0}
	set_instantiation_interface_parameter_value io96b0_ch0_axi_clk externallyDriven {false}
	set_instantiation_interface_parameter_value io96b0_ch0_axi_clk ptfSchematicName {}
	add_instantiation_interface_port io96b0_ch0_axi_clk io96b0_ch0_axi_clk_clk clk 1 STD_LOGIC Input
	add_instantiation_interface io96b0_ch0_axi_rst reset INPUT
	set_instantiation_interface_parameter_value io96b0_ch0_axi_rst associatedClock {io96b0_ch0_axi_clk}
	set_instantiation_interface_parameter_value io96b0_ch0_axi_rst synchronousEdges {DEASSERT}
	add_instantiation_interface_port io96b0_ch0_axi_rst io96b0_ch0_axi_rst_reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface io96b0_ch0_axi axi4 OUTPUT
	set_instantiation_interface_parameter_value io96b0_ch0_axi addressCheck {false}
	set_instantiation_interface_parameter_value io96b0_ch0_axi associatedClock {io96b0_ch0_axi_clk}
	set_instantiation_interface_parameter_value io96b0_ch0_axi associatedReset {io96b0_ch0_axi_rst}
	set_instantiation_interface_parameter_value io96b0_ch0_axi combinedIssuingCapability {1}
	set_instantiation_interface_parameter_value io96b0_ch0_axi dataCheck {false}
	set_instantiation_interface_parameter_value io96b0_ch0_axi issuesFIXEDBursts {true}
	set_instantiation_interface_parameter_value io96b0_ch0_axi issuesINCRBursts {true}
	set_instantiation_interface_parameter_value io96b0_ch0_axi issuesWRAPBursts {true}
	set_instantiation_interface_parameter_value io96b0_ch0_axi maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value io96b0_ch0_axi maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value io96b0_ch0_axi maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value io96b0_ch0_axi poison {false}
	set_instantiation_interface_parameter_value io96b0_ch0_axi readIssuingCapability {1}
	set_instantiation_interface_parameter_value io96b0_ch0_axi securityAttribute {false}
	set_instantiation_interface_parameter_value io96b0_ch0_axi traceSignals {false}
	set_instantiation_interface_parameter_value io96b0_ch0_axi trustzoneAware {true}
	set_instantiation_interface_parameter_value io96b0_ch0_axi uniqueIdSupport {false}
	set_instantiation_interface_parameter_value io96b0_ch0_axi userData {false}
	set_instantiation_interface_parameter_value io96b0_ch0_axi wakeupSignals {false}
	set_instantiation_interface_parameter_value io96b0_ch0_axi writeIssuingCapability {1}
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_bid bid 7 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_rdata rdata 256 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_rid rid 7 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_rlast rlast 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_ruser ruser 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_araddr araddr 44 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_arburst arburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_arid arid 7 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_arlen arlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_arlock arlock 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_arqos arqos 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_arsize arsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_aruser aruser 14 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awaddr awaddr 44 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awburst awburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awid awid 7 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awlen awlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awlock awlock 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awqos awqos 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awsize awsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awuser awuser 14 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_rready rready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_wdata wdata 256 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_wlast wlast 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_wstrb wstrb 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_wuser wuser 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_ch0_axi io96b0_ch0_axi_awprot awprot 3 STD_LOGIC_VECTOR Output
	save_instantiation
	add_component emif_bank3a_hps ip/no_pins_pd_top/emif_bank3a_hps.ip emif_hps_ph2 emif_bank3a_hps 6.2.0
	load_component emif_bank3a_hps
	set_component_parameter_value AXI4_USER_DATA_ENABLE {0}
	set_component_parameter_value AXI4_USER_DATA_ENABLE_AUTO_BOOL {1}
	set_component_parameter_value AXI_SIDEBAND_ACCESS_MODE {FABRIC}
	set_component_parameter_value AXI_SIDEBAND_ACCESS_MODE_AUTO_BOOL {1}
	set_component_parameter_value CTRL_AUTO_PRECHARGE_EN {0}
	set_component_parameter_value CTRL_ECC_AUTOCORRECT_EN {0}
	set_component_parameter_value CTRL_ECC_AUTOCORRECT_EN_AUTO_BOOL {1}
	set_component_parameter_value CTRL_ECC_MODE {CTRL_ECC_MODE_DISABLED}
	set_component_parameter_value CTRL_ECC_MODE_AUTO_BOOL {1}
	set_component_parameter_value CTRL_PERFORMANCE_PROFILE {CTRL_PERFORMANCE_PROFILE_TEMP1}
	set_component_parameter_value CTRL_PERFORMANCE_PROFILE_AUTO_BOOL {1}
	set_component_parameter_value CTRL_PHY_ONLY_EN {0}
	set_component_parameter_value CTRL_PHY_ONLY_EN_AUTO_BOOL {1}
	set_component_parameter_value CTRL_SCRAMBLER_EN {0}
	set_component_parameter_value DEBUG_TOOLS_EN {0}
	set_component_parameter_value DIAG_EXTRA_PARAMETERS {}
	set_component_parameter_value EX_DESIGN_CORE_CLK_FREQ_MHZ {200}
	set_component_parameter_value EX_DESIGN_CORE_CLK_FREQ_MHZ_AUTO_BOOL {1}
	set_component_parameter_value EX_DESIGN_CORE_REFCLK_FREQ_MHZ {100}
	set_component_parameter_value EX_DESIGN_GEN_BSI {0}
	set_component_parameter_value EX_DESIGN_GEN_CDC {0}
	set_component_parameter_value EX_DESIGN_GEN_SIM {1}
	set_component_parameter_value EX_DESIGN_GEN_SYNTH {1}
	set_component_parameter_value EX_DESIGN_HDL_FORMAT {HDL_FORMAT_VERILOG}
	set_component_parameter_value EX_DESIGN_HYDRA_PROG {emif_tg_emulation}
	set_component_parameter_value EX_DESIGN_HYDRA_REMOTE {CONFIG_INTF_MODE_REMOTE_JTAG}
	set_component_parameter_value EX_DESIGN_NOC_REFCLK_FREQ_MHZ {100}
	set_component_parameter_value EX_DESIGN_NOC_REFCLK_FREQ_MHZ_AUTO_BOOL {1}
	set_component_parameter_value EX_DESIGN_PMON_CH0_EN {0}
	set_component_parameter_value EX_DESIGN_PMON_CH1_EN {0}
	set_component_parameter_value EX_DESIGN_PMON_CH2_EN {0}
	set_component_parameter_value EX_DESIGN_PMON_CH3_EN {0}
	set_component_parameter_value EX_DESIGN_PMON_ENABLED {0}
	set_component_parameter_value EX_DESIGN_PMON_INTERNAL_JAMB {1}
	set_component_parameter_value GRP_MEM_DFE_AUTO_BOOL {1}
	set_component_parameter_value GRP_MEM_DFE_X_TAP_1 {MEM_DFE_TAP_1_LP5_5}
	set_component_parameter_value GRP_MEM_DFE_X_TAP_2 {MEM_DFE_TAP_2_0}
	set_component_parameter_value GRP_MEM_DFE_X_TAP_3 {MEM_DFE_TAP_3_0}
	set_component_parameter_value GRP_MEM_DFE_X_TAP_4 {MEM_DFE_TAP_4_0}
	set_component_parameter_value GRP_MEM_DQ_VREF_AUTO_BOOL {1}
	set_component_parameter_value GRP_MEM_DQ_VREF_X_RANGE {MEM_VREF_RANGE_DDR4_2}
	set_component_parameter_value GRP_MEM_DQ_VREF_X_VALUE {67.75}
	set_component_parameter_value GRP_MEM_ODT_CA_AUTO_BOOL {1}
	set_component_parameter_value GRP_MEM_ODT_CA_X_CA {MEM_RTT_CA_DDR5_6}
	set_component_parameter_value GRP_MEM_ODT_CA_X_CA_COMM {MEM_RTT_COMM_OFF}
	set_component_parameter_value GRP_MEM_ODT_CA_X_CA_ENABLE {MEM_RTT_COMM_EN_FALSE}
	set_component_parameter_value GRP_MEM_ODT_CA_X_CK {MEM_RTT_CA_DDR5_6}
	set_component_parameter_value GRP_MEM_ODT_CA_X_CK_ENABLE {MEM_RTT_COMM_EN_FALSE}
	set_component_parameter_value GRP_MEM_ODT_CA_X_CS {MEM_RTT_CA_DDR5_6}
	set_component_parameter_value GRP_MEM_ODT_CA_X_CS_ENABLE {MEM_RTT_COMM_EN_FALSE}
	set_component_parameter_value GRP_MEM_ODT_DQ_AUTO_BOOL {1}
	set_component_parameter_value GRP_MEM_ODT_DQ_X_IDLE {MEM_RTT_COMM_OFF}
	set_component_parameter_value GRP_MEM_ODT_DQ_X_NON_TGT {MEM_RTT_COMM_OFF}
	set_component_parameter_value GRP_MEM_ODT_DQ_X_NON_TGT_RD {MEM_RTT_COMM_OFF}
	set_component_parameter_value GRP_MEM_ODT_DQ_X_NON_TGT_WR {MEM_RTT_COMM_OFF}
	set_component_parameter_value GRP_MEM_ODT_DQ_X_RON {MEM_DRIVE_STRENGTH_7}
	set_component_parameter_value GRP_MEM_ODT_DQ_X_TGT_WR {MEM_RTT_COMM_4}
	set_component_parameter_value GRP_MEM_ODT_DQ_X_WCK {MEM_RTT_COMM_4}
	set_component_parameter_value GRP_MEM_RCD_AUTO_BOOL {1}
	set_component_parameter_value GRP_MEM_RCD_DCA_IBT {3}
	set_component_parameter_value GRP_MEM_RCD_DCKE_IBT {3}
	set_component_parameter_value GRP_MEM_RCD_DCK_IBT {3}
	set_component_parameter_value GRP_MEM_RCD_DCS_IBT {3}
	set_component_parameter_value GRP_MEM_RCD_DERROR_IBT {3}
	set_component_parameter_value GRP_MEM_RCD_DODT_IBT {3}
	set_component_parameter_value GRP_MEM_VREF_CA_AUTO_BOOL {1}
	set_component_parameter_value GRP_MEM_VREF_CA_X_CA_RANGE {MEM_CA_VREF_RANGE_LP4_2}
	set_component_parameter_value GRP_MEM_VREF_CA_X_CA_VALUE {50.0}
	set_component_parameter_value GRP_MEM_VREF_CA_X_CS_VALUE {50.0}
	set_component_parameter_value GRP_PHY_AC_AUTO_BOOL {1}
	set_component_parameter_value GRP_PHY_AC_X_R_S_AC_OUTPUT_OHM {RTT_PHY_OUT_34_CAL}
	set_component_parameter_value GRP_PHY_CLK_AUTO_BOOL {1}
	set_component_parameter_value GRP_PHY_CLK_X_R_S_CK_OUTPUT_OHM {RTT_PHY_OUT_34_CAL}
	set_component_parameter_value GRP_PHY_DATA_AUTO_BOOL {1}
	set_component_parameter_value GRP_PHY_DATA_X_DQS_IO_STD_TYPE {PHY_IO_STD_TYPE_DF_POD}
	set_component_parameter_value GRP_PHY_DATA_X_DQ_IO_STD_TYPE {PHY_IO_STD_TYPE_POD}
	set_component_parameter_value GRP_PHY_DATA_X_DQ_SLEW_RATE {PHY_SLEW_RATE_FASTEST}
	set_component_parameter_value GRP_PHY_DATA_X_DQ_VREF {68.3}
	set_component_parameter_value GRP_PHY_DATA_X_R_S_DQ_OUTPUT_OHM {RTT_PHY_OUT_34_CAL}
	set_component_parameter_value GRP_PHY_DATA_X_R_T_DQ_INPUT_OHM {RTT_PHY_IN_50_CAL}
	set_component_parameter_value GRP_PHY_DFE_AUTO_BOOL {1}
	set_component_parameter_value GRP_PHY_DFE_X_TAP_1 {PHY_DFE_TAP_1_LP5_0}
	set_component_parameter_value GRP_PHY_DFE_X_TAP_2 {PHY_DFE_TAP_2_3_LP5_0}
	set_component_parameter_value GRP_PHY_DFE_X_TAP_3 {PHY_DFE_TAP_2_3_LP5_0}
	set_component_parameter_value GRP_PHY_DFE_X_TAP_4 {PHY_DFE_TAP_4_LP5_0}
	set_component_parameter_value GRP_PHY_IN_AUTO_BOOL {1}
	set_component_parameter_value GRP_PHY_IN_X_R_T_REFCLK_INPUT_OHM {LVDS_DIFF_TERM_ON}
	set_component_parameter_value HMC_ADDR_SWAP {0}
	set_component_parameter_value HPS_EMIF_CONFIG {HPS_EMIF_1x32}
	set_component_parameter_value HPS_EMIF_CONFIG_AUTO_BOOL {0}
	set_component_parameter_value INSTANCE_ID {0}
	set_component_parameter_value INSTANCE_ID_IP0 {0}
	set_component_parameter_value INSTANCE_ID_IP1 {1}
	set_component_parameter_value MEM_AC_MIRRORING {0}
	set_component_parameter_value MEM_AC_MIRRORING_AUTO_BOOL {1}
	set_component_parameter_value MEM_COMPS_PER_RANK {2}
	set_component_parameter_value MEM_DEVICE_DQ_WIDTH {16}
	set_component_parameter_value MEM_FORMAT {MEM_FORMAT_DISCRETE}
	set_component_parameter_value MEM_NUM_CHANNELS {1}
	set_component_parameter_value MEM_NUM_RANKS {2}
	set_component_parameter_value MEM_PRESET_FILE_EN {0}
	set_component_parameter_value MEM_PRESET_FILE_EN_FSP0 {0}
	set_component_parameter_value MEM_PRESET_FILE_EN_FSP1 {0}
	set_component_parameter_value MEM_PRESET_FILE_EN_FSP2 {0}
	set_component_parameter_value MEM_PRESET_FILE_QPRS {/work/test.qprs}
	set_component_parameter_value MEM_PRESET_FILE_QPRS_FSP0 {mem_preset_file_qprs_fsp0.qprs}
	set_component_parameter_value MEM_PRESET_FILE_QPRS_FSP1 {mem_preset_file_qprs_fsp1.qprs}
	set_component_parameter_value MEM_PRESET_FILE_QPRS_FSP2 {mem_preset_file_qprs_fsp2.qprs}
	set_component_parameter_value MEM_PRESET_ID {mt53e2g32d4_mem_config}
	set_component_parameter_value MEM_PRESET_ID_AUTO_BOOL {0}
	set_component_parameter_value MEM_PRESET_ID_FSP0 {{No Presets Found}}
	set_component_parameter_value MEM_PRESET_ID_FSP0_AUTO_BOOL {1}
	set_component_parameter_value MEM_PRESET_ID_FSP1 {{No Presets Found}}
	set_component_parameter_value MEM_PRESET_ID_FSP1_AUTO_BOOL {1}
	set_component_parameter_value MEM_PRESET_ID_FSP2 {{No Presets Found}}
	set_component_parameter_value MEM_PRESET_ID_FSP2_AUTO_BOOL {1}
	set_component_parameter_value MEM_RANKS_SHARE_CLOCKS {0}
	set_component_parameter_value MEM_TECHNOLOGY {MEM_TECHNOLOGY_LPDDR4}
	set_component_parameter_value MEM_TECHNOLOGY_AUTO_BOOL {0}
	set_component_parameter_value MEM_TECH_IS_X {0}
	set_component_parameter_value MEM_TOPOLOGY {MEM_TOPOLOGY_FLYBY}
	set_component_parameter_value MEM_USER_READ_LATENCY_CYC {5}
	set_component_parameter_value MEM_USER_READ_LATENCY_CYC_AUTO_BOOL {1}
	set_component_parameter_value MEM_USER_WRITE_LATENCY_CYC {10}
	set_component_parameter_value MEM_USER_WRITE_LATENCY_CYC_AUTO_BOOL {1}
	set_component_parameter_value PHY_AC_PLACEMENT {PHY_AC_PLACEMENT_AUTO}
	set_component_parameter_value PHY_AC_PLACEMENT_AUTO_BOOL {1}
	set_component_parameter_value PHY_ALERT_N_PLACEMENT {PHY_ALERT_N_PLACEMENT_AC2}
	set_component_parameter_value PHY_ASYNC_EN {1}
	set_component_parameter_value PHY_FSP0_EN {1}
	set_component_parameter_value PHY_FSP1_EN {0}
	set_component_parameter_value PHY_FSP2_EN {0}
	set_component_parameter_value PHY_MEMCLK_FREQ_MHZ {800.0}
	set_component_parameter_value PHY_MEMCLK_FREQ_MHZ_AUTO_BOOL {0}
	set_component_parameter_value PHY_MEMCLK_FSP0_FREQ_MHZ {1600.0}
	set_component_parameter_value PHY_MEMCLK_FSP0_FREQ_MHZ_AUTO_BOOL {1}
	set_component_parameter_value PHY_MEMCLK_FSP1_FREQ_MHZ {1600.0}
	set_component_parameter_value PHY_MEMCLK_FSP1_FREQ_MHZ_AUTO_BOOL {1}
	set_component_parameter_value PHY_MEMCLK_FSP2_FREQ_MHZ {1600.0}
	set_component_parameter_value PHY_MEMCLK_FSP2_FREQ_MHZ_AUTO_BOOL {1}
	set_component_parameter_value PHY_NOC_EN {0}
	set_component_parameter_value PHY_NOC_EN_AUTO_BOOL {1}
	set_component_parameter_value PHY_REFCLK_FREQ_MHZ {100.0}
	set_component_parameter_value PHY_REFCLK_FREQ_MHZ_AUTO_BOOL {0}
	set_component_parameter_value SHOW_INTERNAL_SETTINGS {0}
	set_component_parameter_value SHOW_LPDDR4 {0}
	set_component_parameter_value USER_EXTRA_PARAMETERS {}
	set_component_parameter_value USER_MIN_NUM_AC_LANES {3}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation emif_bank3a_hps
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface usr_clk_0 clock OUTPUT
	set_instantiation_interface_parameter_value usr_clk_0 associatedDirectClock {}
	set_instantiation_interface_parameter_value usr_clk_0 clockRate {0}
	set_instantiation_interface_parameter_value usr_clk_0 clockRateKnown {false}
	set_instantiation_interface_parameter_value usr_clk_0 externallyDriven {false}
	set_instantiation_interface_parameter_value usr_clk_0 ptfSchematicName {}
	set_instantiation_interface_sysinfo_parameter_value usr_clk_0 clock_rate {0}
	add_instantiation_interface_port usr_clk_0 noc_aclk_0 clk 1 STD_LOGIC Output
	add_instantiation_interface s0_axi4 axi4 INPUT
	set_instantiation_interface_parameter_value s0_axi4 addressCheck {false}
	set_instantiation_interface_parameter_value s0_axi4 associatedClock {usr_clk_0}
	set_instantiation_interface_parameter_value s0_axi4 associatedReset {usr_rst_n_0}
	set_instantiation_interface_parameter_value s0_axi4 bridgesToMaster {}
	set_instantiation_interface_parameter_value s0_axi4 combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value s0_axi4 dataCheck {false}
	set_instantiation_interface_parameter_value s0_axi4 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s0_axi4 dfhFeatureId {35}
	set_instantiation_interface_parameter_value s0_axi4 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s0_axi4 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s0_axi4 dfhFeatureType {3}
	set_instantiation_interface_parameter_value s0_axi4 dfhGroupId {0}
	set_instantiation_interface_parameter_value s0_axi4 dfhParameterData {}
	set_instantiation_interface_parameter_value s0_axi4 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s0_axi4 dfhParameterId {}
	set_instantiation_interface_parameter_value s0_axi4 dfhParameterName {}
	set_instantiation_interface_parameter_value s0_axi4 dfhParameterVersion {}
	set_instantiation_interface_parameter_value s0_axi4 maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value s0_axi4 maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value s0_axi4 maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value s0_axi4 poison {false}
	set_instantiation_interface_parameter_value s0_axi4 readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value s0_axi4 readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value s0_axi4 securityAttribute {false}
	set_instantiation_interface_parameter_value s0_axi4 traceSignals {false}
	set_instantiation_interface_parameter_value s0_axi4 trustzoneAware {true}
	set_instantiation_interface_parameter_value s0_axi4 uniqueIdSupport {false}
	set_instantiation_interface_parameter_value s0_axi4 userData {false}
	set_instantiation_interface_parameter_value s0_axi4 wakeupSignals {false}
	set_instantiation_interface_parameter_value s0_axi4 writeAcceptanceCapability {1}
	set_instantiation_interface_assignment_value s0_axi4 default_mem_technology {MEM_TECHNOLOGY_LPDDR4}
	set_instantiation_interface_assignment_value s0_axi4 mem_capacity_gbits {64}
	set_instantiation_interface_sysinfo_parameter_value s0_axi4 address_map {<address-map><slave name='s0_axi4' start='0x0' end='0x10000000000' datawidth='256' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value s0_axi4 address_width {40}
	set_instantiation_interface_sysinfo_parameter_value s0_axi4 max_slave_data_width {256}
	add_instantiation_interface_port s0_axi4 s0_axi4_araddr araddr 40 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_arburst arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_arid arid 7 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_arlen arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_arlock arlock 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axi4 s0_axi4_arqos arqos 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_arsize arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axi4 s0_axi4_aruser aruser 14 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_arprot arprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_awaddr awaddr 40 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_awburst awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_awid awid 7 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_awlen awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_awlock awlock 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axi4 s0_axi4_awqos awqos 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_awsize awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axi4 s0_axi4_awuser awuser 14 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_awprot awprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axi4 s0_axi4_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axi4 s0_axi4_wdata wdata 256 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_wstrb wstrb 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_wlast wlast 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axi4 s0_axi4_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axi4 s0_axi4_wuser wuser 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axi4 s0_axi4_ruser ruser 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0_axi4 s0_axi4_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port s0_axi4 s0_axi4_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port s0_axi4 s0_axi4_bid bid 7 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0_axi4 s0_axi4_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0_axi4 s0_axi4_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port s0_axi4 s0_axi4_rdata rdata 256 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0_axi4 s0_axi4_rid rid 7 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0_axi4 s0_axi4_rlast rlast 1 STD_LOGIC Output
	add_instantiation_interface_port s0_axi4 s0_axi4_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0_axi4 s0_axi4_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port s0_axi4 s0_axi4_wready wready 1 STD_LOGIC Output
	add_instantiation_interface emif_mem_0 conduit INPUT
	set_instantiation_interface_parameter_value emif_mem_0 associatedClock {}
	set_instantiation_interface_parameter_value emif_mem_0 associatedReset {}
	set_instantiation_interface_parameter_value emif_mem_0 prSafe {false}
	add_instantiation_interface_port emif_mem_0 emif_mem_0_mem_ck_t mem_ck_t 1 STD_LOGIC Output
	add_instantiation_interface_port emif_mem_0 emif_mem_0_mem_ck_c mem_ck_c 1 STD_LOGIC Output
	add_instantiation_interface_port emif_mem_0 emif_mem_0_mem_cke mem_cke 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port emif_mem_0 emif_mem_0_mem_reset_n mem_reset_n 1 STD_LOGIC Output
	add_instantiation_interface_port emif_mem_0 emif_mem_0_mem_cs mem_cs 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port emif_mem_0 emif_mem_0_mem_ca mem_ca 6 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port emif_mem_0 emif_mem_0_mem_dq mem_dq 32 STD_LOGIC_VECTOR Bidir
	add_instantiation_interface_port emif_mem_0 emif_mem_0_mem_dqs_t mem_dqs_t 4 STD_LOGIC_VECTOR Bidir
	add_instantiation_interface_port emif_mem_0 emif_mem_0_mem_dqs_c mem_dqs_c 4 STD_LOGIC_VECTOR Bidir
	add_instantiation_interface_port emif_mem_0 emif_mem_0_mem_dmi mem_dmi 4 STD_LOGIC_VECTOR Bidir
	add_instantiation_interface emif_oct_0 conduit INPUT
	set_instantiation_interface_parameter_value emif_oct_0 associatedClock {}
	set_instantiation_interface_parameter_value emif_oct_0 associatedReset {}
	set_instantiation_interface_parameter_value emif_oct_0 prSafe {false}
	add_instantiation_interface_port emif_oct_0 emif_oct_0_oct_rzqin oct_rzqin 1 STD_LOGIC Input
	add_instantiation_interface s0_axil_clk clock OUTPUT
	set_instantiation_interface_parameter_value s0_axil_clk associatedDirectClock {}
	set_instantiation_interface_parameter_value s0_axil_clk clockRate {0}
	set_instantiation_interface_parameter_value s0_axil_clk clockRateKnown {false}
	set_instantiation_interface_parameter_value s0_axil_clk externallyDriven {false}
	set_instantiation_interface_parameter_value s0_axil_clk ptfSchematicName {}
	set_instantiation_interface_sysinfo_parameter_value s0_axil_clk clock_rate {0}
	add_instantiation_interface_port s0_axil_clk s0_noc_axi4lite_clk clk 1 STD_LOGIC Output
	add_instantiation_interface s0_axil_rst_n reset OUTPUT
	set_instantiation_interface_parameter_value s0_axil_rst_n associatedClock {s0_axil_clk}
	set_instantiation_interface_parameter_value s0_axil_rst_n associatedDirectReset {}
	set_instantiation_interface_parameter_value s0_axil_rst_n associatedResetSinks {none}
	set_instantiation_interface_parameter_value s0_axil_rst_n synchronousEdges {DEASSERT}
	add_instantiation_interface_port s0_axil_rst_n s0_noc_axi4lite_rst_n reset_n 1 STD_LOGIC Output
	add_instantiation_interface s0_axil axi4lite INPUT
	set_instantiation_interface_parameter_value s0_axil addressCheck {false}
	set_instantiation_interface_parameter_value s0_axil associatedClock {s0_axil_clk}
	set_instantiation_interface_parameter_value s0_axil associatedReset {s0_axil_rst_n}
	set_instantiation_interface_parameter_value s0_axil bridgesToMaster {}
	set_instantiation_interface_parameter_value s0_axil combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value s0_axil dataCheck {false}
	set_instantiation_interface_parameter_value s0_axil dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s0_axil dfhFeatureId {35}
	set_instantiation_interface_parameter_value s0_axil dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s0_axil dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s0_axil dfhFeatureType {3}
	set_instantiation_interface_parameter_value s0_axil dfhGroupId {0}
	set_instantiation_interface_parameter_value s0_axil dfhParameterData {}
	set_instantiation_interface_parameter_value s0_axil dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s0_axil dfhParameterId {}
	set_instantiation_interface_parameter_value s0_axil dfhParameterName {}
	set_instantiation_interface_parameter_value s0_axil dfhParameterVersion {}
	set_instantiation_interface_parameter_value s0_axil maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value s0_axil maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value s0_axil maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value s0_axil poison {false}
	set_instantiation_interface_parameter_value s0_axil readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value s0_axil readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value s0_axil securityAttribute {false}
	set_instantiation_interface_parameter_value s0_axil traceSignals {false}
	set_instantiation_interface_parameter_value s0_axil trustzoneAware {true}
	set_instantiation_interface_parameter_value s0_axil uniqueIdSupport {false}
	set_instantiation_interface_parameter_value s0_axil userData {false}
	set_instantiation_interface_parameter_value s0_axil wakeupSignals {false}
	set_instantiation_interface_parameter_value s0_axil writeAcceptanceCapability {1}
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_awaddr awaddr 27 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_awvalid awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_awready awready 1 STD_LOGIC Output
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_wdata wdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_wstrb wstrb 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_wvalid wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_wready wready 1 STD_LOGIC Output
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_araddr araddr 27 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_arvalid arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_arready arready 1 STD_LOGIC Output
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_rdata rdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_rresp rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_rvalid rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_rready rready 1 STD_LOGIC Input
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_awprot awprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0_axil s0_noc_axi4lite_arprot arprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface usr_rst_n_0 reset OUTPUT
	set_instantiation_interface_parameter_value usr_rst_n_0 associatedClock {}
	set_instantiation_interface_parameter_value usr_rst_n_0 associatedDirectReset {}
	set_instantiation_interface_parameter_value usr_rst_n_0 associatedResetSinks {none}
	set_instantiation_interface_parameter_value usr_rst_n_0 synchronousEdges {NONE}
	add_instantiation_interface_port usr_rst_n_0 out_reset_0_n reset_n 1 STD_LOGIC Output
	add_instantiation_interface emif_ref_clk_0 clock INPUT
	set_instantiation_interface_parameter_value emif_ref_clk_0 clockRate {0}
	set_instantiation_interface_parameter_value emif_ref_clk_0 externallyDriven {false}
	set_instantiation_interface_parameter_value emif_ref_clk_0 ptfSchematicName {}
	add_instantiation_interface_port emif_ref_clk_0 emif_ref_clk_0_clk clk 1 STD_LOGIC Input
	save_instantiation

	# add wirelevel expressions

	# preserve ports for debug

	# add the connections
	add_connection agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 addressMapSysInfo {}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 addressWidthSysInfo {}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 arbitrationPriority {1}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 baseAddress {0x0000}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 defaultConnection {0}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 domainAlias {}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value agilex_5_soc.io96b0_ch0_axi/emif_bank3a_hps.s0_axi4 slaveDataWidthSysInfo {-1}
	add_connection agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil addressMapSysInfo {}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil addressWidthSysInfo {}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil arbitrationPriority {1}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil baseAddress {0x0000}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil defaultConnection {0}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil domainAlias {}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.syncResets {TRUE}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value agilex_5_soc.io96b0_csr_axi/emif_bank3a_hps.s0_axil slaveDataWidthSysInfo {-1}
	add_connection emif_bank3a_hps.s0_axil_clk/agilex_5_soc.io96b0_csr_axi_clk
	set_connection_parameter_value emif_bank3a_hps.s0_axil_clk/agilex_5_soc.io96b0_csr_axi_clk clockDomainSysInfo {-1}
	set_connection_parameter_value emif_bank3a_hps.s0_axil_clk/agilex_5_soc.io96b0_csr_axi_clk clockRateSysInfo {-1.0}
	set_connection_parameter_value emif_bank3a_hps.s0_axil_clk/agilex_5_soc.io96b0_csr_axi_clk clockResetSysInfo {}
	set_connection_parameter_value emif_bank3a_hps.s0_axil_clk/agilex_5_soc.io96b0_csr_axi_clk resetDomainSysInfo {-1}
	add_connection emif_bank3a_hps.s0_axil_rst_n/agilex_5_soc.io96b0_csr_axi_rst
	set_connection_parameter_value emif_bank3a_hps.s0_axil_rst_n/agilex_5_soc.io96b0_csr_axi_rst clockDomainSysInfo {-1}
	set_connection_parameter_value emif_bank3a_hps.s0_axil_rst_n/agilex_5_soc.io96b0_csr_axi_rst clockResetSysInfo {}
	set_connection_parameter_value emif_bank3a_hps.s0_axil_rst_n/agilex_5_soc.io96b0_csr_axi_rst resetDomainSysInfo {-1}
	add_connection emif_bank3a_hps.usr_clk_0/agilex_5_soc.io96b0_ch0_axi_clk
	set_connection_parameter_value emif_bank3a_hps.usr_clk_0/agilex_5_soc.io96b0_ch0_axi_clk clockDomainSysInfo {-1}
	set_connection_parameter_value emif_bank3a_hps.usr_clk_0/agilex_5_soc.io96b0_ch0_axi_clk clockRateSysInfo {-1.0}
	set_connection_parameter_value emif_bank3a_hps.usr_clk_0/agilex_5_soc.io96b0_ch0_axi_clk clockResetSysInfo {}
	set_connection_parameter_value emif_bank3a_hps.usr_clk_0/agilex_5_soc.io96b0_ch0_axi_clk resetDomainSysInfo {-1}
	add_connection emif_bank3a_hps.usr_rst_n_0/agilex_5_soc.io96b0_ch0_axi_rst
	set_connection_parameter_value emif_bank3a_hps.usr_rst_n_0/agilex_5_soc.io96b0_ch0_axi_rst clockDomainSysInfo {-1}
	set_connection_parameter_value emif_bank3a_hps.usr_rst_n_0/agilex_5_soc.io96b0_ch0_axi_rst clockResetSysInfo {}
	set_connection_parameter_value emif_bank3a_hps.usr_rst_n_0/agilex_5_soc.io96b0_ch0_axi_rst resetDomainSysInfo {-1}

	# add the exports
	set_interface_property agilex_5_soc_h2f_reset EXPORT_OF agilex_5_soc.h2f_reset
	set_interface_property agilex_5_soc_hps_gp EXPORT_OF agilex_5_soc.hps_gp
	set_interface_property agilex_5_soc_hps2fpga_axi_clock EXPORT_OF agilex_5_soc.hps2fpga_axi_clock
	set_interface_property agilex_5_soc_hps2fpga_axi_reset EXPORT_OF agilex_5_soc.hps2fpga_axi_reset
	set_interface_property agilex_5_soc_hps2fpga EXPORT_OF agilex_5_soc.hps2fpga
	set_interface_property agilex_5_soc_lwhps2fpga_axi_clock EXPORT_OF agilex_5_soc.lwhps2fpga_axi_clock
	set_interface_property agilex_5_soc_lwhps2fpga_axi_reset EXPORT_OF agilex_5_soc.lwhps2fpga_axi_reset
	set_interface_property agilex_5_soc_lwhps2fpga EXPORT_OF agilex_5_soc.lwhps2fpga
	set_interface_property agilex_5_soc_emac_ptp_clk EXPORT_OF agilex_5_soc.emac_ptp_clk
	set_interface_property agilex_5_soc_emac_timestamp_clk EXPORT_OF agilex_5_soc.emac_timestamp_clk
	set_interface_property agilex_5_soc_emac_timestamp_data EXPORT_OF agilex_5_soc.emac_timestamp_data
	set_interface_property agilex_5_soc_emac0_app_rst EXPORT_OF agilex_5_soc.emac0_app_rst
	set_interface_property agilex_5_soc_emac0 EXPORT_OF agilex_5_soc.emac0
	set_interface_property agilex_5_soc_spim0 EXPORT_OF agilex_5_soc.spim0
	set_interface_property agilex_5_soc_spim0_sclk_out EXPORT_OF agilex_5_soc.spim0_sclk_out
	set_interface_property agilex_5_soc_uart0 EXPORT_OF agilex_5_soc.uart0
	set_interface_property agilex_5_soc_I2C0_scl_i EXPORT_OF agilex_5_soc.I2C0_scl_i
	set_interface_property agilex_5_soc_I2C0_scl_oe EXPORT_OF agilex_5_soc.I2C0_scl_oe
	set_interface_property agilex_5_soc_I2C0 EXPORT_OF agilex_5_soc.I2C0
	set_interface_property agilex_5_soc_h2f_user0_clk EXPORT_OF agilex_5_soc.h2f_user0_clk
	set_interface_property agilex_5_soc_h2f_user1_clk EXPORT_OF agilex_5_soc.h2f_user1_clk
	set_interface_property agilex_5_soc_hps_io EXPORT_OF agilex_5_soc.hps_io
	set_interface_property agilex_5_soc_fpga2hps_interrupt EXPORT_OF agilex_5_soc.fpga2hps_interrupt
	set_interface_property agilex_5_soc_f2sdram_axi_clock EXPORT_OF agilex_5_soc.f2sdram_axi_clock
	set_interface_property agilex_5_soc_f2sdram_axi_reset EXPORT_OF agilex_5_soc.f2sdram_axi_reset
	set_interface_property agilex_5_soc_f2sdram EXPORT_OF agilex_5_soc.f2sdram
	set_interface_property agilex_5_soc_fpga2hps_clock EXPORT_OF agilex_5_soc.fpga2hps_clock
	set_interface_property agilex_5_soc_fpga2hps_reset EXPORT_OF agilex_5_soc.fpga2hps_reset
	set_interface_property agilex_5_soc_fpga2hps EXPORT_OF agilex_5_soc.fpga2hps
	set_interface_property emif_bank3a_hps_emif_mem_0 EXPORT_OF emif_bank3a_hps.emif_mem_0
	set_interface_property emif_bank3a_hps_emif_oct_0 EXPORT_OF emif_bank3a_hps.emif_oct_0
	set_interface_property emif_bank3a_hps_emif_ref_clk_0 EXPORT_OF emif_bank3a_hps.emif_ref_clk_0

	# set values for exposed HDL parameters
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.enableAllPipelines FALSE
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.enableEccProtection FALSE
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.enableInstrumentation FALSE
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.interconnectType STANDARD
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.maxAdditionalLatency 1
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.syncResets TRUE
	set_domain_assignment agilex_5_soc.io96b0_ch0_axi qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.enableAllPipelines FALSE
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.enableEccProtection FALSE
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.enableInstrumentation FALSE
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.interconnectType STANDARD
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.maxAdditionalLatency 1
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.syncResets TRUE
	set_domain_assignment agilex_5_soc.io96b0_csr_axi qsys_mm.widthAdapterImplementation GENERIC_CONVERTER

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="agilex_5_soc">
  <datum __value="_sortIndex" value="0" type="int" />
 </element>
 <element __value="emif_bank3a_hps">
  <datum __value="_sortIndex" value="1" type="int" />
 </element>
</bonusData>
}
	set_module_property FILE {no_pins_hps.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {no_pins_hps}

	# save the system
	sync_sysinfo_parameters
	save_system no_pins_hps
}
