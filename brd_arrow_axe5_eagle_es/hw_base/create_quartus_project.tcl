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
set_global_assignment -name DEVICE A5ED065BB32AE4SR0
set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
set_global_assignment -name STRATIXV_CONFIGURATION_SCHEME "ACTIVE SERIAL X4"
set_global_assignment -name ACTIVE_SERIAL_CLOCK AS_FREQ_100MHZ
set_global_assignment -name DEVICE_INITIALIZATION_CLOCK OSC_CLK_1_25MHZ
set_global_assignment -name USE_INIT_DONE SDM_IO0
set_global_assignment -name USE_HPS_COLD_RESET SDM_IO10
set_global_assignment -name PWRMGT_VOLTAGE_OUTPUT_FORMAT "LINEAR FORMAT"
set_global_assignment -name PWRMGT_LINEAR_FORMAT_N "-12"
set_global_assignment -name ON_CHIP_BITSTREAM_DECOMPRESSION OFF
set_global_assignment -name HPS_DAP_SPLIT_MODE "SDM PINS"
set_global_assignment -name HPS_DAP_NO_CERTIFICATE on
set_global_assignment -name AUTO_RESTART_CONFIGURATION OFF
set_global_assignment -name ENABLE_SIGNALTAP OFF
set_global_assignment -name POWER_APPLY_THERMAL_MARGIN ADDITIONAL
set_global_assignment -name STRATIX_JTAG_USER_CODE 11111111
set_global_assignment -name USE_CHECKSUM_AS_USERCODE OFF
set_global_assignment -name HPS_INITIALIZATION "HPS FIRST"
set_global_assignment -name QSPI_OWNERSHIP HPS

set_location_assignment PIN_T114 -to LPDDR4A_CA[0]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[0]
set_location_assignment PIN_P114 -to LPDDR4A_CA[1]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[1]
set_location_assignment PIN_V117 -to LPDDR4A_CA[2]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[2]
set_location_assignment PIN_T117 -to LPDDR4A_CA[3]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[3]
set_location_assignment PIN_M114 -to LPDDR4A_CA[4]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[4]
set_location_assignment PIN_K114 -to LPDDR4A_CA[5]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CA[5]
set_location_assignment PIN_V108 -to LPDDR4A_CKE
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CKE
set_location_assignment PIN_AK104 -to LPDDR4A_CK_N
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_CK_N
set_location_assignment PIN_AK107 -to LPDDR4A_CK_P
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_CK_P
set_location_assignment PIN_T105 -to LPDDR4A_CS_N
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_CS_N
set_location_assignment PIN_B119 -to LPDDR4A_DMA0
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DMA0
set_location_assignment PIN_F105 -to LPDDR4A_DMA1
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DMA1
set_location_assignment PIN_H87 -to LPDDR4A_DMB0
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DMB0
set_location_assignment PIN_B97 -to LPDDR4A_DMB1
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DMB1
set_location_assignment PIN_B128 -to LPDDR4A_DQ[0]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[0]
set_location_assignment PIN_A128 -to LPDDR4A_DQ[1]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[1]
set_location_assignment PIN_K117 -to LPDDR4A_DQ[10]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[10]
set_location_assignment PIN_M117 -to LPDDR4A_DQ[11]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[11]
set_location_assignment PIN_H108 -to LPDDR4A_DQ[12]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[12]
set_location_assignment PIN_F108 -to LPDDR4A_DQ[13]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[13]
set_location_assignment PIN_M108 -to LPDDR4A_DQ[14]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[14]
set_location_assignment PIN_K108 -to LPDDR4A_DQ[15]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[15]
set_location_assignment PIN_H98 -to LPDDR4A_DQ[16]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[16]
set_location_assignment PIN_F98 -to LPDDR4A_DQ[17]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[17]
set_location_assignment PIN_M98 -to LPDDR4A_DQ[18]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[18]
set_location_assignment PIN_K98 -to LPDDR4A_DQ[19]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[19]
set_location_assignment PIN_B130 -to LPDDR4A_DQ[2]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[2]
set_location_assignment PIN_K87 -to LPDDR4A_DQ[20]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[20]
set_location_assignment PIN_M87 -to LPDDR4A_DQ[21]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[21]
set_location_assignment PIN_F84 -to LPDDR4A_DQ[22]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[22]
set_location_assignment PIN_D84 -to LPDDR4A_DQ[23]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[23]
set_location_assignment PIN_A106 -to LPDDR4A_DQ[24]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[24]
set_location_assignment PIN_B103 -to LPDDR4A_DQ[25]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[25]
set_location_assignment PIN_B106 -to LPDDR4A_DQ[26]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[26]
set_location_assignment PIN_A110 -to LPDDR4A_DQ[27]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[27]
set_location_assignment PIN_B91 -to LPDDR4A_DQ[28]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[28]
set_location_assignment PIN_A94 -to LPDDR4A_DQ[29]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[29]
set_location_assignment PIN_A130 -to LPDDR4A_DQ[3]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[3]
set_location_assignment PIN_B88 -to LPDDR4A_DQ[30]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[30]
set_location_assignment PIN_A91 -to LPDDR4A_DQ[31]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[31]
set_location_assignment PIN_B116 -to LPDDR4A_DQ[4]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[4]
set_location_assignment PIN_A116 -to LPDDR4A_DQ[5]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[5]
set_location_assignment PIN_B113 -to LPDDR4A_DQ[6]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[6]
set_location_assignment PIN_A113 -to LPDDR4A_DQ[7]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[7]
set_location_assignment PIN_F117 -to LPDDR4A_DQ[8]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[8]
set_location_assignment PIN_H117 -to LPDDR4A_DQ[9]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_DQ[9]
set_location_assignment PIN_A125 -to LPDDR4A_DQSA0_n
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQSA0_n
set_location_assignment PIN_B122 -to LPDDR4A_DQSA0_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQSA0_p
set_location_assignment PIN_D114 -to LPDDR4A_DQSA1_n
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQSA1_n
set_location_assignment PIN_F114 -to LPDDR4A_DQSA1_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQSA1_p
set_location_assignment PIN_D95 -to LPDDR4A_DQSB0_n
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQSB0_n
set_location_assignment PIN_F95 -to LPDDR4A_DQSB0_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQSB0_p
set_location_assignment PIN_B101 -to LPDDR4A_DQSB1_n
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQSB1_n
set_location_assignment PIN_A101 -to LPDDR4A_DQSB1_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to LPDDR4A_DQSB1_p
set_location_assignment PIN_AK111 -to LPDDR4A_OCT_RZQIN
set_instance_assignment -name IO_STANDARD "1.1-V" -to LPDDR4A_OCT_RZQIN
set_location_assignment PIN_M105 -to LPDDR4A_REFCK_p
set_instance_assignment -name IO_STANDARD "1.1-V TRUE DIFFERENTIAL SIGNALING" -to LPDDR4A_REFCK_p
set_location_assignment PIN_K105 -to "LPDDR4A_REFCK_p(n)"
set_instance_assignment -name IO_STANDARD "1.1-V TRUE DIFFERENTIAL SIGNALING" -to "LPDDR4A_REFCK_p(n)"
set_location_assignment PIN_AG111 -to LPDDR4A_RST
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to LPDDR4A_RST
set_location_assignment PIN_T132 -to HPS_OSC_CLK_25MHz
set_instance_assignment -name IO_STANDARD "1.8-V" -to HPS_OSC_CLK_25MHz
set_location_assignment PIN_AK115 -to HPS_UART0_RX
set_instance_assignment -name IO_STANDARD "1.8-V" -to HPS_UART0_RX
set_location_assignment PIN_W134 -to HPS_UART0_TX
set_instance_assignment -name IO_STANDARD "1.8-V" -to HPS_UART0_TX

export_assignments

project_close

