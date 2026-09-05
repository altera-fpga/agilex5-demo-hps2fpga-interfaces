#
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
# SPDX-FileCopyrightText: Copyright (C) 2026 Altera Corporation
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
set_global_assignment -name DEVICE A5EB013BB23BE4SCS
set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
set_global_assignment -name STRATIXV_CONFIGURATION_SCHEME "ACTIVE SERIAL X4"
set_global_assignment -name ACTIVE_SERIAL_CLOCK AS_FREQ_125MHZ
set_global_assignment -name DEVICE_INITIALIZATION_CLOCK OSC_CLK_1_125MHZ
set_global_assignment -name USE_HPS_COLD_RESET SDM_IO11
set_global_assignment -name USE_CONF_DONE SDM_IO16
set_global_assignment -name PWRMGT_VOLTAGE_OUTPUT_FORMAT "LINEAR FORMAT"
set_global_assignment -name PWRMGT_LINEAR_FORMAT_N "-12"
set_global_assignment -name NUMBER_OF_SLAVE_DEVICE 2
set_global_assignment -name ON_CHIP_BITSTREAM_DECOMPRESSION OFF
set_global_assignment -name HPS_DAP_SPLIT_MODE "SDM PINS"
set_global_assignment -name HPS_DAP_NO_CERTIFICATE on
set_global_assignment -name AUTO_RESTART_CONFIGURATION OFF
set_global_assignment -name ENABLE_SIGNALTAP OFF
set_global_assignment -name POWER_APPLY_THERMAL_MARGIN ADDITIONAL
set_global_assignment -name STRATIX_JTAG_USER_CODE 77777777
set_global_assignment -name USE_CHECKSUM_AS_USERCODE OFF
set_global_assignment -name HPS_INITIALIZATION "HPS FIRST"
set_global_assignment -name QSPI_OWNERSHIP HPS
set_global_assignment -name INI_VARS "asm_enable_advanced_devices=on"
set_global_assignment -name NUM_PARALLEL_PROCESSORS 4

set_instance_assignment -name IO_STANDARD "1.1-V TRUE DIFFERENTIAL SIGNALING" -to LPDDR4A_REFCLK_p
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CS_n
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[0]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[1]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[2]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[3]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[4]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[5]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_CK
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CKE
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_CK_n
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DM[0]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DM[1]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DM[2]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DM[3]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[0]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[1]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[2]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[3]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[4]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[5]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[6]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[7]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[8]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[9]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[10]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[11]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[12]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[13]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[14]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[15]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[16]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[17]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[18]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[19]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[20]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[21]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[22]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[23]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[24]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[25]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[26]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[27]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[28]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[29]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[30]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[31]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQS[0]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQS[1]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQS[2]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQS[3]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQS_n[0]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQS_n[1]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQS_n[2]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQS_n[3]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_RESET_n
set_instance_assignment -name IO_STANDARD "1.1-V" -to LPDDR4A_RZQ
set_location_assignment PIN_B55  -to LPDDR4A_REFCLK_p
set_location_assignment PIN_B58  -to LPDDR4A_CS_n
set_location_assignment PIN_B66  -to LPDDR4A_CA[0]
set_location_assignment PIN_A68  -to LPDDR4A_CA[1]
set_location_assignment PIN_B68  -to LPDDR4A_CA[2]
set_location_assignment PIN_A70  -to LPDDR4A_CA[3]
set_location_assignment PIN_B63  -to LPDDR4A_CA[4]
set_location_assignment PIN_A66  -to LPDDR4A_CA[5]
set_location_assignment PIN_J42  -to LPDDR4A_CK
set_location_assignment PIN_A61  -to LPDDR4A_CKE
set_location_assignment PIN_G42  -to LPDDR4A_CK_n
set_location_assignment PIN_J59  -to LPDDR4A_DM[0]
set_location_assignment PIN_T59  -to LPDDR4A_DM[1]
set_location_assignment PIN_J27  -to LPDDR4A_DM[2]
set_location_assignment PIN_A25  -to LPDDR4A_DM[3]
set_location_assignment PIN_T62  -to LPDDR4A_DQ[0]
set_location_assignment PIN_T56  -to LPDDR4A_DQ[1]
set_location_assignment PIN_G56  -to LPDDR4A_DQ[2]
set_location_assignment PIN_E56  -to LPDDR4A_DQ[3]
set_location_assignment PIN_G65  -to LPDDR4A_DQ[4]
set_location_assignment PIN_J65  -to LPDDR4A_DQ[5]
set_location_assignment PIN_M56  -to LPDDR4A_DQ[6]
set_location_assignment PIN_M62  -to LPDDR4A_DQ[7]
set_location_assignment PIN_W62  -to LPDDR4A_DQ[8]
set_location_assignment PIN_M65  -to LPDDR4A_DQ[9]
set_location_assignment PIN_M51  -to LPDDR4A_DQ[10]
set_location_assignment PIN_T51  -to LPDDR4A_DQ[11]
set_location_assignment PIN_AB48 -to LPDDR4A_DQ[12]
set_location_assignment PIN_W48  -to LPDDR4A_DQ[13]
set_location_assignment PIN_T65  -to LPDDR4A_DQ[14]
set_location_assignment PIN_AB62 -to LPDDR4A_DQ[15]
set_location_assignment PIN_G24  -to LPDDR4A_DQ[16]
set_location_assignment PIN_E24  -to LPDDR4A_DQ[17]
set_location_assignment PIN_J35  -to LPDDR4A_DQ[18]
set_location_assignment PIN_T32  -to LPDDR4A_DQ[19]
set_location_assignment PIN_M32  -to LPDDR4A_DQ[20]
set_location_assignment PIN_T24  -to LPDDR4A_DQ[21]
set_location_assignment PIN_G35  -to LPDDR4A_DQ[22]
set_location_assignment PIN_M24  -to LPDDR4A_DQ[23]
set_location_assignment PIN_A22  -to LPDDR4A_DQ[24]
set_location_assignment PIN_A23  -to LPDDR4A_DQ[25]
set_location_assignment PIN_A33  -to LPDDR4A_DQ[26]
set_location_assignment PIN_B33  -to LPDDR4A_DQ[27]
set_location_assignment PIN_B30  -to LPDDR4A_DQ[28]
set_location_assignment PIN_A36  -to LPDDR4A_DQ[29]
set_location_assignment PIN_A20  -to LPDDR4A_DQ[30]
set_location_assignment PIN_B22  -to LPDDR4A_DQ[31]
set_location_assignment PIN_G62  -to LPDDR4A_DQS[0]
set_location_assignment PIN_AB56 -to LPDDR4A_DQS[1]
set_location_assignment PIN_G32  -to LPDDR4A_DQS[2]
set_location_assignment PIN_B28  -to LPDDR4A_DQS[3]
set_location_assignment PIN_E62  -to LPDDR4A_DQS_n[0]
set_location_assignment PIN_W56  -to LPDDR4A_DQS_n[1]
set_location_assignment PIN_E32  -to LPDDR4A_DQS_n[2]
set_location_assignment PIN_A30  -to LPDDR4A_DQS_n[3]
set_location_assignment PIN_M48  -to LPDDR4A_RESET_n
set_location_assignment PIN_T48  -to LPDDR4A_RZQ
set_instance_assignment -name IO_STANDARD "1.8-V" -to HPS_CLK_25
set_instance_assignment -name IO_STANDARD "1.8-V" -to HPS_UART_RX
set_instance_assignment -name IO_STANDARD "1.8-V" -to HPS_UART_TX
set_location_assignment PIN_AN67 -to HPS_CLK_25
set_location_assignment PIN_AD72 -to HPS_UART_RX
set_location_assignment PIN_N71  -to HPS_UART_TX

export_assignments

project_close

