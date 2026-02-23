#
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
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
	add_component agilex_5_soc ip/no_pins_hps/agilex_5_soc.ip intel_agilex_5_soc agilex_5_soc 13.0.0
	load_component agilex_5_soc
	set_component_parameter_value ATB_Enable {0}
	set_component_parameter_value CM_Mode {N/A}
	set_component_parameter_value CM_PinMuxing {Unused}
	set_component_parameter_value CTI_Enable {0}
	set_component_parameter_value DMA_Enable {No No No No No No No No}
	set_component_parameter_value Debug_APB_Enable {0}
	set_component_parameter_value ED_en_questa {1}
	set_component_parameter_value ED_en_riviera {0}
	set_component_parameter_value ED_en_sim_gen {1}
	set_component_parameter_value ED_en_synth_gen {0}
	set_component_parameter_value ED_en_vcsmx {1}
	set_component_parameter_value ED_en_xcelium {1}
	set_component_parameter_value ED_f2h_addr_width {38}
	set_component_parameter_value ED_f2h_connectivity {1}
	set_component_parameter_value ED_f2h_data_width {256}
	set_component_parameter_value ED_f2h_packet_size {1}
	set_component_parameter_value ED_f2h_traffic_pattern {0}
	set_component_parameter_value ED_f2sdram_addr_width {40}
	set_component_parameter_value ED_f2sdram_connectivity {1}
	set_component_parameter_value ED_f2sdram_data_width {256}
	set_component_parameter_value ED_f2sdram_packet_size {1}
	set_component_parameter_value ED_f2sdram_traffic_pattern {0}
	set_component_parameter_value ED_h2f_addr_width {26}
	set_component_parameter_value ED_h2f_connectivity {1}
	set_component_parameter_value ED_h2f_data_width {128}
	set_component_parameter_value ED_h2f_packet_size {1}
	set_component_parameter_value ED_h2f_traffic_pattern {0}
	set_component_parameter_value ED_lwh2f_addr_width {26}
	set_component_parameter_value ED_lwh2f_connectivity {1}
	set_component_parameter_value ED_lwh2f_data_width {32}
	set_component_parameter_value ED_lwh2f_packet_size {1}
	set_component_parameter_value ED_lwh2f_traffic_pattern {0}
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
	set_component_parameter_value F2H_free_clk_mhz {125}
	set_component_parameter_value F2H_free_clock_enable {0}
	set_component_parameter_value FPGA_EMAC0_gtx_clk_mhz {125.0}
	set_component_parameter_value FPGA_EMAC0_md_clk_mhz {2.5}
	set_component_parameter_value FPGA_EMAC0_tx_clk_en {1}
	set_component_parameter_value FPGA_EMAC1_gtx_clk_mhz {125.0}
	set_component_parameter_value FPGA_EMAC1_md_clk_mhz {2.5}
	set_component_parameter_value FPGA_EMAC1_tx_clk_en {1}
	set_component_parameter_value FPGA_EMAC2_gtx_clk_mhz {125.0}
	set_component_parameter_value FPGA_EMAC2_md_clk_mhz {2.5}
	set_component_parameter_value FPGA_EMAC2_tx_clk_en {1}
	set_component_parameter_value FPGA_EMAC_PTP_clk_en {1}
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
	set_component_parameter_value HPS_IO_Enable {NONE NONE UART0:TX UART0:RX NONE NONE NONE NONE NONE NONE NONE HCLK:HPS_OSC_CLK NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE NONE}
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
	set_component_parameter_value Pwr_boot_core_sel {2}
	set_component_parameter_value Pwr_cpu_app_select {0}
	set_component_parameter_value Pwr_mpu_l3_cache_size {2}
	set_component_parameter_value Pwr_override_cache_size {0}
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
	set_component_parameter_value UART0_Mode {No_flow_control}
	set_component_parameter_value UART0_PinMuxing {IO}
	set_component_parameter_value UART1_Mode {Flow_control}
	set_component_parameter_value UART1_PinMuxing {FPGA}
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
	set_component_parameter_value f2s_SMMU {1}
	set_component_parameter_value f2s_address_width {32}
	set_component_parameter_value f2s_data_width {256}
	set_component_parameter_value f2s_mode {ace5lite}
	set_component_parameter_value f2sdram_SMMU {0}
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
	set_instantiation_assignment_value embeddedsw.CMacro.CPU_FREQ {50000000u}
	set_instantiation_assignment_value embeddedsw.configuration.cpuArchitecture {sm_hps}
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
	set_instantiation_interface_parameter_value hps2fpga enableConcurrentSubordinateAccess {0}
	set_instantiation_interface_parameter_value hps2fpga isTranslator {false}
	set_instantiation_interface_parameter_value hps2fpga issuesFIXEDBursts {true}
	set_instantiation_interface_parameter_value hps2fpga issuesINCRBursts {true}
	set_instantiation_interface_parameter_value hps2fpga issuesWRAPBursts {true}
	set_instantiation_interface_parameter_value hps2fpga maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value hps2fpga maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value hps2fpga maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value hps2fpga noRepeatedIdsBetweenSubordinates {0}
	set_instantiation_interface_parameter_value hps2fpga optionalAssociatedReset {false}
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
	set_instantiation_interface_parameter_value lwhps2fpga enableConcurrentSubordinateAccess {0}
	set_instantiation_interface_parameter_value lwhps2fpga isTranslator {false}
	set_instantiation_interface_parameter_value lwhps2fpga issuesFIXEDBursts {true}
	set_instantiation_interface_parameter_value lwhps2fpga issuesINCRBursts {true}
	set_instantiation_interface_parameter_value lwhps2fpga issuesWRAPBursts {true}
	set_instantiation_interface_parameter_value lwhps2fpga maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value lwhps2fpga maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value lwhps2fpga maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value lwhps2fpga noRepeatedIdsBetweenSubordinates {0}
	set_instantiation_interface_parameter_value lwhps2fpga optionalAssociatedReset {false}
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
	add_instantiation_interface uart1 conduit INPUT
	set_instantiation_interface_parameter_value uart1 associatedClock {}
	set_instantiation_interface_parameter_value uart1 associatedReset {}
	set_instantiation_interface_parameter_value uart1 prSafe {false}
	add_instantiation_interface_port uart1 uart1_cts_n cts_n 1 STD_LOGIC Input
	add_instantiation_interface_port uart1 uart1_dcd_n dcd_n 1 STD_LOGIC Input
	add_instantiation_interface_port uart1 uart1_dsr_n dsr_n 1 STD_LOGIC Input
	add_instantiation_interface_port uart1 uart1_dtr_n dtr_n 1 STD_LOGIC Output
	add_instantiation_interface_port uart1 uart1_out1_n out1_n 1 STD_LOGIC Output
	add_instantiation_interface_port uart1 uart1_out2_n out2_n 1 STD_LOGIC Output
	add_instantiation_interface_port uart1 uart1_ri_n ri_n 1 STD_LOGIC Input
	add_instantiation_interface_port uart1 uart1_rts_n rts_n 1 STD_LOGIC Output
	add_instantiation_interface_port uart1 uart1_rx rx 1 STD_LOGIC Input
	add_instantiation_interface_port uart1 uart1_tx tx 1 STD_LOGIC Output
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
	add_instantiation_interface_port hps_io hps_io_uart0_tx uart0_tx 1 STD_LOGIC Output
	add_instantiation_interface_port hps_io hps_io_uart0_rx uart0_rx 1 STD_LOGIC Input
	add_instantiation_interface fpga2hps_interrupt_irq1 interrupt OUTPUT
	set_instantiation_interface_parameter_value fpga2hps_interrupt_irq1 associatedAddressablePoint {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt_irq1 associatedClock {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt_irq1 associatedReset {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt_irq1 irqMap {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt_irq1 irqScheme {INDIVIDUAL_REQUESTS}
	add_instantiation_interface_port fpga2hps_interrupt_irq1 fpga2hps_interrupt_irq1_irq irq 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface fpga2hps_interrupt_irq0 interrupt OUTPUT
	set_instantiation_interface_parameter_value fpga2hps_interrupt_irq0 associatedAddressablePoint {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt_irq0 associatedClock {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt_irq0 associatedReset {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt_irq0 irqMap {}
	set_instantiation_interface_parameter_value fpga2hps_interrupt_irq0 irqScheme {INDIVIDUAL_REQUESTS}
	add_instantiation_interface_port fpga2hps_interrupt_irq0 fpga2hps_interrupt_irq0_irq irq 32 STD_LOGIC_VECTOR Input
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
	set_instantiation_interface_parameter_value f2sdram isTranslator {false}
	set_instantiation_interface_parameter_value f2sdram maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value f2sdram maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value f2sdram maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value f2sdram noNarrowTransfer {false}
	set_instantiation_interface_parameter_value f2sdram optionalAssociatedReset {false}
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
	add_instantiation_interface fpga2hps ace5lite INPUT
	set_instantiation_interface_parameter_value fpga2hps addressCheck {false}
	set_instantiation_interface_parameter_value fpga2hps associatedClock {fpga2hps_clock}
	set_instantiation_interface_parameter_value fpga2hps associatedReset {fpga2hps_reset}
	set_instantiation_interface_parameter_value fpga2hps atomicTransactions {true}
	set_instantiation_interface_parameter_value fpga2hps bridgesToMaster {}
	set_instantiation_interface_parameter_value fpga2hps cacheStashTransactions {true}
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
	set_instantiation_interface_parameter_value fpga2hps isTranslator {false}
	set_instantiation_interface_parameter_value fpga2hps poison {false}
	set_instantiation_interface_parameter_value fpga2hps readAcceptanceCapability {16}
	set_instantiation_interface_parameter_value fpga2hps readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value fpga2hps traceSignals {false}
	set_instantiation_interface_parameter_value fpga2hps trustzoneAware {true}
	set_instantiation_interface_parameter_value fpga2hps untranslatedTransactions {true}
	set_instantiation_interface_parameter_value fpga2hps wakeupSignals {false}
	set_instantiation_interface_parameter_value fpga2hps writeAcceptanceCapability {16}
	add_instantiation_interface_port fpga2hps fpga2hps_awid awid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awaddr awaddr 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awdomain awdomain 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awsnoop awsnoop 4 STD_LOGIC_VECTOR Input
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
	add_instantiation_interface_port fpga2hps fpga2hps_awstashnid awstashnid 11 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awstashniden awstashniden 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_awstashlpid awstashlpid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awstashlpiden awstashlpiden 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_awatop awatop 6 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_bid bid 5 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port fpga2hps fpga2hps_bresp bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port fpga2hps fpga2hps_bvalid bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port fpga2hps fpga2hps_bready bready 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_arid arid 5 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_araddr araddr 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_ardomain ardomain 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arsnoop arsnoop 4 STD_LOGIC_VECTOR Input
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
	add_instantiation_interface_port fpga2hps fpga2hps_armmusecsid armmusecsid 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_armmusid armmusid 16 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awuser awuser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awmmusecsid awmmusecsid 1 STD_LOGIC Input
	add_instantiation_interface_port fpga2hps fpga2hps_awmmusid awmmusid 16 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_arregion arregion 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_awregion awregion 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_wuser wuser 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port fpga2hps fpga2hps_buser buser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port fpga2hps fpga2hps_ruser ruser 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface io96b0_to_hps conduit INPUT
	set_instantiation_interface_parameter_value io96b0_to_hps associatedClock {}
	set_instantiation_interface_parameter_value io96b0_to_hps associatedReset {}
	set_instantiation_interface_parameter_value io96b0_to_hps prSafe {false}
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_clk ch0_axil_clk 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_reset_n ch0_axil_reset_n 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_arready ch0_axil_arready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_awready ch0_axil_awready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_bresp ch0_axil_bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_bvalid ch0_axil_bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_rdata ch0_axil_rdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_rresp ch0_axil_rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_rvalid ch0_axil_rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_wready ch0_axil_wready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_araddr ch0_axil_araddr 27 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_arvalid ch0_axil_arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_awaddr ch0_axil_awaddr 27 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_awvalid ch0_axil_awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_bready ch0_axil_bready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_rready ch0_axil_rready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_wdata ch0_axil_wdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_wstrb ch0_axil_wstrb 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_wvalid ch0_axil_wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_arprot ch0_axil_arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_ch0_axil_awprot ch0_axil_awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_clk axi4_ch0_clk 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_reset_n axi4_ch0_reset_n 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_arready axi4_ch0_arready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awready axi4_ch0_awready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_bid axi4_ch0_bid 7 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_bresp axi4_ch0_bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_bvalid axi4_ch0_bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_rdata axi4_ch0_rdata 256 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_rid axi4_ch0_rid 7 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_rlast axi4_ch0_rlast 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_rresp axi4_ch0_rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_ruser axi4_ch0_ruser 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_rvalid axi4_ch0_rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_wready axi4_ch0_wready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_araddr axi4_ch0_araddr 40 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_arburst axi4_ch0_arburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_arid axi4_ch0_arid 7 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_arlen axi4_ch0_arlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_arlock axi4_ch0_arlock 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_arqos axi4_ch0_arqos 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_arsize axi4_ch0_arsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_aruser axi4_ch0_aruser 14 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_arvalid axi4_ch0_arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awaddr axi4_ch0_awaddr 40 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awburst axi4_ch0_awburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awid axi4_ch0_awid 7 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awlen axi4_ch0_awlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awlock axi4_ch0_awlock 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awqos axi4_ch0_awqos 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awsize axi4_ch0_awsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awuser axi4_ch0_awuser 14 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awvalid axi4_ch0_awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_bready axi4_ch0_bready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_rready axi4_ch0_rready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_wdata axi4_ch0_wdata 256 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_wlast axi4_ch0_wlast 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_wstrb axi4_ch0_wstrb 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_wuser axi4_ch0_wuser 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_wvalid axi4_ch0_wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_arprot axi4_ch0_arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps io96b0_to_hps_axi4_ch0_awprot axi4_ch0_awprot 3 STD_LOGIC_VECTOR Output
	save_instantiation
	add_component emif_bank3a_hps ip/no_pins_hps/emif_bank3a_hps.ip emif_io96b_hps emif_bank3a_hps 4.1.1
	load_component emif_bank3a_hps
	set_component_parameter_value EMIF_PROTOCOL {DDR4_COMP}
	set_component_parameter_value EMIF_REF_CLK_SHARING {0}
	set_component_parameter_value EMIF_RZQ_SHARING {0}
	set_component_parameter_value EMIF_SHOW_INTERNAL_SETTINGS {0}
	set_component_parameter_value EMIF_TOPOLOGY {1x32}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	set_component_sub_module_parameter_value emif_0_ddr4comp ADV_CAL_ENABLE_MARGIN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp ADV_CAL_ENABLE_REQ {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp ADV_CAL_ENABLE_WEQ {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp ANALOG_PARAM_DERIVATION_PARAM_NAME {}
	set_component_sub_module_parameter_value emif_0_ddr4comp AXI4_ADDR_WIDTH {40}
	set_component_sub_module_parameter_value emif_0_ddr4comp AXI4_USER_WIDTH {32}
	set_component_sub_module_parameter_value emif_0_ddr4comp CTRL_AUTO_PRECHARGE_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp CTRL_BG_ROTATE_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp CTRL_DMDBI_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp CTRL_DM_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp CTRL_ECC_AUTOCORRECT_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp CTRL_PERFORMANCE_PROFILE {SEQ}
	set_component_sub_module_parameter_value emif_0_ddr4comp CTRL_RD_DBI_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp CTRL_SCRAMBLER_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp CTRL_WR_DBI_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp DIAG_EXTRA_PARAMETERS {}
	set_component_sub_module_parameter_value emif_0_ddr4comp DIAG_HMC_ADDR_SWAP_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp EX_DESIGN_PMON_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp EX_DESIGN_PMON_INTERNAL_JAMB_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp HPS_EMIF_RZQ_SHARING {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp INSTANCE_ID {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp IS_HPS {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp JEDEC_OVERRIDE_TABLE_PARAM_NAME {MEM_TCCD_L_NS MEM_TCCD_S_NS MEM_TFAW_NS MEM_TWTR_L_NS MEM_TWTR_S_NS MEM_TMRD_NS MEM_TCKSRE_NS MEM_TCKSRX_NS MEM_TCKE_NS MEM_TCKESR_CYC MEM_TMPRR_NS MEM_TRFC_DLR_NS MEM_TRRD_DLR_NS MEM_TFAW_DLR_NS MEM_TCCD_DLR_NS MEM_TXP_NS MEM_TXS_DLL_NS MEM_TCPDED_NS MEM_TMOD_NS MEM_TZQCS_NS}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_3DS_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_AC_MIRRORING_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_AC_PARITY_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_AC_PARITY_LATENCY_MODE {0.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_AL_CYC {0.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_A_WIDTH {17}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_BANK_ADDR_WIDTH {2}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_BANK_GROUP_ADDR_WIDTH {2}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CHANNEL_ADDR_NUM_BITS {36}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CHANNEL_CAPACITY_GBITS {64}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CHANNEL_CS_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CHANNEL_ECC_DQ_WIDTH {8}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CKE_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CK_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CLAMSHELL_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CL_CYC {12.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_COL_ADDR_WIDTH {10}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CS_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CS_WIDTH_PHYSICAL {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_CWL_CYC {9.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_C_WIDTH {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_DIE_DENSITY_GBITS {16}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_DIE_DQ_WIDTH {8}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_DQ_PER_DQS {8}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_DQ_VREF {35}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_FINE_GRANULARITY_REFRESH_MODE {1.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_NUM_CHANNELS {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_NUM_CHANNELS_PER_IO96 {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_NUM_IO96 {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_ODT_DQ_X_IDLE {off}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_ODT_DQ_X_NON_TGT_RD {off}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_ODT_DQ_X_NON_TGT_WR {off}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_ODT_DQ_X_RON {7}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_ODT_DQ_X_TGT_WR {4}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_ODT_NOM {off}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_ODT_PARK {4}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_ODT_WR {off}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_OPERATING_FREQ_MHZ {800}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_OPERATING_FREQ_MHZ_AUTOSET_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_PAGE_SIZE {1024.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_RANKS_SHARE_CK_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_RD_PREAMBLE_MODE {1.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_ROW_ADDR_WIDTH {17}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_SPEEDBIN {1600L}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_SPEEDBIN_DATARATE {1600}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TCCD_DLR_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TCCD_L_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TCCD_S_NS {4.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TCKESR_CYC {5.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TCKE_NS {4.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TCKSRE_NS {8.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TCKSRX_NS {8.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TCK_CL_CWL_MAX_NS {1.5}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TCK_CL_CWL_MIN_NS {1.25}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TCPDED_NS {4.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TDQSCK_MAX_MIN_NS {0.225}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TDQSCK_NS {0.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TFAW_DLR_NS {20.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TFAW_NS {35.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TMOD_NS {24.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TMPRR_NS {1.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TMRD_NS {8.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRAS_MAX_NS {70200.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRAS_MIN_NS {35.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRAS_NS {35.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRCD_NS {15.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRC_NS {50.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TREFI_NS {7800.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRFC_DLR_NS {190.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRFC_NS {550.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRP_NS {15.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRRD_DLR_NS {4.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRRD_L_NS {6.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRRD_S_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TRTP_NS {7.5}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TWR_CRC_DM_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TWR_NS {15.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TWTR_L_CRC_DM_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TWTR_L_NS {6.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TWTR_S_CRC_DM_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TWTR_S_NS {2.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TXP_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TXS_DLL_NS {597.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TXS_NS {560.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TZQCS_NS {128.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TZQINIT_CYC {1024.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_TZQOPER_CYC {512.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_VREF_DQ_X_RANGE {2}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_VREF_DQ_X_VALUE {67.75}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_WR_CRC_EN {0.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp MEM_WR_PREAMBLE_MODE {1.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_AC_PLACEMENT {BOT}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_ALERT_N_PLACEMENT {AC2}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_FORCE_MIN_4_AC_LANES_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_REFCLK_ADVANCED_SELECT_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_REFCLK_FREQ_MHZ {150.0}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_REFCLK_FREQ_MHZ_AUTOSET_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_SWIZZLE_MAP {BYTE_SWIZZLE_CH0=0 X X X 1 2 3 ECC;PIN_SWIZZLE_CH0_DQS0=2 0 6 4 7 5 3 1;PIN_SWIZZLE_CH0_DQS1=14 11 12 8 10 9 13 15;PIN_SWIZZLE_CH0_DQS2=16 20 22 18 23 21 19 17;PIN_SWIZZLE_CH0_DQS3=26 30 28 24 25 27 29 31;PIN_SWIZZLE_CH0_ECC=4 6 2 0 1 7 5 3;}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_AC_OUTPUT_IO_STD_TYPE {SSTL}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_CK_OUTPUT_IO_STD_TYPE {DF_SSTL}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_CS_OUTPUT_IO_STD_TYPE {SSTL}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_DQS_IO_STD_TYPE {DF_POD}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_DQ_IO_STD_TYPE {POD}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_DQ_SLEW_RATE {FASTEST}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_DQ_VREF {68.3}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_GPIO_IO_STD_TYPE {LVCMOS}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_REFCLK_IO_STD_TYPE {TRUE_DIFF}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_R_S_AC_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_R_S_CK_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_R_S_CS_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_R_S_DQ_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_R_T_DQ_INPUT_OHM {RT_50_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_R_T_GPIO_INPUT_OHM {RT_OFF}
	set_component_sub_module_parameter_value emif_0_ddr4comp PHY_TERM_X_R_T_REFCLK_INPUT_OHM {RT_DIFF}
	set_component_sub_module_parameter_value emif_0_ddr4comp PLACEMENT_SCHEMES {DDR4_X40_BOT_ECC_ON}
	set_component_sub_module_parameter_value emif_0_ddr4comp S0_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_ddr4comp TURNAROUND_R2R_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp TURNAROUND_R2R_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp TURNAROUND_R2W_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp TURNAROUND_R2W_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp TURNAROUND_W2R_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp TURNAROUND_W2R_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp TURNAROUND_W2W_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr4comp TURNAROUND_W2W_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp ADV_CAL_ENABLE_MARGIN {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp ADV_CAL_ENABLE_RD_DFE {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp ADV_CAL_ENABLE_REQ {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp ADV_CAL_ENABLE_WEQ {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp ADV_CAL_ENABLE_WR_DFE {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp ANALOG_PARAM_DERIVATION_PARAM_NAME {}
	set_component_sub_module_parameter_value emif_0_ddr5comp AXI4_ADDR_WIDTH {31}
	set_component_sub_module_parameter_value emif_0_ddr5comp AXI4_USER_WIDTH {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp CTRL_2N_MODE_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp CTRL_AUTO_PRECHARGE_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp CTRL_BG_ROTATE_EN {2}
	set_component_sub_module_parameter_value emif_0_ddr5comp CTRL_DM_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp CTRL_ECC_AUTOCORRECT_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp CTRL_PERFORMANCE_PROFILE {SEQ}
	set_component_sub_module_parameter_value emif_0_ddr5comp CTRL_SCRAMBLER_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp DIAG_EXTRA_PARAMETERS {}
	set_component_sub_module_parameter_value emif_0_ddr5comp DIAG_FORCE_SLIM_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp DIAG_HMC_ADDR_SWAP_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp EX_DESIGN_PMON_CH1_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp EX_DESIGN_PMON_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp EX_DESIGN_PMON_INTERNAL_JAMB_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp HPS_EMIF_RZQ_SHARING {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp INSTANCE_ID {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp IS_HPS {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp JEDEC_OVERRIDE_TABLE_PARAM_NAME {}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_BANK_ADDR_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_BANK_GROUP_ADDR_WIDTH {2}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CA_VREF {55}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CA_WIDTH {13}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CHANNEL_ADDR_NUM_BITS {34}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CHANNEL_CAPACITY_GBITS {16}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CHANNEL_CS_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CHANNEL_ECC_DQ_WIDTH {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CHANNEL_ECC_DQ_WIDTH_ROUNDED {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CK_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CL_CYC {40.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_COL_ADDR_WIDTH {10}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CS_VREF {95}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CS_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_CWL_CYC {38.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_DFE_X_TAP_1 {n9}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_DFE_X_TAP_2 {n3}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_DFE_X_TAP_3 {n1}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_DFE_X_TAP_4 {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_DIE_DENSITY_GBITS {8}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_DIE_DQ_WIDTH {16}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_DQ_PER_DQS {8}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_DQ_VREF {46}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_FINE_GRANULARITY_REFRESH_MODE {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_NUM_CHANNELS {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_NUM_CHANNELS_PER_IO96 {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_NUM_IO96 {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_ODT_CA_X_CA {6}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_ODT_CA_X_CK {6}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_ODT_CA_X_CS {6}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_ODT_DQ_X_IDLE {5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_ODT_DQ_X_NON_TGT_RD {off}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_ODT_DQ_X_NON_TGT_WR {off}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_ODT_DQ_X_RON {7}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_ODT_DQ_X_TGT_WR {5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_OPERATING_DATARATE {5600}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_OPERATING_FREQ_MHZ {2800}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_OPERATING_FREQ_MHZ_AUTOSET_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_OPERATING_SPEEDBIN {5600AN}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_RD_POSTAMBLE_MODE {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_RD_PREAMBLE_MODE {2.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_ROW_ADDR_WIDTH {16}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_SPEEDBIN {5600AN}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_SPEEDBIN_DATARATE {5600}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TACTPDEN_CYC {2.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCCD_L_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCCD_L_WR2_NS {10.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCCD_L_WR_NS {20.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCCD_S_CYC {8.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCKLCS_CYC {15.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCKSRX_NS {3.5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCPDED_CYC {14.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCSH_SREXIT_MAX_NS {30.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCSH_SREXIT_MIN_NS {13.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCSH_SREXIT_NS {13.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TCSL_NS {10.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TDFE_NS {80.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TDLLK_NS {640.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TDQSCK_CYC {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TDQSCK_MAX_CYC {0.325}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TDQSCK_MIN_CYC {-0.325}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TDQSS_CYC {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TDQSS_MAX_CYC {0.625}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TDQSS_MIN_CYC {-0.625}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TFAW_NS {14.28571}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TMRD_NS {14.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TMRR_NS {14.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TMRR_P_NS {2.85714}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TMRW_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TPD_MAX_NS {19500.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TPD_MIN_NS {7.5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TPD_NS {7.5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TPPD_CYC {2.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TPRPDEN_CYC {2.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRAS_MAX_NS {19500.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRAS_MIN_NS {32.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRAS_NS {32.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRCD_NS {14.28571}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRC_NS {46.28571}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TREFI1_NS {3900.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TREFI2_NS {1950.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TREFISB_NS {975.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TREFPDEN_CYC {2.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TREFSBRD_NS {30.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRFC1_NS {195.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRFC2_NS {130.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRFCSB_NS {115.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRP_NS {14.28571}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRRD_L_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRRD_S_CYC {8.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TRTP_NS {7.5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TWPRE_EN_CYC {2.5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TWR_NS {30.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TWTRA_NS {22.5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TWTR_L_NS {10.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TWTR_S_NS {2.5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TXP_NS {7.5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TZQCAL_NS {1000.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_TZQLAT_NS {30.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_VREF_CA_X_CA_VALUE {70.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_VREF_CA_X_CS_VALUE {50.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_VREF_DQ_X_VALUE {74.5}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_WR_POSTAMBLE_MODE {1.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp MEM_WR_PREAMBLE_MODE {3.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_AC_PLACEMENT {BOT}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_DFE_X_TAP_1 {n1}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_DFE_X_TAP_2 {n1}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_DFE_X_TAP_3 {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_DFE_X_TAP_4 {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_REFCLK_ADVANCED_SELECT_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_REFCLK_FREQ_MHZ {200.0}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_REFCLK_FREQ_MHZ_AUTOSET_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_SWIZZLE_MAP {}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_AC_OUTPUT_IO_STD_TYPE {POD}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_CK_OUTPUT_IO_STD_TYPE {DF_POD}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_CS_OUTPUT_IO_STD_TYPE {POD}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_DQS_IO_STD_TYPE {DF_POD}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_DQ_IO_STD_TYPE {POD}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_DQ_SLEW_RATE {FASTEST}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_DQ_VREF {71.82}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_GPIO_IO_STD_TYPE {LVCMOS}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_REFCLK_IO_STD_TYPE {TRUE_DIFF}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_R_S_AC_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_R_S_CK_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_R_S_CS_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_R_S_DQ_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_R_T_DQ_INPUT_OHM {RT_60_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_R_T_GPIO_INPUT_OHM {RT_OFF}
	set_component_sub_module_parameter_value emif_0_ddr5comp PHY_TERM_X_R_T_REFCLK_INPUT_OHM {RT_DIFF}
	set_component_sub_module_parameter_value emif_0_ddr5comp PLACEMENT_SCHEMES {DDR5_X32_BOT}
	set_component_sub_module_parameter_value emif_0_ddr5comp S0_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_ddr5comp S1_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_ddr5comp TURNAROUND_R2R_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp TURNAROUND_R2R_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp TURNAROUND_R2W_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp TURNAROUND_R2W_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp TURNAROUND_W2R_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp TURNAROUND_W2R_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp TURNAROUND_W2W_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5comp TURNAROUND_W2W_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm ADV_CAL_ENABLE_MARGIN {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm ADV_CAL_ENABLE_RD_DFE {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm ADV_CAL_ENABLE_REQ {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm ADV_CAL_ENABLE_WEQ {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm ADV_CAL_ENABLE_WR_DFE {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm ANALOG_PARAM_DERIVATION_PARAM_NAME {}
	set_component_sub_module_parameter_value emif_0_ddr5dimm AXI4_ADDR_WIDTH {32}
	set_component_sub_module_parameter_value emif_0_ddr5dimm AXI4_USER_WIDTH {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm CTRL_2N_MODE_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm CTRL_AUTO_PRECHARGE_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm CTRL_BG_ROTATE_EN {2}
	set_component_sub_module_parameter_value emif_0_ddr5dimm CTRL_DM_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm CTRL_ECC_AUTOCORRECT_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm CTRL_PERFORMANCE_PROFILE {SEQ}
	set_component_sub_module_parameter_value emif_0_ddr5dimm CTRL_SCRAMBLER_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm DIAG_EXTRA_PARAMETERS {}
	set_component_sub_module_parameter_value emif_0_ddr5dimm DIAG_HMC_ADDR_SWAP_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm EX_DESIGN_PMON_CH1_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm EX_DESIGN_PMON_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm EX_DESIGN_PMON_INTERNAL_JAMB_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm HPS_EMIF_RZQ_SHARING {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm INSTANCE_ID {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm IS_HPS {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm JEDEC_OVERRIDE_TABLE_PARAM_NAME {}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_3DS_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_BANK_ADDR_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_BANK_GROUP_ADDR_WIDTH {3}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CA_VREF {55}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CA_WIDTH {13}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CHANNEL_ADDR_NUM_BITS {35}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CHANNEL_CAPACITY_GBITS {32}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CHANNEL_CS_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CHANNEL_ECC_DQ_WIDTH {4}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CHANNEL_ECC_DQ_WIDTH_ROUNDED {8}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CK_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CL_CYC {40.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_COL_ADDR_WIDTH {10}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CS_VREF {95}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CS_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_CWL_CYC {38.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_DFE_X_TAP_1 {n9}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_DFE_X_TAP_2 {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_DFE_X_TAP_3 {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_DFE_X_TAP_4 {n1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_DIE_DENSITY_GBITS {8}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_DIE_DQ_WIDTH {8}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_DIMM_TYPE {UDIMM}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_DQ_PER_DQS {8}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_DQ_VREF {39}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_FINE_GRANULARITY_REFRESH_MODE {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_NUM_CHANNELS {2}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_NUM_CHANNELS_PER_IO96 {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_NUM_IO96 {2}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_ODT_CA_X_CA {6}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_ODT_CA_X_CK {6}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_ODT_CA_X_CS {6}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_ODT_DQ_X_IDLE {5}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_ODT_DQ_X_NON_TGT_RD {off}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_ODT_DQ_X_NON_TGT_WR {off}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_ODT_DQ_X_RON {7}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_ODT_DQ_X_TGT_WR {5}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_OPERATING_DATARATE {5600}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_OPERATING_FREQ_MHZ {2800}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_OPERATING_FREQ_MHZ_AUTOSET_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_OPERATING_SPEEDBIN {5600AN}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_RCD_DCA_IBT {3}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_RCD_DCK_IBT {3}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_RCD_DCS_IBT {3}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_RCD_DERROR_IBT {3}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_RD_POSTAMBLE_MODE {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_RD_PREAMBLE_MODE {2.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_ROW_ADDR_WIDTH {16}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_SPD248_CK_CONTROL_ENABLE {32.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_SPD249_QCA_CS_ENABLE {8.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_SPD250_QCK_SIGNAL_DRIVER_STRENGTH {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_SPD252_QCA_QCS_SIGNAL_DRIVER_STRENGTH {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_SPD254_CK_CA_CS_SLEW_RATE {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_SPEEDBIN {5600AN}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_SPEEDBIN_DATARATE {5600}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TACTPDEN_CYC {2.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCCD_DLR_NS {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCCD_L_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCCD_L_WR2_NS {10.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCCD_L_WR_NS {20.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCCD_S_CYC {8.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCKLCS_CYC {15.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCKSRX_NS {3.5}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCPDED_CYC {14.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCSH_SREXIT_MAX_NS {30.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCSH_SREXIT_MIN_NS {13.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCSH_SREXIT_NS {13.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TCSL_NS {10.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TDFE_NS {80.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TDLLK_NS {640.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TDQSCK_CYC {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TDQSCK_MAX_CYC {0.325}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TDQSCK_MIN_CYC {-0.325}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TDQSS_CYC {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TDQSS_MAX_CYC {0.625}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TDQSS_MIN_CYC {-0.625}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TFAW_DLR_NS {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TFAW_NS {11.42857}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TMRD_NS {14.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TMRR_NS {14.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TMRR_P_NS {2.85714}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TMRW_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TPD_MAX_NS {19500.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TPD_MIN_NS {7.5}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TPD_NS {7.5}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TPPD_CYC {2.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TPRPDEN_CYC {2.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRAS_MAX_NS {19500.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRAS_MIN_NS {32.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRAS_NS {32.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRCD_NS {14.28571}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRC_NS {46.28571}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TREFI1_NS {3900.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TREFI2_NS {1950.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TREFISB_NS {975.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TREFPDEN_CYC {2.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TREFSBRD_NS {30.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRFC1_NS {195.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRFC2_NS {130.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRFCSB_NS {115.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRP_NS {14.28571}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRRD_DLR_NS {0.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRRD_L_NS {5.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRRD_S_CYC {8.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TRTP_NS {7.5}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TWPRE_EN_CYC {2.5}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TWR_NS {30.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TWTRA_NS {22.5}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TWTR_L_NS {10.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TWTR_S_NS {2.5}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TXP_NS {7.5}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TZQCAL_NS {1000.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_TZQLAT_NS {30.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_VREF_CA_X_CA_VALUE {70.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_VREF_CA_X_CS_VALUE {50.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_VREF_DQ_X_VALUE {78.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_WR_POSTAMBLE_MODE {1.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm MEM_WR_PREAMBLE_MODE {3.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_AC_PLACEMENT {BOT_BOT}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_DFE_X_TAP_1 {n1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_DFE_X_TAP_2 {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_DFE_X_TAP_3 {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_DFE_X_TAP_4 {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_REFCLK_ADVANCED_SELECT_EN {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_REFCLK_FREQ_MHZ {200.0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_REFCLK_FREQ_MHZ_AUTOSET_EN {1}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_SWIZZLE_MAP {}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_AC_OUTPUT_IO_STD_TYPE {POD}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_CK_OUTPUT_IO_STD_TYPE {DF_POD}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_CS_OUTPUT_IO_STD_TYPE {POD}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_DQS_IO_STD_TYPE {DF_POD}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_DQ_IO_STD_TYPE {POD}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_DQ_SLEW_RATE {FASTEST}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_DQ_VREF {75.45}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_GPIO_IO_STD_TYPE {LVCMOS}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_REFCLK_IO_STD_TYPE {TRUE_DIFF}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_R_S_AC_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_R_S_CK_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_R_S_CS_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_R_S_DQ_OUTPUT_OHM {SERIES_34_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_R_T_DQ_INPUT_OHM {RT_60_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_R_T_GPIO_INPUT_OHM {RT_OFF}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PHY_TERM_X_R_T_REFCLK_INPUT_OHM {RT_DIFF}
	set_component_sub_module_parameter_value emif_0_ddr5dimm PLACEMENT_SCHEMES {DDR5_X40_BOT_ECC_ON DDR5_X40_BOT_ECC_ON}
	set_component_sub_module_parameter_value emif_0_ddr5dimm S0_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_ddr5dimm S1_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_ddr5dimm TURNAROUND_R2R_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm TURNAROUND_R2R_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm TURNAROUND_R2W_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm TURNAROUND_R2W_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm TURNAROUND_W2R_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm TURNAROUND_W2R_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm TURNAROUND_W2W_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_ddr5dimm TURNAROUND_W2W_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 ADV_CAL_ENABLE_MARGIN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 ADV_CAL_ENABLE_REQ {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 ADV_CAL_ENABLE_WEQ {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 ANALOG_PARAM_DERIVATION_PARAM_NAME {}
	set_component_sub_module_parameter_value emif_0_lpddr4 AXI4_ADDR_WIDTH {31}
	set_component_sub_module_parameter_value emif_0_lpddr4 CTRL_AUTO_PRECHARGE_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 CTRL_DM_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 CTRL_ECC_AUTOCORRECT_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 CTRL_ECC_INLINE_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 CTRL_PERFORMANCE_PROFILE {SEQ}
	set_component_sub_module_parameter_value emif_0_lpddr4 CTRL_RD_DBI_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 CTRL_SCRAMBLER_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 CTRL_WR_DBI_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 DIAG_EXTRA_PARAMETERS {}
	set_component_sub_module_parameter_value emif_0_lpddr4 DIAG_FORCE_SLIM_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 DIAG_HMC_ADDR_SWAP_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 EX_DESIGN_PMON_CH1_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 EX_DESIGN_PMON_CH2_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 EX_DESIGN_PMON_CH3_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 EX_DESIGN_PMON_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 EX_DESIGN_PMON_INTERNAL_JAMB_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 INSTANCE_ID {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 IS_HPS {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 JEDEC_OVERRIDE_TABLE_PARAM_NAME {}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_BANK_ADDR_WIDTH {3}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_CA_VREF {13}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_CA_WIDTH {6}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_CHANNEL_ADDR_NUM_BITS {34}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_CHANNEL_CAPACITY_GBITS {16.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_CHANNEL_CS_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_CKE_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_CK_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_CL_CYC {36}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_COL_ADDR_WIDTH {10}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_CS_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_CWL_CYC {34}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_DIE_DENSITY_GBITS {16}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_DQ_PER_DQS {8}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_DQ_VREF {20}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_MINNUMREFSREQ {8192.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_NUM_CHANNELS {2}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_NUM_CHANNELS_PER_IO96 {2}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_NUM_IO96 {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_ODT_CA_X_CA_COMM {3}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_ODT_CA_X_CA_ENABLE {true}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_ODT_CA_X_CK_ENABLE {true}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_ODT_CA_X_CS_ENABLE {true}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_ODT_DQ_X_IDLE {off}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_ODT_DQ_X_RON {6}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_ODT_DQ_X_TGT_WR {5}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_OPERATING_FREQ_MHZ {2133.333}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_OPERATING_FREQ_MHZ_AUTOSET_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_PER_BANK_REF_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_RD_POSTAMBLE_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_RD_PREAMBLE_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_ROW_ADDR_WIDTH {17}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TCCD_NS {3.75}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TCKCKEH_NS {1.75}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TCKCKEL_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TCKEHCMD_NS {7.5}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TCKELCK_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TCKELCMD_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TCKE_NS {7.5}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TCMDCKE_NS {1.75}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TCSCKEH_NS {1.75}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TCSCKE_NS {1.75}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TDQSCK_MAX_NS {3.5}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TDQSCK_MIN_NS {1.5}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TECH_IS_X {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TESCKE_NS {1.75}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TFAW_NS {40.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TMRD_NS {14.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TMRR_NS {3.75}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TMRWCKEL_NS {14.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TMRW_NS {10.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TPPD_CYC {4.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TRAS_NS {42.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TRCD_NS {18.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TRC_NS {63.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TREFI_NS {3904.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TREFW_NS {32000000.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TRFCAB_NS {380.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TRFCPB_NS {190.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TRPAB_NS {21.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TRPPB_NS {18.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TRRD_NS {10.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TRTP_NS {7.5}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TSR_NS {15.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TWR_NS {18.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TWTR_NS {10.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TXP_NS {7.5}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TXSR_NS {387.5}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TZQCAL_NS {1000.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TZQCKE_NS {1.75}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_TZQLAT_NS {30.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_VREF_CA_X_CA_RANGE {2}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_VREF_CA_X_CA_VALUE {27.2}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_VREF_DQ_X_RANGE {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_VREF_DQ_X_VALUE {18.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_WLS {1.0}
	set_component_sub_module_parameter_value emif_0_lpddr4 MEM_WR_POSTAMBLE_CYC {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 NUM_IO96_IN_CHIP {8}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_AC_PLACEMENT {FULL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_REFCLK_ADVANCED_SELECT_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_REFCLK_FREQ_MHZ {199.111}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_REFCLK_FREQ_MHZ_AUTOSET_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_SWIZZLE_MAP {}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_AC_OUTPUT_IO_STD_TYPE {LVSTL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_CK_OUTPUT_IO_STD_TYPE {DF_LVSTL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_CS_OUTPUT_IO_STD_TYPE {LVSTL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_DQS_IO_STD_TYPE {DF_LVSTL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_DQ_IO_STD_TYPE {LVSTL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_DQ_SLEW_RATE {FASTEST}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_DQ_VREF {17.5}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_GPIO_IO_STD_TYPE {LVCMOS}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_REFCLK_IO_STD_TYPE {TRUE_DIFF}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_R_S_AC_OUTPUT_OHM {SERIES_40_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_R_S_CK_OUTPUT_OHM {SERIES_40_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_R_S_CS_OUTPUT_OHM {SERIES_40_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_R_S_DQ_OUTPUT_OHM {SERIES_40_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_R_T_DQ_INPUT_OHM {RT_50_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_R_T_GPIO_INPUT_OHM {RT_OFF}
	set_component_sub_module_parameter_value emif_0_lpddr4 PHY_TERM_X_R_T_REFCLK_INPUT_OHM {RT_DIFF}
	set_component_sub_module_parameter_value emif_0_lpddr4 PLACEMENT_SCHEMES {LPDDR4_X16X2}
	set_component_sub_module_parameter_value emif_0_lpddr4 S0_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_lpddr4 S1_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_lpddr4 S2_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_lpddr4 S3_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_lpddr4 TURNAROUND_R2R_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 TURNAROUND_R2R_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 TURNAROUND_R2W_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 TURNAROUND_R2W_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 TURNAROUND_W2R_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 TURNAROUND_W2R_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 TURNAROUND_W2W_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr4 TURNAROUND_W2W_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 ADV_CAL_ENABLE_MARGIN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 ADV_CAL_ENABLE_RD_DFE {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 ADV_CAL_ENABLE_REQ {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 ADV_CAL_ENABLE_WEQ {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 ADV_CAL_ENABLE_WR_DFE {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 ANALOG_PARAM_DERIVATION_PARAM_NAME {}
	set_component_sub_module_parameter_value emif_0_lpddr5 AXI4_ADDR_WIDTH {32}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_AUTO_PRECHARGE_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_BG_ROTATE_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_DM_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_ECC_AUTOCORRECT_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_ECC_INLINE_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_ECC_RD_LINK_EN_FSP0 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_ECC_RD_LINK_EN_FSP1 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_ECC_RD_LINK_EN_FSP2 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_ECC_WR_LINK_EN_FSP0 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_ECC_WR_LINK_EN_FSP1 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_ECC_WR_LINK_EN_FSP2 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_PERFORMANCE_PROFILE {SEQ}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_RD_DBI_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_SCRAMBLER_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 CTRL_WR_DBI_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 DIAG_EXTRA_PARAMETERS {}
	set_component_sub_module_parameter_value emif_0_lpddr5 DIAG_FORCE_SLIM_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 DIAG_HMC_ADDR_SWAP_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 EX_DESIGN_PMON_CH1_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 EX_DESIGN_PMON_CH2_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 EX_DESIGN_PMON_CH3_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 EX_DESIGN_PMON_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 EX_DESIGN_PMON_INTERNAL_JAMB_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 INSTANCE_ID {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 IS_HPS {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 JEDEC_OVERRIDE_TABLE_PARAM_NAME {}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_BANK_ADDR_WIDTH {2}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_BANK_GROUP_ADDR_WIDTH {2}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_BANK_MODE {LPDDR5_BANK_MODE_16B_BG_AUTO}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_BURST_ADDR_WIDTH {4}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_CA_VREF {80}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_CA_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_CHANNEL_ADDR_NUM_BITS {35}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_CHANNEL_CAPACITY_GBITS {32.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_CHANNEL_CS_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_CK_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_COL_ADDR_WIDTH {6}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_CS_WIDTH {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_DFE_X_TAP_1 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_DFS_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_DIE_DENSITY_GBITS {32}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_DQ_PER_DQS {8}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_DQ_VREF {28}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_CK_FREQ_MHZ {687.5}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_CL_CYC {15}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_CWL_CYC {14}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_OPERATING_FREQ_MHZ {2750}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_OPERATING_FREQ_MHZ_AUTOSET_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TCKCSH_NS {3.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TCMDPD_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TCSLCK_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TCSPD_NS {12.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TESPD_NS {3.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TMRD_NS {14.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TMRR_NS {6.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TMRWPD_NS {14.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TMRW_NS {10.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TPBR2PBR_NS {90.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TPPD_NS {3.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TRBTP_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TRFCAB_NS {380.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TRFCPB_NS {190.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TRRD_L_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TRRD_S_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TWTR_L_NS {12.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TWTR_S_NS {7.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TXP_NS {7.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TXSR_NS {388.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP0_TZQPD_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_CK_FREQ_MHZ {687.5}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_CL_CYC {15}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_CWL_CYC {14}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_OPERATING_FREQ_MHZ {2750}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_OPERATING_FREQ_MHZ_AUTOSET_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TCKCSH_NS {3.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TCMDPD_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TCSLCK_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TCSPD_NS {12.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TESPD_NS {3.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TMRD_NS {14.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TMRR_NS {6.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TMRWPD_NS {14.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TMRW_NS {10.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TPBR2PBR_NS {90.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TPPD_NS {3.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TRBTP_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TRFCAB_NS {380.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TRFCPB_NS {190.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TRRD_L_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TRRD_S_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TWTR_L_NS {12.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TWTR_S_NS {7.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TXP_NS {7.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TXSR_NS {388.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP1_TZQPD_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_CK_FREQ_MHZ {687.5}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_CL_CYC {15}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_CWL_CYC {14}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_OPERATING_FREQ_MHZ {2750}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_OPERATING_FREQ_MHZ_AUTOSET_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TCKCSH_NS {3.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TCMDPD_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TCSLCK_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TCSPD_NS {12.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TESPD_NS {3.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TMRD_NS {14.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TMRR_NS {6.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TMRWPD_NS {14.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TMRW_NS {10.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TPBR2PBR_NS {90.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TPPD_NS {3.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TRBTP_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TRFCAB_NS {380.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TRFCPB_NS {190.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TRRD_L_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TRRD_S_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TWTR_L_NS {12.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TWTR_S_NS {7.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TXP_NS {7.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TXSR_NS {388.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_FSP2_TZQPD_NS {5.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_MINNUMREFSREQ {8192.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_NUM_CHANNELS {2}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_NUM_CHANNELS_PER_IO96 {2}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_NUM_IO96 {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_ODT_CA_X_CA_COMM {5}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_ODT_CA_X_CA_ENABLE {true}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_ODT_CA_X_CK_ENABLE {false}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_ODT_CA_X_CS_ENABLE {true}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_ODT_DQ_X_IDLE {off}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_ODT_DQ_X_NON_TGT {off}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_ODT_DQ_X_RON {5}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_ODT_DQ_X_TGT_WR {5}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_ODT_DQ_X_WCK {5}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_OPERATING_FREQ_MHZ {2750}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_PER_BANK_REF_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_RDQS_POSTAMBLE_MODE {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_RD_POSTAMBLE_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_RD_PREAMBLE_CYC {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_ROW_ADDR_WIDTH {17}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TCCDMW_NS {16.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TCSH_NS {3.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TDQSCK_NS {0.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TERQE_NS {35.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TERQX_NS {35.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TFAW_NS {20.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TOSCO_NS {40.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TPBR2ACT_8B_NS {10.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TPBR2ACT_NS {8.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TPW_RESET_NS {100.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TRAS_MAX_NS {35000.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TRAS_NS {42.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TRCD_NS {18.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TRC_NS {63.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TRDQE_OD_NS {35.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TRDQSTFE_NS {35.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TRDQSTFX_NS {35.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TRDQX_OD_NS {35.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TREFI_NS {3906.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TREFW_NS {32000000.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TRPAB_NS {21.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TRPPB_NS {18.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TSR_NS {15.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TWR_NS {34.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_TZQLAT_NS {30.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_VREF_CA_X_CA_VALUE {50.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_VREF_DQ_X_VALUE {24.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_WCK_WIDTH {2}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_WLS {1.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 MEM_WR_POSTAMBLE_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 NUM_IO96_IN_CHIP {8}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_AC_PLACEMENT {FULL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_DFE_X_TAP_1 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_DFE_X_TAP_2 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_DFE_X_TAP_3 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_DFE_X_TAP_4 {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_REFCLK_ADVANCED_SELECT_EN {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_REFCLK_FREQ_MHZ {200.0}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_REFCLK_FREQ_MHZ_AUTOSET_EN {1}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_SWIZZLE_MAP {}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_AC_OUTPUT_IO_STD_TYPE {LVSTL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_CK_OUTPUT_IO_STD_TYPE {DF_LVSTL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_CS_OUTPUT_IO_STD_TYPE {LVSTL105}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_DQS_IO_STD_TYPE {DF_LVSTL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_DQ_IO_STD_TYPE {LVSTL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_DQ_SLEW_RATE {FASTEST}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_DQ_VREF {14.67}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_GPIO_IO_STD_TYPE {LVCMOS}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_REFCLK_IO_STD_TYPE {TRUE_DIFF}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_RESET_N_OUTPUT_IO_STD_TYPE {LVSTL105}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_R_S_AC_OUTPUT_OHM {SERIES_40_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_R_S_CK_OUTPUT_OHM {SERIES_40_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_R_S_CS_OUTPUT_OHM {SERIES_40_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_R_S_DQ_OUTPUT_OHM {SERIES_40_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_R_S_RESET_N_OUTPUT_OHM {SERIES_40_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_R_T_DQ_INPUT_OHM {RT_40_OHM_CAL}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_R_T_GPIO_INPUT_OHM {RT_OFF}
	set_component_sub_module_parameter_value emif_0_lpddr5 PHY_TERM_X_R_T_REFCLK_INPUT_OHM {RT_DIFF}
	set_component_sub_module_parameter_value emif_0_lpddr5 PLACEMENT_SCHEMES {LPDDR5_X16X2}
	set_component_sub_module_parameter_value emif_0_lpddr5 S0_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_lpddr5 S1_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_lpddr5 S2_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_lpddr5 S3_AXID_WIDTH {7}
	set_component_sub_module_parameter_value emif_0_lpddr5 TURNAROUND_R2R_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 TURNAROUND_R2R_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 TURNAROUND_R2W_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 TURNAROUND_R2W_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 TURNAROUND_W2R_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 TURNAROUND_W2R_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 TURNAROUND_W2W_DIFFCS_CYC {0}
	set_component_sub_module_parameter_value emif_0_lpddr5 TURNAROUND_W2W_SAMECS_CYC {0}
	set_component_sub_module_parameter_value emif_1_ddr4comp INSTANCE_ID {1}
	set_component_sub_module_parameter_value emif_1_ddr4comp PHY_SWIZZLE_MAP {}
	set_component_sub_module_parameter_value emif_1_ddr5comp INSTANCE_ID {1}
	set_component_sub_module_parameter_value emif_1_ddr5comp PHY_SWIZZLE_MAP {}
	set_component_sub_module_parameter_value emif_1_ddr5dimm INSTANCE_ID {1}
	set_component_sub_module_parameter_value emif_1_ddr5dimm PHY_SWIZZLE_MAP {}
	set_component_sub_module_parameter_value emif_1_lpddr4 INSTANCE_ID {1}
	set_component_sub_module_parameter_value emif_1_lpddr4 PHY_SWIZZLE_MAP {}
	set_component_sub_module_parameter_value emif_1_lpddr5 INSTANCE_ID {1}
	set_component_sub_module_parameter_value emif_1_lpddr5 PHY_SWIZZLE_MAP {}
	set_component_sub_module_parameter_value refclk_bridge CONNECTIONS {refclk_in\ \ \ \ \ \ \ \ refclk_in_gpio refclk_out_gpio\ \ refclk_out}
	set_component_sub_module_parameter_value refclk_bridge CUSTOM_ELABORATION_COMMANDS {}
	set_component_sub_module_parameter_value refclk_bridge INTERFACES {refclk_in\ \ \ \ \ \ \ \ clock\ \ \ \ sink refclk_out\ \ \ \ \ \ \ clock\ \ \ \ source refclk_in_gpio\ \ \ conduit\ \ end refclk_out_gpio\ \ conduit\ \ start}
	set_component_sub_module_parameter_value refclk_bridge PORTS {refclk_in\ \ \ \ \ \ \ \ refclk_in\ \ \ \ \ \ \ \ \ clk\ \ \ \ \ \ input\ \ \ \ 1 refclk_out\ \ \ \ \ \ \ refclk_out\ \ \ \ \ \ \ \ clk\ \ \ \ \ \ output\ \ \ 1 refclk_in_gpio\ \ \ refclk_in_gpio\ \ \ \ export\ \ \ output\ \ \ 1 refclk_out_gpio\ \ refclk_out_gpio\ \ \ export\ \ \ input\ \ \ \ 1}
	save_component
	load_instantiation emif_bank3a_hps
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface io96b0_to_hps conduit INPUT
	set_instantiation_interface_parameter_value io96b0_to_hps associatedClock {}
	set_instantiation_interface_parameter_value io96b0_to_hps associatedReset {}
	set_instantiation_interface_parameter_value io96b0_to_hps prSafe {false}
	add_instantiation_interface_port io96b0_to_hps noc_aclk_0 axi4_ch0_clk 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps noc_rst_n_0 axi4_ch0_reset_n 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_clock ch0_axil_clk 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_reset_n ch0_axil_reset_n 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_awaddr ch0_axil_awaddr 27 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_awvalid ch0_axil_awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_awready ch0_axil_awready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_araddr ch0_axil_araddr 27 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_arvalid ch0_axil_arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_arready ch0_axil_arready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_wdata ch0_axil_wdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_wvalid ch0_axil_wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_wready ch0_axil_wready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_rresp ch0_axil_rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_rdata ch0_axil_rdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_rvalid ch0_axil_rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_rready ch0_axil_rready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_bresp ch0_axil_bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_bvalid ch0_axil_bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_bready ch0_axil_bready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_awprot ch0_axil_awprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_wstrb ch0_axil_wstrb 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_noc_axi4lite_arprot ch0_axil_arprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awaddr axi4_ch0_awaddr 40 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awburst axi4_ch0_awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awid axi4_ch0_awid 7 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awlen axi4_ch0_awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awlock axi4_ch0_awlock 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awqos axi4_ch0_awqos 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awsize axi4_ch0_awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awvalid axi4_ch0_awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awuser axi4_ch0_awuser 14 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awprot axi4_ch0_awprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_awready axi4_ch0_awready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_araddr axi4_ch0_araddr 40 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_arburst axi4_ch0_arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_arid axi4_ch0_arid 7 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_arlen axi4_ch0_arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_arlock axi4_ch0_arlock 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_arqos axi4_ch0_arqos 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_arsize axi4_ch0_arsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_arvalid axi4_ch0_arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_aruser axi4_ch0_aruser 14 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_arprot axi4_ch0_arprot 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_arready axi4_ch0_arready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_wdata axi4_ch0_wdata 256 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_wstrb axi4_ch0_wstrb 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_wlast axi4_ch0_wlast 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_wvalid axi4_ch0_wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_wready axi4_ch0_wready 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_bready axi4_ch0_bready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_bid axi4_ch0_bid 7 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_bresp axi4_ch0_bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_bvalid axi4_ch0_bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_rready axi4_ch0_rready 1 STD_LOGIC Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_rdata axi4_ch0_rdata 256 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_rid axi4_ch0_rid 7 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_rlast axi4_ch0_rlast 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_rresp axi4_ch0_rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_rvalid axi4_ch0_rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port io96b0_to_hps s0_axi4_wuser axi4_ch0_wuser 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port io96b0_to_hps s0_axi4_ruser axi4_ch0_ruser 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface mem_0 conduit INPUT
	set_instantiation_interface_parameter_value mem_0 associatedClock {}
	set_instantiation_interface_parameter_value mem_0 associatedReset {}
	set_instantiation_interface_parameter_value mem_0 prSafe {false}
	add_instantiation_interface_port mem_0 mem_0_cke mem_cke 1 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port mem_0 mem_0_odt mem_odt 1 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port mem_0 mem_0_cs_n mem_cs_n 1 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port mem_0 mem_0_a mem_a 17 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port mem_0 mem_0_ba mem_ba 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port mem_0 mem_0_bg mem_bg 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port mem_0 mem_0_act_n mem_act_n 1 STD_LOGIC Output
	add_instantiation_interface_port mem_0 mem_0_par mem_par 1 STD_LOGIC Output
	add_instantiation_interface_port mem_0 mem_0_dq mem_dq 40 STD_LOGIC_VECTOR Bidir
	add_instantiation_interface_port mem_0 mem_0_dqs_t mem_dqs_t 5 STD_LOGIC_VECTOR Bidir
	add_instantiation_interface_port mem_0 mem_0_dqs_c mem_dqs_c 5 STD_LOGIC_VECTOR Bidir
	add_instantiation_interface_port mem_0 mem_0_alert_n mem_alert_n 1 STD_LOGIC Input
	add_instantiation_interface mem_ck_0 conduit INPUT
	set_instantiation_interface_parameter_value mem_ck_0 associatedClock {}
	set_instantiation_interface_parameter_value mem_ck_0 associatedReset {}
	set_instantiation_interface_parameter_value mem_ck_0 prSafe {false}
	add_instantiation_interface_port mem_ck_0 mem_0_ck_t mem_ck_t 1 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port mem_ck_0 mem_0_ck_c mem_ck_c 1 STD_LOGIC_VECTOR Output
	add_instantiation_interface mem_reset_n conduit INPUT
	set_instantiation_interface_parameter_value mem_reset_n associatedClock {}
	set_instantiation_interface_parameter_value mem_reset_n associatedReset {}
	set_instantiation_interface_parameter_value mem_reset_n prSafe {false}
	add_instantiation_interface_port mem_reset_n mem_0_reset_n mem_reset_n 1 STD_LOGIC Output
	add_instantiation_interface oct_0 conduit INPUT
	set_instantiation_interface_parameter_value oct_0 associatedClock {}
	set_instantiation_interface_parameter_value oct_0 associatedReset {}
	set_instantiation_interface_parameter_value oct_0 prSafe {false}
	add_instantiation_interface_port oct_0 oct_rzqin_0 oct_rzqin 1 STD_LOGIC Input
	add_instantiation_interface ref_clk clock INPUT
	set_instantiation_interface_parameter_value ref_clk clockRate {0}
	set_instantiation_interface_parameter_value ref_clk externallyDriven {false}
	set_instantiation_interface_parameter_value ref_clk ptfSchematicName {}
	add_instantiation_interface_port ref_clk ref_clk clk 1 STD_LOGIC Input
	save_instantiation

	# add wirelevel expressions

	# preserve ports for debug

	# add the connections
	add_connection emif_bank3a_hps.io96b0_to_hps/agilex_5_soc.io96b0_to_hps
	set_connection_parameter_value emif_bank3a_hps.io96b0_to_hps/agilex_5_soc.io96b0_to_hps endPort {}
	set_connection_parameter_value emif_bank3a_hps.io96b0_to_hps/agilex_5_soc.io96b0_to_hps endPortLSB {0}
	set_connection_parameter_value emif_bank3a_hps.io96b0_to_hps/agilex_5_soc.io96b0_to_hps startPort {}
	set_connection_parameter_value emif_bank3a_hps.io96b0_to_hps/agilex_5_soc.io96b0_to_hps startPortLSB {0}
	set_connection_parameter_value emif_bank3a_hps.io96b0_to_hps/agilex_5_soc.io96b0_to_hps width {0}

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
	set_interface_property agilex_5_soc_uart1 EXPORT_OF agilex_5_soc.uart1
	set_interface_property agilex_5_soc_i2c0_scl_i EXPORT_OF agilex_5_soc.I2C0_scl_i
	set_interface_property agilex_5_soc_i2c0_scl_oe EXPORT_OF agilex_5_soc.I2C0_scl_oe
	set_interface_property agilex_5_soc_i2c0 EXPORT_OF agilex_5_soc.I2C0
	set_interface_property agilex_5_soc_h2f_user0_clk EXPORT_OF agilex_5_soc.h2f_user0_clk
	set_interface_property agilex_5_soc_h2f_user1_clk EXPORT_OF agilex_5_soc.h2f_user1_clk
	set_interface_property agilex_5_soc_hps_io EXPORT_OF agilex_5_soc.hps_io
	set_interface_property agilex_5_soc_fpga2hps_interrupt_irq1 EXPORT_OF agilex_5_soc.fpga2hps_interrupt_irq1
	set_interface_property agilex_5_soc_fpga2hps_interrupt_irq0 EXPORT_OF agilex_5_soc.fpga2hps_interrupt_irq0
	set_interface_property agilex_5_soc_f2sdram_axi_clock EXPORT_OF agilex_5_soc.f2sdram_axi_clock
	set_interface_property agilex_5_soc_f2sdram_axi_reset EXPORT_OF agilex_5_soc.f2sdram_axi_reset
	set_interface_property agilex_5_soc_f2sdram EXPORT_OF agilex_5_soc.f2sdram
	set_interface_property agilex_5_soc_fpga2hps_clock EXPORT_OF agilex_5_soc.fpga2hps_clock
	set_interface_property agilex_5_soc_fpga2hps_reset EXPORT_OF agilex_5_soc.fpga2hps_reset
	set_interface_property agilex_5_soc_fpga2hps EXPORT_OF agilex_5_soc.fpga2hps
	set_interface_property emif_bank3a_hps_mem_0 EXPORT_OF emif_bank3a_hps.mem_0
	set_interface_property emif_bank3a_hps_mem_ck_0 EXPORT_OF emif_bank3a_hps.mem_ck_0
	set_interface_property emif_bank3a_hps_mem_reset_n EXPORT_OF emif_bank3a_hps.mem_reset_n
	set_interface_property emif_bank3a_hps_oct_0 EXPORT_OF emif_bank3a_hps.oct_0
	set_interface_property emif_bank3a_hps_ref_clk EXPORT_OF emif_bank3a_hps.ref_clk

	# set values for exposed HDL parameters

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
