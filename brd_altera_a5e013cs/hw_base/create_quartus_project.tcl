#
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
set_global_assignment -name DEVICE A5ED013BM16AE4SCS
set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
set_global_assignment -name STRATIXV_CONFIGURATION_SCHEME "ACTIVE SERIAL X4"
set_global_assignment -name ACTIVE_SERIAL_CLOCK AS_FREQ_100MHZ
set_global_assignment -name DEVICE_INITIALIZATION_CLOCK OSC_CLK_1_100MHZ
set_global_assignment -name USE_HPS_COLD_RESET SDM_IO10
set_global_assignment -name USE_CONF_DONE SDM_IO16
set_global_assignment -name USE_INIT_DONE SDM_IO0
set_global_assignment -name SDM_DIRECT_TO_FACTORY_IMAGE SDM_IO13
set_global_assignment -name PWRMGT_VOLTAGE_OUTPUT_FORMAT "LINEAR FORMAT"
set_global_assignment -name PWRMGT_LINEAR_FORMAT_N "-12"
set_global_assignment -name NUMBER_OF_SLAVE_DEVICE 2
set_global_assignment -name ON_CHIP_BITSTREAM_DECOMPRESSION OFF
set_global_assignment -name HPS_DAP_SPLIT_MODE "SDM PINS"
set_global_assignment -name HPS_DAP_NO_CERTIFICATE on
set_global_assignment -name AUTO_RESTART_CONFIGURATION OFF
set_global_assignment -name ENABLE_SIGNALTAP OFF
set_global_assignment -name POWER_APPLY_THERMAL_MARGIN ADDITIONAL
set_global_assignment -name STRATIX_JTAG_USER_CODE 66666666
set_global_assignment -name USE_CHECKSUM_AS_USERCODE OFF
set_global_assignment -name HPS_INITIALIZATION "HPS FIRST"
set_global_assignment -name QSPI_OWNERSHIP HPS
set_global_assignment -name INI_VARS "asm_enable_advanced_devices=on"
set_global_assignment -name NUM_PARALLEL_PROCESSORS 4

set_location_assignment PIN_C2 -to emif_hps_emif_mem_0_mem_ca[0]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_ca[0]
set_location_assignment PIN_D3 -to emif_hps_emif_mem_0_mem_ca[1]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_ca[1]
set_location_assignment PIN_C3 -to emif_hps_emif_mem_0_mem_ca[2]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_ca[2]
set_location_assignment PIN_B3 -to emif_hps_emif_mem_0_mem_ca[3]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_ca[3]
set_location_assignment PIN_A6 -to emif_hps_emif_mem_0_mem_ca[4]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_ca[4]
set_location_assignment PIN_B5 -to emif_hps_emif_mem_0_mem_ca[5]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_ca[5]
set_location_assignment PIN_E10 -to emif_hps_emif_mem_0_mem_ck_c
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_ck_c
set_location_assignment PIN_A4 -to emif_hps_emif_mem_0_mem_cke
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_cke
set_location_assignment PIN_E9 -to emif_hps_emif_mem_0_mem_ck_t
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_ck_t
set_location_assignment PIN_C7 -to emif_hps_emif_mem_0_mem_cs
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_cs
set_location_assignment PIN_L7 -to emif_hps_emif_mem_0_mem_dmi[0]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dmi[0]
set_location_assignment PIN_K5 -to emif_hps_emif_mem_0_mem_dmi[1]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dmi[1]
set_location_assignment PIN_D13 -to emif_hps_emif_mem_0_mem_dmi[2]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dmi[2]
set_location_assignment PIN_B11 -to emif_hps_emif_mem_0_mem_dmi[3]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dmi[3]
set_location_assignment PIN_H6 -to emif_hps_emif_mem_0_mem_dq[0]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[0]
set_location_assignment PIN_H7 -to emif_hps_emif_mem_0_mem_dq[1]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[1]
set_location_assignment PIN_M3 -to emif_hps_emif_mem_0_mem_dq[10]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[10]
set_location_assignment PIN_L4 -to emif_hps_emif_mem_0_mem_dq[11]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[11]
set_location_assignment PIN_M4 -to emif_hps_emif_mem_0_mem_dq[12]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[12]
set_location_assignment PIN_G4 -to emif_hps_emif_mem_0_mem_dq[13]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[13]
set_location_assignment PIN_H3 -to emif_hps_emif_mem_0_mem_dq[14]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[14]
set_location_assignment PIN_H5 -to emif_hps_emif_mem_0_mem_dq[15]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[15]
set_location_assignment PIN_D15 -to emif_hps_emif_mem_0_mem_dq[16]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[16]
set_location_assignment PIN_C13 -to emif_hps_emif_mem_0_mem_dq[17]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[17]
set_location_assignment PIN_C10 -to emif_hps_emif_mem_0_mem_dq[18]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[18]
set_location_assignment PIN_D10 -to emif_hps_emif_mem_0_mem_dq[19]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[19]
set_location_assignment PIN_G5 -to emif_hps_emif_mem_0_mem_dq[2]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[2]
set_location_assignment PIN_C8 -to emif_hps_emif_mem_0_mem_dq[20]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[20]
set_location_assignment PIN_D9 -to emif_hps_emif_mem_0_mem_dq[21]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[21]
set_location_assignment PIN_D14 -to emif_hps_emif_mem_0_mem_dq[22]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[22]
set_location_assignment PIN_C15 -to emif_hps_emif_mem_0_mem_dq[23]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[23]
set_location_assignment PIN_A8 -to emif_hps_emif_mem_0_mem_dq[24]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[24]
set_location_assignment PIN_B8 -to emif_hps_emif_mem_0_mem_dq[25]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[25]
set_location_assignment PIN_A9 -to emif_hps_emif_mem_0_mem_dq[26]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[26]
set_location_assignment PIN_B9 -to emif_hps_emif_mem_0_mem_dq[27]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[27]
set_location_assignment PIN_B13 -to emif_hps_emif_mem_0_mem_dq[28]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[28]
set_location_assignment PIN_A13 -to emif_hps_emif_mem_0_mem_dq[29]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[29]
set_location_assignment PIN_G6 -to emif_hps_emif_mem_0_mem_dq[3]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[3]
set_location_assignment PIN_B14 -to emif_hps_emif_mem_0_mem_dq[30]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[30]
set_location_assignment PIN_A14 -to emif_hps_emif_mem_0_mem_dq[31]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[31]
set_location_assignment PIN_M6 -to emif_hps_emif_mem_0_mem_dq[4]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[4]
set_location_assignment PIN_N5 -to emif_hps_emif_mem_0_mem_dq[5]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[5]
set_location_assignment PIN_M5 -to emif_hps_emif_mem_0_mem_dq[6]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[6]
set_location_assignment PIN_L6 -to emif_hps_emif_mem_0_mem_dq[7]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[7]
set_location_assignment PIN_L3 -to emif_hps_emif_mem_0_mem_dq[8]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[8]
set_location_assignment PIN_J5 -to emif_hps_emif_mem_0_mem_dq[9]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dq[9]
set_location_assignment PIN_J7 -to emif_hps_emif_mem_0_mem_dqs_c[0]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dqs_c[0]
set_location_assignment PIN_J3 -to emif_hps_emif_mem_0_mem_dqs_c[1]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dqs_c[1]
set_location_assignment PIN_C11 -to emif_hps_emif_mem_0_mem_dqs_c[2]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dqs_c[2]
set_location_assignment PIN_A11 -to emif_hps_emif_mem_0_mem_dqs_c[3]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dqs_c[3]
set_location_assignment PIN_K7 -to emif_hps_emif_mem_0_mem_dqs_t[0]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dqs_t[0]
set_location_assignment PIN_J4 -to emif_hps_emif_mem_0_mem_dqs_t[1]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dqs_t[1]
set_location_assignment PIN_D12 -to emif_hps_emif_mem_0_mem_dqs_t[2]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dqs_t[2]
set_location_assignment PIN_B10 -to emif_hps_emif_mem_0_mem_dqs_t[3]
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_dqs_t[3]
set_location_assignment PIN_E15 -to emif_hps_emif_mem_0_mem_reset_n
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to emif_hps_emif_mem_0_mem_reset_n
set_location_assignment PIN_E14 -to emif_hps_emif_oct_0_oct_rzqin
set_instance_assignment -name IO_STANDARD "1.1-V" -to emif_hps_emif_oct_0_oct_rzqin
set_location_assignment PIN_A7 -to emif_hps_emif_ref_clk_0_clk
set_location_assignment PIN_B6 -to "emif_hps_emif_ref_clk_0_clk(n)"
set_instance_assignment -name IO_STANDARD "1.8-V" -to hps_osc_clk
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to hps_uart0_RX
set_location_assignment PIN_F24 -to hps_uart0_RX
set_instance_assignment -name IO_STANDARD "1.8-V" -to hps_uart0_RX
set_instance_assignment -name CURRENT_STRENGTH_NEW 4MA -to hps_uart0_TX
set_location_assignment PIN_C27 -to hps_uart0_TX
set_instance_assignment -name IO_STANDARD "1.8-V" -to hps_uart0_TX

export_assignments

project_close

