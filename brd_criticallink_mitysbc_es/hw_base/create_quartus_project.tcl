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
set_global_assignment -name DEVICE A5ED065BB32AE6SR0
set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
set_global_assignment -name STRATIXV_CONFIGURATION_SCHEME "ACTIVE SERIAL X4"
set_global_assignment -name ACTIVE_SERIAL_CLOCK AS_FREQ_100MHZ
set_global_assignment -name DEVICE_INITIALIZATION_CLOCK OSC_CLK_1_25MHZ
set_global_assignment -name USE_CONF_DONE SDM_IO16
set_global_assignment -name USE_INIT_DONE SDM_IO0
set_global_assignment -name USE_HPS_COLD_RESET SDM_IO10
set_global_assignment -name PWRMGT_VOLTAGE_OUTPUT_FORMAT "LINEAR FORMAT"
set_global_assignment -name PWRMGT_LINEAR_FORMAT_N "-12"
set_global_assignment -name ON_CHIP_BITSTREAM_DECOMPRESSION OFF
set_global_assignment -name HPS_DAP_SPLIT_MODE "SDM PINS"
set_global_assignment -name HPS_DAP_NO_CERTIFICATE on
#	set_global_assignment -name AUTO_RESTART_CONFIGURATION OFF
set_global_assignment -name ENABLE_SIGNALTAP OFF
set_global_assignment -name POWER_APPLY_THERMAL_MARGIN ADDITIONAL
set_global_assignment -name STRATIX_JTAG_USER_CODE 22222222
set_global_assignment -name USE_CHECKSUM_AS_USERCODE OFF
set_global_assignment -name HPS_INITIALIZATION "HPS FIRST"
set_global_assignment -name IOBANK_VCCIO 1.3V -section_id 2B_T
set_global_assignment -name IOBANK_VCCIO 1.3V -section_id 2B_B
set_global_assignment -name IOBANK_VCCIO 1.1V -section_id 2A_T
set_global_assignment -name IOBANK_VCCIO 1.1V -section_id 2A_B
set_global_assignment -name IOBANK_VCCIO 3.3V -section_id 5B
set_global_assignment -name IOBANK_VCCIO 3.3V -section_id 5A
set_global_assignment -name IOBANK_VCCIO 1.1V -section_id 3A_B
set_global_assignment -name IOBANK_VCCIO 1.1V -section_id 3A_T
set_global_assignment -name IOBANK_VCCIO 1.2V -section_id 3B_B
set_global_assignment -name IOBANK_VCCIO 1.2V -section_id 3B_T
set_global_assignment -name IOBANK_VCCIO 1.8V -section_id 6D
set_global_assignment -name IOBANK_VCCIO 1.8V -section_id 6C
set_global_assignment -name IOBANK_VCCIO 1.8V -section_id 6B
set_global_assignment -name IOBANK_VCCIO 1.8V -section_id 6A

set_location_assignment PIN_BR89 -to fpga_mem_ca[0]
set_location_assignment PIN_BU89 -to fpga_mem_ca[1]
set_location_assignment PIN_BR92 -to fpga_mem_ca[2]
set_location_assignment PIN_BU92 -to fpga_mem_ca[3]
set_location_assignment PIN_BW89 -to fpga_mem_ca[4]
set_location_assignment PIN_CA89 -to fpga_mem_ca[5]
set_location_assignment PIN_BP81 -to fpga_mem_ck_c
set_location_assignment PIN_BR81 -to fpga_mem_cke[0]
set_location_assignment PIN_BU81 -to fpga_mem_cke[1]
set_location_assignment PIN_BM81 -to fpga_mem_ck_t
set_location_assignment PIN_BR78 -to fpga_mem_cs[0]
set_location_assignment PIN_BU78 -to fpga_mem_cs[1]
set_location_assignment PIN_CK85 -to fpga_mem_dmi[0]
set_location_assignment PIN_CF81 -to fpga_mem_dmi[1]
set_location_assignment PIN_BU62 -to fpga_mem_dmi[2]
set_location_assignment PIN_CA62 -to fpga_mem_dmi[3]
set_location_assignment PIN_CL91 -to fpga_mem_dq[0]
set_location_assignment PIN_CK94 -to fpga_mem_dq[1]
set_location_assignment PIN_CF92 -to fpga_mem_dq[10]
set_location_assignment PIN_CH92 -to fpga_mem_dq[11]
set_location_assignment PIN_CA81 -to fpga_mem_dq[12]
set_location_assignment PIN_CC81 -to fpga_mem_dq[13]
set_location_assignment PIN_CH78 -to fpga_mem_dq[14]
set_location_assignment PIN_CF78 -to fpga_mem_dq[15]
set_location_assignment PIN_BR69 -to fpga_mem_dq[16]
set_location_assignment PIN_BU69 -to fpga_mem_dq[17]
set_location_assignment PIN_BR71 -to fpga_mem_dq[18]
set_location_assignment PIN_BU71 -to fpga_mem_dq[19]
set_location_assignment PIN_CK97 -to fpga_mem_dq[2]
set_location_assignment PIN_BU59 -to fpga_mem_dq[20]
set_location_assignment PIN_BR59 -to fpga_mem_dq[21]
set_location_assignment PIN_BW59 -to fpga_mem_dq[22]
set_location_assignment PIN_CA59 -to fpga_mem_dq[23]
set_location_assignment PIN_CF71 -to fpga_mem_dq[24]
set_location_assignment PIN_CH71 -to fpga_mem_dq[25]
set_location_assignment PIN_CC71 -to fpga_mem_dq[26]
set_location_assignment PIN_CA71 -to fpga_mem_dq[27]
set_location_assignment PIN_CF62 -to fpga_mem_dq[28]
set_location_assignment PIN_CH62 -to fpga_mem_dq[29]
set_location_assignment PIN_CL97 -to fpga_mem_dq[3]
set_location_assignment PIN_CF59 -to fpga_mem_dq[30]
set_location_assignment PIN_CH59 -to fpga_mem_dq[31]
set_location_assignment PIN_CK80 -to fpga_mem_dq[4]
set_location_assignment PIN_CL82 -to fpga_mem_dq[5]
set_location_assignment PIN_CK76 -to fpga_mem_dq[6]
set_location_assignment PIN_CL76 -to fpga_mem_dq[7]
set_location_assignment PIN_CC92 -to fpga_mem_dq[8]
set_location_assignment PIN_CA92 -to fpga_mem_dq[9]
set_location_assignment PIN_CK88 -to fpga_mem_dqs_c[0]
set_location_assignment PIN_CF89 -to fpga_mem_dqs_c[1]
set_location_assignment PIN_CA69 -to fpga_mem_dqs_c[2]
set_location_assignment PIN_CF69 -to fpga_mem_dqs_c[3]
set_location_assignment PIN_CL88 -to fpga_mem_dqs_t[0]
set_location_assignment PIN_CH89 -to fpga_mem_dqs_t[1]
set_location_assignment PIN_BW69 -to fpga_mem_dqs_t[2]
set_location_assignment PIN_CH69 -to fpga_mem_dqs_t[3]
set_location_assignment PIN_BH92 -to fpga_mem_reset_n
set_location_assignment PIN_BH89 -to fpga_oct_rzqin
set_location_assignment PIN_T114 -to hps_mem_ca[0]
set_location_assignment PIN_P114 -to hps_mem_ca[1]
set_location_assignment PIN_V117 -to hps_mem_ca[2]
set_location_assignment PIN_T117 -to hps_mem_ca[3]
set_location_assignment PIN_M114 -to hps_mem_ca[4]
set_location_assignment PIN_K114 -to hps_mem_ca[5]
set_location_assignment PIN_AK104 -to hps_mem_ck_c
set_location_assignment PIN_V108 -to hps_mem_cke[0]
set_location_assignment PIN_T108 -to hps_mem_cke[1]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to hps_mem_cke[1]
set_location_assignment PIN_AK107 -to hps_mem_ck_t
set_location_assignment PIN_T105 -to hps_mem_cs[0]
set_location_assignment PIN_P105 -to hps_mem_cs[1]
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to hps_mem_cs[1]
set_location_assignment PIN_B119 -to hps_mem_dmi[0]
set_location_assignment PIN_F105 -to hps_mem_dmi[1]
set_location_assignment PIN_H87 -to hps_mem_dmi[2]
set_location_assignment PIN_B97 -to hps_mem_dmi[3]
set_location_assignment PIN_B128 -to hps_mem_dq[0]
set_location_assignment PIN_A128 -to hps_mem_dq[1]
set_location_assignment PIN_K117 -to hps_mem_dq[10]
set_location_assignment PIN_M117 -to hps_mem_dq[11]
set_location_assignment PIN_H108 -to hps_mem_dq[12]
set_location_assignment PIN_F108 -to hps_mem_dq[13]
set_location_assignment PIN_M108 -to hps_mem_dq[14]
set_location_assignment PIN_K108 -to hps_mem_dq[15]
set_location_assignment PIN_H98 -to hps_mem_dq[16]
set_location_assignment PIN_F98 -to hps_mem_dq[17]
set_location_assignment PIN_M98 -to hps_mem_dq[18]
set_location_assignment PIN_K98 -to hps_mem_dq[19]
set_location_assignment PIN_B130 -to hps_mem_dq[2]
set_location_assignment PIN_K87 -to hps_mem_dq[20]
set_location_assignment PIN_M87 -to hps_mem_dq[21]
set_location_assignment PIN_F84 -to hps_mem_dq[22]
set_location_assignment PIN_D84 -to hps_mem_dq[23]
set_location_assignment PIN_A106 -to hps_mem_dq[24]
set_location_assignment PIN_B103 -to hps_mem_dq[25]
set_location_assignment PIN_B106 -to hps_mem_dq[26]
set_location_assignment PIN_A110 -to hps_mem_dq[27]
set_location_assignment PIN_B91 -to hps_mem_dq[28]
set_location_assignment PIN_A94 -to hps_mem_dq[29]
set_location_assignment PIN_A130 -to hps_mem_dq[3]
set_location_assignment PIN_B88 -to hps_mem_dq[30]
set_location_assignment PIN_A91 -to hps_mem_dq[31]
set_location_assignment PIN_B116 -to hps_mem_dq[4]
set_location_assignment PIN_A116 -to hps_mem_dq[5]
set_location_assignment PIN_B113 -to hps_mem_dq[6]
set_location_assignment PIN_A113 -to hps_mem_dq[7]
set_location_assignment PIN_F117 -to hps_mem_dq[8]
set_location_assignment PIN_H117 -to hps_mem_dq[9]
set_location_assignment PIN_A125 -to hps_mem_dqs_c[0]
set_location_assignment PIN_D114 -to hps_mem_dqs_c[1]
set_location_assignment PIN_D95 -to hps_mem_dqs_c[2]
set_location_assignment PIN_B101 -to hps_mem_dqs_c[3]
set_location_assignment PIN_B122 -to hps_mem_dqs_t[0]
set_location_assignment PIN_F114 -to hps_mem_dqs_t[1]
set_location_assignment PIN_F95 -to hps_mem_dqs_t[2]
set_location_assignment PIN_A101 -to hps_mem_dqs_t[3]
set_location_assignment PIN_AG111 -to hps_mem_reset_n
set_location_assignment PIN_AK111 -to hps_oct_rzqin
set_location_assignment PIN_BM71 -to i_clk
set_instance_assignment -name IO_STANDARD "1.1-V LVSTL" -to i_clk
set_location_assignment PIN_B76 -to i_dphy_link0_cn
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link0_cn
set_location_assignment PIN_A80 -to i_dphy_link0_cp
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link0_cp
set_location_assignment PIN_B82 -to i_dphy_link0_dn[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link0_dn[0]
set_location_assignment PIN_A85 -to i_dphy_link0_dn[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link0_dn[1]
set_location_assignment PIN_A76 -to i_dphy_link0_dn[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link0_dn[2]
set_location_assignment PIN_A70 -to i_dphy_link0_dn[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link0_dn[3]
set_location_assignment PIN_A82 -to i_dphy_link0_dp[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link0_dp[0]
set_location_assignment PIN_B85 -to i_dphy_link0_dp[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link0_dp[1]
set_location_assignment PIN_B73 -to i_dphy_link0_dp[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link0_dp[2]
set_location_assignment PIN_B70 -to i_dphy_link0_dp[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link0_dp[3]
set_location_assignment PIN_F74 -to i_dphy_link1_cn
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link1_cn
set_location_assignment PIN_D74 -to i_dphy_link1_cp
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link1_cp
set_location_assignment PIN_M77 -to i_dphy_link1_dn[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link1_dn[0]
set_location_assignment PIN_H77 -to i_dphy_link1_dn[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link1_dn[1]
set_location_assignment PIN_K67 -to i_dphy_link1_dn[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link1_dn[2]
set_location_assignment PIN_F67 -to i_dphy_link1_dn[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link1_dn[3]
set_location_assignment PIN_K77 -to i_dphy_link1_dp[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link1_dp[0]
set_location_assignment PIN_F77 -to i_dphy_link1_dp[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link1_dp[1]
set_location_assignment PIN_M67 -to i_dphy_link1_dp[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link1_dp[2]
set_location_assignment PIN_H67 -to i_dphy_link1_dp[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link1_dp[3]
set_location_assignment PIN_K74 -to i_dphy_link2_cn
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link2_cn
set_location_assignment PIN_M74 -to i_dphy_link2_cp
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link2_cp
set_location_assignment PIN_T74 -to i_dphy_link2_dn[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link2_dn[0]
set_location_assignment PIN_T77 -to i_dphy_link2_dn[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link2_dn[1]
set_location_assignment PIN_T67 -to i_dphy_link2_dn[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link2_dn[2]
set_location_assignment PIN_K65 -to i_dphy_link2_dn[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link2_dn[3]
set_location_assignment PIN_P74 -to i_dphy_link2_dp[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link2_dp[0]
set_location_assignment PIN_V77 -to i_dphy_link2_dp[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link2_dp[1]
set_location_assignment PIN_V67 -to i_dphy_link2_dp[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link2_dp[2]
set_location_assignment PIN_M65 -to i_dphy_link2_dp[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link2_dp[3]
set_location_assignment PIN_AG53 -to i_dphy_link3_cn
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link3_cn
set_location_assignment PIN_AG57 -to i_dphy_link3_cp
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link3_cp
set_location_assignment PIN_AG64 -to i_dphy_link3_dn[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link3_dn[0]
set_location_assignment PIN_AC61 -to i_dphy_link3_dn[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link3_dn[1]
set_location_assignment PIN_AC50 -to i_dphy_link3_dn[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link3_dn[2]
set_location_assignment PIN_Y55 -to i_dphy_link3_dn[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link3_dn[3]
set_location_assignment PIN_AC64 -to i_dphy_link3_dp[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link3_dp[0]
set_location_assignment PIN_AG61 -to i_dphy_link3_dp[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link3_dp[1]
set_location_assignment PIN_AC53 -to i_dphy_link3_dp[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link3_dp[2]
set_location_assignment PIN_Y58 -to i_dphy_link3_dp[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link3_dp[3]
set_location_assignment PIN_M55 -to i_dphy_link4_cn
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link4_cn
set_location_assignment PIN_K55 -to i_dphy_link4_cp
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link4_cp
set_location_assignment PIN_T55 -to i_dphy_link4_dn[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link4_dn[0]
set_location_assignment PIN_T58 -to i_dphy_link4_dn[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link4_dn[1]
set_location_assignment PIN_T47 -to i_dphy_link4_dn[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link4_dn[2]
set_location_assignment PIN_T44 -to i_dphy_link4_dn[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link4_dn[3]
set_location_assignment PIN_P55 -to i_dphy_link4_dp[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link4_dp[0]
set_location_assignment PIN_V58 -to i_dphy_link4_dp[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link4_dp[1]
set_location_assignment PIN_V47 -to i_dphy_link4_dp[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link4_dp[2]
set_location_assignment PIN_P44 -to i_dphy_link4_dp[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link4_dp[3]
set_location_assignment PIN_D55 -to i_dphy_link5_cn
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link5_cn
set_location_assignment PIN_F55 -to i_dphy_link5_cp
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link5_cp
set_location_assignment PIN_F58 -to i_dphy_link5_dn[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link5_dn[0]
set_location_assignment PIN_K58 -to i_dphy_link5_dn[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link5_dn[1]
set_location_assignment PIN_K47 -to i_dphy_link5_dn[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link5_dn[2]
set_location_assignment PIN_H47 -to i_dphy_link5_dn[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link5_dn[3]
set_location_assignment PIN_H58 -to i_dphy_link5_dp[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link5_dp[0]
set_location_assignment PIN_M58 -to i_dphy_link5_dp[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link5_dp[1]
set_location_assignment PIN_M47 -to i_dphy_link5_dp[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link5_dp[2]
set_location_assignment PIN_F47 -to i_dphy_link5_dp[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link5_dp[3]
set_location_assignment PIN_B54 -to i_dphy_link6_cn
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link6_cn
set_location_assignment PIN_A54 -to i_dphy_link6_cp
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link6_cp
set_location_assignment PIN_A60 -to i_dphy_link6_dn[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link6_dn[0]
set_location_assignment PIN_B60 -to i_dphy_link6_dn[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link6_dn[1]
set_location_assignment PIN_A51 -to i_dphy_link6_dn[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link6_dn[2]
set_location_assignment PIN_A48 -to i_dphy_link6_dn[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link6_dn[3]
set_location_assignment PIN_B56 -to i_dphy_link6_dp[0]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link6_dp[0]
set_location_assignment PIN_A63 -to i_dphy_link6_dp[1]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link6_dp[1]
set_location_assignment PIN_B51 -to i_dphy_link6_dp[2]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link6_dp[2]
set_location_assignment PIN_B45 -to i_dphy_link6_dp[3]
set_instance_assignment -name IO_STANDARD DPHY -to i_dphy_link6_dp[3]
set_location_assignment PIN_BW78 -to i_fpga_emif_ref_clk
set_instance_assignment -name IO_STANDARD "1.1V TRUE DIFFERENTIAL SIGNALING" -to i_fpga_emif_ref_clk
set_location_assignment PIN_M105 -to i_hps_emif_ref_clk
set_instance_assignment -name IO_STANDARD "1.1V TRUE DIFFERENTIAL SIGNALING" -to i_hps_emif_ref_clk
set_location_assignment PIN_Y124 -to i_hps_osc_clk
set_location_assignment PIN_AC68 -to i_mipi_dphy_clk
set_instance_assignment -name IO_STANDARD "1.2V TRUE DIFFERENTIAL SIGNALING" -to i_mipi_dphy_clk
set_location_assignment PIN_AC72 -to "i_mipi_dphy_clk(n)"
set_instance_assignment -name IO_STANDARD "1.2V TRUE DIFFERENTIAL SIGNALING" -to "i_mipi_dphy_clk(n)"
set_location_assignment PIN_AC79 -to i_mipi_dphy_rzq
set_instance_assignment -name IO_STANDARD "1.2 V" -to i_mipi_dphy_rzq
set_location_assignment PIN_AB127 -to i_uart1_rx
set_location_assignment PIN_M124 -to i_uart1_tx
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to i_usb1_faultn
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to i_usbc_id
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to o_USB1_muxenable_n

export_assignments

project_close

