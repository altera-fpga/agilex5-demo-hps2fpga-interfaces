#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

#
# This script is created by first going into Quartus and select the menu:
# Project -> Organize Quartus Prime Settings File
#
# Then export the project to TCL:
# Project -> Generate Tcl File for Project...
#
# We then take that TCL file and reformat it for our needs.  We discard ancilary
# settings that are of no real use and we remove all .qsys and .ip references
# because we will restore those into future project creations as we reconstruct
# the project from raw source.
#
# The default format of the pin assignments may or may not be desirable, it will
# list all pin locations first followed by all pin instance assignments.  If we
# wish to sort this list placing all assignments for a given pin together, we
# can do this:
#
# Duplicate the original generated TCL file and call it pins_only.tcl. Edit the
# file to remove all entries but the pin assignments. Also remove any entity
# references at the ends of any lines, each line should end with the
# "-to <target>" value. Then we can run this command line to sort the pin
# assignments:
#
# []$ awk '{print $NF,$0}' pins_only.tcl | sort -s -k 1,1 | cut -f2- -d' ' > sorted_pins_only.tcl
#

package require ::quartus::project

set PROJECT_NAME "no_pins_top"
if [project_exists $PROJECT_NAME] {
        post_message -type error "project already exists..."
        post_message -type error "'$PROJECT_NAME'"
        qexit -error
}
project_new $PROJECT_NAME

set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
set_global_assignment -name VERILOG_FILE ../hw_base/no_pins_top.v
set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100
set_global_assignment -name FAMILY "Agilex 5"
set_global_assignment -name TOP_LEVEL_ENTITY no_pins_top
set_global_assignment -name BOARD default
set_global_assignment -name DEVICE A5ED065BB32AE5SR0
set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
set_global_assignment -name STRATIXV_CONFIGURATION_SCHEME "ACTIVE SERIAL X4"
set_global_assignment -name ACTIVE_SERIAL_CLOCK AS_FREQ_100MHZ
set_global_assignment -name DEVICE_INITIALIZATION_CLOCK OSC_CLK_1_125MHZ
set_global_assignment -name USE_CONF_DONE SDM_IO16
set_global_assignment -name USE_INIT_DONE SDM_IO0
set_global_assignment -name USE_HPS_COLD_RESET SDM_IO10
set_global_assignment -name VID_OPERATION_MODE "PMBUS MASTER"
set_global_assignment -name USE_PWRMGT_SCL SDM_IO0
set_global_assignment -name USE_PWRMGT_SDA SDM_IO16
set_global_assignment -name PWRMGT_VOLTAGE_OUTPUT_FORMAT "LINEAR FORMAT"
set_global_assignment -name PWRMGT_LINEAR_FORMAT_N "-12"
set_global_assignment -name PWRMGT_SLAVE_DEVICE_TYPE OTHER
set_global_assignment -name ON_CHIP_BITSTREAM_DECOMPRESSION OFF
set_global_assignment -name HPS_DAP_SPLIT_MODE "SDM PINS"
set_global_assignment -name HPS_DAP_NO_CERTIFICATE on
set_global_assignment -name AUTO_RESTART_CONFIGURATION OFF
set_global_assignment -name ENABLE_SIGNALTAP OFF
set_global_assignment -name POWER_APPLY_THERMAL_MARGIN ADDITIONAL
set_global_assignment -name STRATIX_JTAG_USER_CODE 44444444
set_global_assignment -name USE_CHECKSUM_AS_USERCODE OFF
set_global_assignment -name HPS_INITIALIZATION "HPS FIRST"

set_location_assignment PIN_Y77 -to fpga_reset_n
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to fpga_reset_n
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to fpga_user_led
set_location_assignment PIN_D24 -to fpga_user_led[0]
set_location_assignment PIN_F24 -to fpga_user_led[1]
set_location_assignment PIN_H27 -to fpga_user_led[2]
set_location_assignment PIN_F27 -to fpga_user_led[3]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to fpga_user_push_sw
set_location_assignment PIN_BR31 -to fpga_user_push_sw[0]
set_location_assignment PIN_BP31 -to fpga_user_push_sw[1]
set_location_assignment PIN_BH28 -to fpga_user_push_sw[2]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to fpga_user_sw
set_location_assignment PIN_B4 -to fpga_user_sw[0]
set_location_assignment PIN_A8 -to fpga_user_sw[1]
set_location_assignment PIN_A11 -to fpga_user_sw[2]
set_location_assignment PIN_BK31 -to fr_clk_100m_6a
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to fr_clk_100m_6a
set_location_assignment PIN_A23 -to fr_clk_100m_6d
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to fr_clk_100m_6d
set_location_assignment PIN_U134 -to hps_io_emac2_pps
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_pps
set_location_assignment PIN_AL120 -to hps_io_emac2_pps_trig
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_pps_trig
set_location_assignment PIN_M124 -to hps_io_emac2_rx_clk
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_rx_clk
set_location_assignment PIN_AB127 -to hps_io_emac2_rx_ctl
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_rx_ctl
set_location_assignment PIN_H127 -to hps_io_emac2_rxd0
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_rxd0
set_location_assignment PIN_AB124 -to hps_io_emac2_rxd1
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_rxd1
set_location_assignment PIN_F124 -to hps_io_emac2_rxd2
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_rxd2
set_location_assignment PIN_D124 -to hps_io_emac2_rxd3
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_rxd3
set_location_assignment PIN_M127 -to hps_io_emac2_tx_clk
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_tx_clk
set_location_assignment PIN_K127 -to hps_io_emac2_tx_ctl
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_tx_ctl
set_location_assignment PIN_K124 -to hps_io_emac2_txd0
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_txd0
set_location_assignment PIN_Y127 -to hps_io_emac2_txd1
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_txd1
set_location_assignment PIN_F127 -to hps_io_emac2_txd2
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_txd2
set_location_assignment PIN_Y124 -to hps_io_emac2_txd3
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_emac2_txd3
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_eth_int_n
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_gpio_ioa11
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_hartbeat_led
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_hps_osc_clk
set_location_assignment PIN_AK120 -to hps_io_i2c_emac1_scl
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_i2c_emac1_scl
set_location_assignment PIN_N135 -to hps_io_i2c_emac1_sda
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_i2c_emac1_sda
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_int_n_1v8
set_location_assignment PIN_AG115 -to hps_io_mdio2_mdc
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_mdio2_mdc
set_location_assignment PIN_R134 -to hps_io_mdio2_mdio
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_mdio2_mdio
set_location_assignment PIN_D132 -to hps_io_sdmmc_cclk
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sdmmc_cclk
set_location_assignment PIN_AB132 -to hps_io_sdmmc_cmd
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sdmmc_cmd
set_location_assignment PIN_E135 -to hps_io_sdmmc_data0
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sdmmc_data0
set_location_assignment PIN_F132 -to hps_io_sdmmc_data1
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sdmmc_data1
set_location_assignment PIN_AA135 -to hps_io_sdmmc_data2
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sdmmc_data2
set_location_assignment PIN_V127 -to hps_io_sdmmc_data3
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sdmmc_data3
set_location_assignment PIN_T127 -to hps_io_sdmmc_data4
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sdmmc_data4
set_location_assignment PIN_Y132 -to hps_io_sdmmc_data5
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sdmmc_data5
set_location_assignment PIN_T124 -to hps_io_sdmmc_data6
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sdmmc_data6
set_location_assignment PIN_P124 -to hps_io_sdmmc_data7
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sdmmc_data7
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_sd_pwr_sel
set_location_assignment PIN_AK115 -to hps_io_uart0_rx
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_uart0_rx
set_location_assignment PIN_W134 -to hps_io_uart0_tx
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_uart0_tx
set_location_assignment PIN_P132 -to hps_io_usb1_clk
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_clk
set_location_assignment PIN_AD135 -to hps_io_usb1_data0
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_data0
set_location_assignment PIN_M132 -to hps_io_usb1_data1
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_data1
set_location_assignment PIN_K132 -to hps_io_usb1_data2
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_data2
set_location_assignment PIN_AG129 -to hps_io_usb1_data3
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_data3
set_location_assignment PIN_J134 -to hps_io_usb1_data4
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_data4
set_location_assignment PIN_AG120 -to hps_io_usb1_data5
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_data5
set_location_assignment PIN_G134 -to hps_io_usb1_data6
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_data6
set_location_assignment PIN_G135 -to hps_io_usb1_data7
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_data7
set_location_assignment PIN_J135 -to hps_io_usb1_dir
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_dir
set_location_assignment PIN_AD134 -to hps_io_usb1_nxr
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_nxr
set_location_assignment PIN_L135 -to hps_io_usb1_stp
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_io_usb1_stp
set_location_assignment PIN_CD135 -to hps_usb31_flt_bar
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_usb31_flt_bar
set_location_assignment PIN_CD134 -to hps_usb31_usb31_id
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_usb31_usb31_id
set_location_assignment PIN_CG134 -to hps_usb31_usb_ctrl[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_usb31_usb_ctrl[0]
set_location_assignment PIN_CG135 -to hps_usb31_usb_ctrl[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_usb31_usb_ctrl[1]
set_location_assignment PIN_BE43 -to hps_usb31_vbus_det
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_usb31_vbus_det
set_location_assignment PIN_M105 -to lpddr4_m1_refclk
set_location_assignment PIN_AG111 -to lpddr4_m1_reset_n
set_location_assignment PIN_AK111 -to lpddr4_m1_rzqin
set_location_assignment PIN_CH132 -to mcu_spi_cs_3V3
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to mcu_spi_cs_3V3
set_location_assignment PIN_CF132 -to mcu_spi_miso_3V3
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to mcu_spi_miso_3V3
set_location_assignment PIN_CL130 -to mcu_spi_mosi_3V3
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to mcu_spi_mosi_3V3
set_location_assignment PIN_CK134 -to mcu_spi_sck_3V3
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to mcu_spi_sck_3V3
set_location_assignment PIN_AP120 -to usb3_refclk_p
set_location_assignment PIN_AM133 -to usb3_up_rxd_n
set_instance_assignment -name IO_STANDARD "HIGH SPEED DIFFERENTIAL I/O" -to usb3_up_rxd_n
set_location_assignment PIN_AM135 -to usb3_up_rxd_p
set_instance_assignment -name IO_STANDARD "HIGH SPEED DIFFERENTIAL I/O" -to usb3_up_rxd_p
set_location_assignment PIN_AN126 -to usb3_up_txd_n
set_instance_assignment -name IO_STANDARD "HIGH SPEED DIFFERENTIAL I/O" -to usb3_up_txd_n
set_location_assignment PIN_AN129 -to usb3_up_txd_p
set_instance_assignment -name IO_STANDARD "HIGH SPEED DIFFERENTIAL I/O" -to usb3_up_txd_p
set_location_assignment PIN_CK4 -to user_gpio[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[0]
set_location_assignment PIN_CJ2 -to user_gpio[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[1]
set_location_assignment PIN_BF21 -to user_gpio[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[10]
set_location_assignment PIN_BE21 -to user_gpio[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[11]
set_location_assignment PIN_BF25 -to user_gpio[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[12]
set_location_assignment PIN_BE25 -to user_gpio[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[13]
set_location_assignment PIN_BF32 -to user_gpio[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[14]
set_location_assignment PIN_BM118 -to user_gpio[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[15]
set_location_assignment PIN_BK118 -to user_gpio[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[16]
set_location_assignment PIN_BH118 -to user_gpio[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[17]
set_location_assignment PIN_BF104 -to user_gpio[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[18]
set_location_assignment PIN_BM112 -to user_gpio[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[19]
set_location_assignment PIN_CK2 -to user_gpio[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[2]
set_location_assignment PIN_BK112 -to user_gpio[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[20]
set_location_assignment PIN_BH109 -to user_gpio[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[21]
set_location_assignment PIN_BM109 -to user_gpio[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[22]
set_location_assignment PIN_BR112 -to user_gpio[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[23]
set_location_assignment PIN_BP112 -to user_gpio[24]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[24]
set_location_assignment PIN_BK109 -to user_gpio[25]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[25]
set_location_assignment PIN_BR109 -to user_gpio[26]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[26]
set_location_assignment PIN_BU109 -to user_gpio[27]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[27]
set_location_assignment PIN_CH4 -to user_gpio[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[3]
set_location_assignment PIN_BU19 -to user_gpio[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[4]
set_location_assignment PIN_BR19 -to user_gpio[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[5]
set_location_assignment PIN_BM19 -to user_gpio[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[6]
set_location_assignment PIN_BH19 -to user_gpio[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[7]
set_location_assignment PIN_BK22 -to user_gpio[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[8]
set_location_assignment PIN_BF16 -to user_gpio[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to user_gpio[9]

export_assignments

project_close

