#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
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
set_global_assignment -name DEVICE A5ED065BB32AE6SR0
set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
set_global_assignment -name STRATIXV_CONFIGURATION_SCHEME "ACTIVE SERIAL X4"
set_global_assignment -name ACTIVE_SERIAL_CLOCK AS_FREQ_100MHZ
set_global_assignment -name DEVICE_INITIALIZATION_CLOCK OSC_CLK_1_125MHZ
set_global_assignment -name USE_HPS_COLD_RESET SDM_IO11
set_global_assignment -name USE_CONF_DONE SDM_IO12
set_global_assignment -name VID_OPERATION_MODE "PMBUS MASTER"
set_global_assignment -name USE_PWRMGT_SCL SDM_IO0
set_global_assignment -name USE_PWRMGT_SDA SDM_IO16
set_global_assignment -name PWRMGT_BUS_SPEED_MODE "400 KHZ"
set_global_assignment -name PWRMGT_PAGE_COMMAND_ENABLE ON
set_global_assignment -name PWRMGT_SLAVE_DEVICE_TYPE OTHER
set_global_assignment -name PWRMGT_SLAVE_DEVICE0_ADDRESS 74
set_global_assignment -name PWRMGT_SLAVE_DEVICE1_ADDRESS 75
set_global_assignment -name PWRMGT_SLAVE_DEVICE2_ADDRESS 00
set_global_assignment -name PWRMGT_SLAVE_DEVICE3_ADDRESS 00
set_global_assignment -name PWRMGT_SLAVE_DEVICE4_ADDRESS 00
set_global_assignment -name PWRMGT_SLAVE_DEVICE5_ADDRESS 00
set_global_assignment -name PWRMGT_SLAVE_DEVICE6_ADDRESS 00
set_global_assignment -name PWRMGT_SLAVE_DEVICE7_ADDRESS 00
set_global_assignment -name PWRMGT_VOLTAGE_OUTPUT_FORMAT "LINEAR FORMAT"
set_global_assignment -name PWRMGT_LINEAR_FORMAT_N "-12"
set_global_assignment -name PWRMGT_TRANSLATED_VOLTAGE_VALUE_UNIT VOLTS
set_global_assignment -name NUMBER_OF_SLAVE_DEVICE 2
set_global_assignment -name ON_CHIP_BITSTREAM_DECOMPRESSION OFF
set_global_assignment -name HPS_DAP_SPLIT_MODE "SDM PINS"
set_global_assignment -name HPS_DAP_NO_CERTIFICATE on
set_global_assignment -name AUTO_RESTART_CONFIGURATION OFF
set_global_assignment -name ENABLE_SIGNALTAP OFF
set_global_assignment -name POWER_APPLY_THERMAL_MARGIN ADDITIONAL
set_global_assignment -name STRATIX_JTAG_USER_CODE 33333333
set_global_assignment -name USE_CHECKSUM_AS_USERCODE OFF
set_global_assignment -name HPS_INITIALIZATION "HPS FIRST"
set_global_assignment -name QSPI_OWNERSHIP HPS

set_location_assignment PIN_T114 -to emif_hps_emif_mem_0_mem_a[0]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[0]
set_location_assignment PIN_P114 -to emif_hps_emif_mem_0_mem_a[1]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[1]
set_location_assignment PIN_M105 -to emif_hps_emif_mem_0_mem_a[10]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[10]
set_location_assignment PIN_K105 -to emif_hps_emif_mem_0_mem_a[11]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[11]
set_location_assignment PIN_AG111 -to emif_hps_emif_mem_0_mem_a[12]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[12]
set_location_assignment PIN_Y114 -to emif_hps_emif_mem_0_mem_a[13]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[13]
set_location_assignment PIN_AB114 -to emif_hps_emif_mem_0_mem_a[14]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[14]
set_location_assignment PIN_AK107 -to emif_hps_emif_mem_0_mem_a[15]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[15]
set_location_assignment PIN_AK104 -to emif_hps_emif_mem_0_mem_a[16]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[16]
set_location_assignment PIN_V117 -to emif_hps_emif_mem_0_mem_a[2]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[2]
set_location_assignment PIN_T117 -to emif_hps_emif_mem_0_mem_a[3]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[3]
set_location_assignment PIN_M114 -to emif_hps_emif_mem_0_mem_a[4]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[4]
set_location_assignment PIN_K114 -to emif_hps_emif_mem_0_mem_a[5]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[5]
set_location_assignment PIN_V108 -to emif_hps_emif_mem_0_mem_a[6]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[6]
set_location_assignment PIN_T108 -to emif_hps_emif_mem_0_mem_a[7]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[7]
set_location_assignment PIN_T105 -to emif_hps_emif_mem_0_mem_a[8]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[8]
set_location_assignment PIN_P105 -to emif_hps_emif_mem_0_mem_a[9]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_a[9]
set_location_assignment PIN_M117 -to emif_hps_emif_mem_0_mem_act_n
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_act_n
set_location_assignment PIN_Y108 -to emif_hps_emif_mem_0_mem_alert_n
set_location_assignment PIN_AB108 -to emif_hps_emif_mem_0_mem_ba[0]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_ba[0]
set_location_assignment PIN_Y105 -to emif_hps_emif_mem_0_mem_ba[1]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_ba[1]
set_location_assignment PIN_AB105 -to emif_hps_emif_mem_0_mem_bg[0]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_bg[0]
set_location_assignment PIN_F117 -to emif_hps_emif_mem_0_mem_bg[1]
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_bg[1]
set_location_assignment PIN_F108 -to emif_hps_emif_mem_0_mem_ck_c
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to emif_hps_emif_mem_0_mem_ck_c
set_location_assignment PIN_F105 -to emif_hps_emif_mem_0_mem_cke
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_cke
set_location_assignment PIN_H108 -to emif_hps_emif_mem_0_mem_ck_t
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to emif_hps_emif_mem_0_mem_ck_t
set_location_assignment PIN_K117 -to emif_hps_emif_mem_0_mem_cs_n
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_cs_n
set_location_assignment PIN_B128 -to emif_hps_emif_mem_0_mem_dq[0]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[0]
set_location_assignment PIN_B116 -to emif_hps_emif_mem_0_mem_dq[1]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[1]
set_location_assignment PIN_Y95 -to emif_hps_emif_mem_0_mem_dq[10]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[10]
set_location_assignment PIN_AC96 -to emif_hps_emif_mem_0_mem_dq[11]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[11]
set_location_assignment PIN_AG100 -to emif_hps_emif_mem_0_mem_dq[12]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[12]
set_location_assignment PIN_Y87 -to emif_hps_emif_mem_0_mem_dq[13]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[13]
set_location_assignment PIN_Y98 -to emif_hps_emif_mem_0_mem_dq[14]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[14]
set_location_assignment PIN_AG104 -to emif_hps_emif_mem_0_mem_dq[15]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[15]
set_location_assignment PIN_T98 -to emif_hps_emif_mem_0_mem_dq[16]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[16]
set_location_assignment PIN_M84 -to emif_hps_emif_mem_0_mem_dq[17]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[17]
set_location_assignment PIN_P95 -to emif_hps_emif_mem_0_mem_dq[18]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[18]
set_location_assignment PIN_T84 -to emif_hps_emif_mem_0_mem_dq[19]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[19]
set_location_assignment PIN_A128 -to emif_hps_emif_mem_0_mem_dq[2]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[2]
set_location_assignment PIN_V98 -to emif_hps_emif_mem_0_mem_dq[20]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[20]
set_location_assignment PIN_P84 -to emif_hps_emif_mem_0_mem_dq[21]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[21]
set_location_assignment PIN_T95 -to emif_hps_emif_mem_0_mem_dq[22]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[22]
set_location_assignment PIN_K84 -to emif_hps_emif_mem_0_mem_dq[23]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[23]
set_location_assignment PIN_K98 -to emif_hps_emif_mem_0_mem_dq[24]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[24]
set_location_assignment PIN_K87 -to emif_hps_emif_mem_0_mem_dq[25]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[25]
set_location_assignment PIN_H98 -to emif_hps_emif_mem_0_mem_dq[26]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[26]
set_location_assignment PIN_M87 -to emif_hps_emif_mem_0_mem_dq[27]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[27]
set_location_assignment PIN_M98 -to emif_hps_emif_mem_0_mem_dq[28]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[28]
set_location_assignment PIN_D84 -to emif_hps_emif_mem_0_mem_dq[29]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[29]
set_location_assignment PIN_A116 -to emif_hps_emif_mem_0_mem_dq[3]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[3]
set_location_assignment PIN_F98 -to emif_hps_emif_mem_0_mem_dq[30]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[30]
set_location_assignment PIN_F84 -to emif_hps_emif_mem_0_mem_dq[31]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[31]
set_location_assignment PIN_B106 -to emif_hps_emif_mem_0_mem_dq[32]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[32]
set_location_assignment PIN_A91 -to emif_hps_emif_mem_0_mem_dq[33]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[33]
set_location_assignment PIN_A106 -to emif_hps_emif_mem_0_mem_dq[34]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[34]
set_location_assignment PIN_A94 -to emif_hps_emif_mem_0_mem_dq[35]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[35]
set_location_assignment PIN_A110 -to emif_hps_emif_mem_0_mem_dq[36]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[36]
set_location_assignment PIN_B91 -to emif_hps_emif_mem_0_mem_dq[37]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[37]
set_location_assignment PIN_B103 -to emif_hps_emif_mem_0_mem_dq[38]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[38]
set_location_assignment PIN_B88 -to emif_hps_emif_mem_0_mem_dq[39]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[39]
set_location_assignment PIN_A130 -to emif_hps_emif_mem_0_mem_dq[4]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[4]
set_location_assignment PIN_B113 -to emif_hps_emif_mem_0_mem_dq[5]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[5]
set_location_assignment PIN_B130 -to emif_hps_emif_mem_0_mem_dq[6]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[6]
set_location_assignment PIN_A113 -to emif_hps_emif_mem_0_mem_dq[7]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[7]
set_location_assignment PIN_AC100 -to emif_hps_emif_mem_0_mem_dq[8]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[8]
set_location_assignment PIN_Y84 -to emif_hps_emif_mem_0_mem_dq[9]
set_instance_assignment -name IO_STANDARD "1.2-V POD" -to emif_hps_emif_mem_0_mem_dq[9]
set_location_assignment PIN_A125 -to emif_hps_emif_mem_0_mem_dqs_c[0]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V POD" -to emif_hps_emif_mem_0_mem_dqs_c[0]
set_location_assignment PIN_AG93 -to emif_hps_emif_mem_0_mem_dqs_c[1]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V POD" -to emif_hps_emif_mem_0_mem_dqs_c[1]
set_location_assignment PIN_M95 -to emif_hps_emif_mem_0_mem_dqs_c[2]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V POD" -to emif_hps_emif_mem_0_mem_dqs_c[2]
set_location_assignment PIN_D95 -to emif_hps_emif_mem_0_mem_dqs_c[3]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V POD" -to emif_hps_emif_mem_0_mem_dqs_c[3]
set_location_assignment PIN_B101 -to emif_hps_emif_mem_0_mem_dqs_c[4]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V POD" -to emif_hps_emif_mem_0_mem_dqs_c[4]
set_location_assignment PIN_B122 -to emif_hps_emif_mem_0_mem_dqs_t[0]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V POD" -to emif_hps_emif_mem_0_mem_dqs_t[0]
set_location_assignment PIN_AG90 -to emif_hps_emif_mem_0_mem_dqs_t[1]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V POD" -to emif_hps_emif_mem_0_mem_dqs_t[1]
set_location_assignment PIN_K95 -to emif_hps_emif_mem_0_mem_dqs_t[2]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V POD" -to emif_hps_emif_mem_0_mem_dqs_t[2]
set_location_assignment PIN_F95 -to emif_hps_emif_mem_0_mem_dqs_t[3]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V POD" -to emif_hps_emif_mem_0_mem_dqs_t[3]
set_location_assignment PIN_A101 -to emif_hps_emif_mem_0_mem_dqs_t[4]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V POD" -to emif_hps_emif_mem_0_mem_dqs_t[4]
set_location_assignment PIN_F114 -to emif_hps_emif_mem_0_mem_odt
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_odt
set_location_assignment PIN_K108 -to emif_hps_emif_mem_0_mem_par
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_par
set_location_assignment PIN_H117 -to emif_hps_emif_mem_0_mem_reset_n
set_instance_assignment -name IO_STANDARD "SSTL-12" -to emif_hps_emif_mem_0_mem_reset_n
set_location_assignment PIN_AK111 -to emif_hps_emif_oct_0_oct_rzqin
set_instance_assignment -name IO_STANDARD "1.2-V" -to emif_hps_emif_oct_0_oct_rzqin
set_location_assignment PIN_AB117 -to emif_hps_emif_ref_clk_0_clk
set_location_assignment PIN_Y117 -to "emif_hps_emif_ref_clk_0_clk(n)"
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_osc_clk
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_uart0_RX
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to hps_uart0_RX
set_location_assignment PIN_AK115 -to hps_uart0_RX
set_instance_assignment -name IO_STANDARD "1.8 V" -to hps_uart0_TX
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_uart0_TX
set_location_assignment PIN_W134 -to hps_uart0_TX

export_assignments

project_close

