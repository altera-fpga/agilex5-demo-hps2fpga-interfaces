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

set_location_assignment PIN_B20 -to ADDA_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to ADDA_CLK
set_location_assignment PIN_A20 -to ADDA_DIN
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to ADDA_DIN
set_location_assignment PIN_A23 -to ADDA_DOUT
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to ADDA_DOUT
set_location_assignment PIN_A17 -to ADDA_RST
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to ADDA_RST
set_location_assignment PIN_A14 -to ADDA_SYNC
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to ADDA_SYNC
set_location_assignment PIN_BF29 -to CT_HPD
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to CT_HPD
set_location_assignment PIN_CH4 -to DBG_RDX
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DBG_RDX
set_location_assignment PIN_BK22 -to DBG_TXD
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DBG_TXD
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_CLK0_M2C_n
set_location_assignment PIN_BK38 -to FMC_CLK0_M2C_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_CLK0_M2C_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_CLK1_M2C_n
set_location_assignment PIN_BF68 -to FMC_CLK1_M2C_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_CLK1_M2C_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_REFCK_C2M_n
set_location_assignment PIN_BE61 -to FMC_REFCK_C2M_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_REFCK_C2M_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_REFCK_M2C_n
set_location_assignment PIN_CH38 -to FMC_REFCK_M2C_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_REFCK_M2C_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_SYNC_C2M_n
set_location_assignment PIN_CH41 -to FMC_SYNC_C2M_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_SYNC_C2M_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_SYNC_M2C_n
set_location_assignment PIN_BH49 -to FMC_SYNC_M2C_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to FMC_SYNC_M2C_p
set_location_assignment PIN_CL54 -to FPGA_DIPSW[0]
set_instance_assignment -name IO_STANDARD "1.2 V" -to FPGA_DIPSW[0]
set_location_assignment PIN_CK63 -to FPGA_DIPSW[1]
set_instance_assignment -name IO_STANDARD "1.2 V" -to FPGA_DIPSW[1]
set_location_assignment PIN_B30 -to FPGA_PB[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to FPGA_PB[0]
set_location_assignment PIN_A30 -to FPGA_PB[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to FPGA_PB[1]
set_location_assignment PIN_BU19 -to FPGA_QSPI_CLK
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to FPGA_QSPI_CLK
set_location_assignment PIN_BM19 -to FPGA_QSPI_CS
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to FPGA_QSPI_CS
set_location_assignment PIN_BR19 -to FPGA_QSPI_D[0]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to FPGA_QSPI_D[0]
set_location_assignment PIN_CK4 -to FPGA_QSPI_D[1]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to FPGA_QSPI_D[1]
set_location_assignment PIN_CJ2 -to FPGA_QSPI_D[2]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to FPGA_QSPI_D[2]
set_location_assignment PIN_CK2 -to FPGA_QSPI_D[3]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to FPGA_QSPI_D[3]
set_location_assignment PIN_CH4 -to FPGA_QSPI_RST
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to FPGA_QSPI_RST
set_location_assignment PIN_CK134 -to FPGA_RST
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to FPGA_RST
set_location_assignment PIN_BK31 -to HDMI_CLK
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_CLK
set_location_assignment PIN_BU28 -to HDMI_D[0]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[0]
set_location_assignment PIN_BP31 -to HDMI_D[1]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[1]
set_location_assignment PIN_BR22 -to HDMI_D[10]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[10]
set_location_assignment PIN_CH12 -to HDMI_D[11]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[11]
set_location_assignment PIN_BU22 -to HDMI_D[12]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[12]
set_location_assignment PIN_BW19 -to HDMI_D[13]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[13]
set_location_assignment PIN_BH28 -to HDMI_D[14]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[14]
set_location_assignment PIN_BM22 -to HDMI_D[15]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[15]
set_location_assignment PIN_CF12 -to HDMI_D[16]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[16]
set_location_assignment PIN_BK19 -to HDMI_D[17]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[17]
set_location_assignment PIN_CF9 -to HDMI_D[18]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[18]
set_location_assignment PIN_BF21 -to HDMI_D[19]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[19]
set_location_assignment PIN_BR28 -to HDMI_D[2]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[2]
set_location_assignment PIN_BE21 -to HDMI_D[20]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[20]
set_location_assignment PIN_BE43 -to HDMI_D[21]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[21]
set_location_assignment PIN_BF40 -to HDMI_D[22]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[22]
set_location_assignment PIN_BE29 -to HDMI_D[23]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[23]
set_location_assignment PIN_BR31 -to HDMI_D[3]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[3]
set_location_assignment PIN_BU31 -to HDMI_D[4]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[4]
set_location_assignment PIN_BM28 -to HDMI_D[5]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[5]
set_location_assignment PIN_BW28 -to HDMI_D[6]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[6]
set_location_assignment PIN_BM31 -to HDMI_D[7]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[7]
set_location_assignment PIN_BP22 -to HDMI_D[8]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[8]
set_location_assignment PIN_BK28 -to HDMI_D[9]
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_D[9]
set_location_assignment PIN_BF36 -to HDMI_DE
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_DE
set_location_assignment PIN_BF32 -to HDMI_HS
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_HS
set_location_assignment PIN_BF16 -to HDMI_INT
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_INT
set_location_assignment PIN_BH19 -to HDMI_SPDIF
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_SPDIF
set_location_assignment PIN_BE25 -to HDMI_VS
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to HDMI_VS
set_location_assignment PIN_Y132 -to HPS_ETH2_MDC
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_MDC
set_location_assignment PIN_T127 -to HPS_ETH2_MDIO
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_MDIO
set_location_assignment PIN_T124 -to HPS_ETH2_RST
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_RST
set_location_assignment PIN_M124 -to HPS_ETH2_RXCK
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_RXCK
set_location_assignment PIN_AB127 -to HPS_ETH2_RXCTL
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_RXCTL
set_location_assignment PIN_H127 -to HPS_ETH2_RXD[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_RXD[0]
set_location_assignment PIN_AB124 -to HPS_ETH2_RXD[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_RXD[1]
set_location_assignment PIN_F124 -to HPS_ETH2_RXD[2]
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_RXD[2]
set_location_assignment PIN_D124 -to HPS_ETH2_RXD[3]
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_RXD[3]
set_location_assignment PIN_M127 -to HPS_ETH2_TXCK
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_TXCK
set_location_assignment PIN_K127 -to HPS_ETH2_TXCTL
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_TXCTL
set_location_assignment PIN_K124 -to HPS_ETH2_TXD[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_TXD[0]
set_location_assignment PIN_Y127 -to HPS_ETH2_TXD[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_TXD[1]
set_location_assignment PIN_F127 -to HPS_ETH2_TXD[2]
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_TXD[2]
set_location_assignment PIN_Y124 -to HPS_ETH2_TXD[3]
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_ETH2_TXD[3]
set_location_assignment PIN_AL120 -to HPS_I2C0_SCL
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_I2C0_SCL
set_location_assignment PIN_U134 -to HPS_I2C0_SDA
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_I2C0_SDA
set_location_assignment PIN_R134 -to HPS_LED0
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_LED0
set_location_assignment PIN_AG115 -to HPS_LED1
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_LED1
set_location_assignment PIN_T132 -to HPS_OSC_CLK_25MHz
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_OSC_CLK_25MHz
set_location_assignment PIN_AK115 -to HPS_UART0_RX
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_UART0_RX
set_location_assignment PIN_W134 -to HPS_UART0_TX
set_instance_assignment -name IO_STANDARD "1.8 V" -to HPS_UART0_TX
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA00_n
set_location_assignment PIN_CF19 -to LA00_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA00_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA01_n
set_location_assignment PIN_CF22 -to LA01_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA01_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA02_n
set_location_assignment PIN_CC22 -to LA02_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA02_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA03_n
set_location_assignment PIN_CF28 -to LA03_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA03_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA04_n
set_location_assignment PIN_CA31 -to LA04_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA04_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA05_n
set_location_assignment PIN_CH31 -to LA05_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA05_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA06_n
set_location_assignment PIN_CK8 -to LA06_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA06_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA07_n
set_location_assignment PIN_CK11 -to LA07_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA07_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA08_n
set_location_assignment PIN_CL14 -to LA08_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA08_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA09_n
set_location_assignment PIN_CK17 -to LA09_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA09_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA10_n
set_location_assignment PIN_CL20 -to LA10_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA10_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA11_n
set_location_assignment PIN_CL23 -to LA11_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA11_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA12_n
set_location_assignment PIN_BH38 -to LA12_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA12_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA13_n
set_location_assignment PIN_BF57 -to LA13_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA13_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA14_n
set_location_assignment PIN_BE46 -to LA14_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA14_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA15_n
set_location_assignment PIN_BE64 -to LA15_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA15_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA16_n
set_location_assignment PIN_BF50 -to LA16_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA16_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA17_n
set_location_assignment PIN_BR41 -to LA17_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA17_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA18_n
set_location_assignment PIN_BK49 -to LA18_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA18_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA19_n
set_location_assignment PIN_CK73 -to LA19_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA19_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA20_n
set_location_assignment PIN_CA38 -to LA20_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA20_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA21_n
set_location_assignment PIN_BR38 -to LA21_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA21_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA22_n
set_location_assignment PIN_CF49 -to LA22_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA22_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA23_n
set_location_assignment PIN_BW49 -to LA23_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA23_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA24_n
set_location_assignment PIN_CF52 -to LA24_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA24_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA25_n
set_location_assignment PIN_CL51 -to LA25_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA25_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA26_n
set_location_assignment PIN_BM52 -to LA26_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA26_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA27_n
set_location_assignment PIN_CC52 -to LA27_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA27_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA28_n
set_location_assignment PIN_BP41 -to LA28_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA28_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA29_n
set_location_assignment PIN_CK33 -to LA29_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA29_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA30_n
set_location_assignment PIN_CK35 -to LA30_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA30_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA31_n
set_location_assignment PIN_CK39 -to LA31_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA31_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA32_n
set_location_assignment PIN_CK48 -to LA32_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA32_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA33_n
set_location_assignment PIN_CL42 -to LA33_p
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V SSTL" -to LA33_p
set_location_assignment PIN_BR118 -to LED0B
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED0B
set_location_assignment PIN_CL125 -to LED0G
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED0G
set_location_assignment PIN_CK125 -to LED0R
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED0R
set_location_assignment PIN_CA118 -to LED1B
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED1B
set_location_assignment PIN_BW118 -to LED1G
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED1G
set_location_assignment PIN_CF118 -to LED1R
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED1R
set_location_assignment PIN_CL130 -to LED2B
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED2B
set_location_assignment PIN_CK128 -to LED2G
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED2G
set_location_assignment PIN_CL128 -to LED2R
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED2R
set_location_assignment PIN_CG135 -to LED3B
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED3B
set_location_assignment PIN_CH132 -to LED3G
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED3G
set_location_assignment PIN_CF128 -to LED3R
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED3R
set_location_assignment PIN_AK104 -to LPDDR4A_CK_N
set_location_assignment PIN_AK107 -to LPDDR4A_CK_P
set_location_assignment PIN_M105 -to LPDDR4A_REFCK_p
set_location_assignment PIN_G2 -to PWR_SCL
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to PWR_SCL
set_location_assignment PIN_J2 -to PWR_SDA
set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to PWR_SDA
set_location_assignment PIN_AC68 -to REFCLK_3B0_p
set_instance_assignment -name IO_STANDARD "1.2V TRUE DIFFERENTIAL SIGNALING" -to REFCLK_3B0_p
set_location_assignment PIN_D132 -to SD_CLK
set_instance_assignment -name IO_STANDARD "1.8 V" -to SD_CLK
set_location_assignment PIN_AB132 -to SD_CMD
set_instance_assignment -name IO_STANDARD "1.8 V" -to SD_CMD
set_location_assignment PIN_E135 -to SD_DAT[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to SD_DAT[0]
set_location_assignment PIN_F132 -to SD_DAT[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to SD_DAT[1]
set_location_assignment PIN_AA135 -to SD_DAT[2]
set_instance_assignment -name IO_STANDARD "1.8 V" -to SD_DAT[2]
set_location_assignment PIN_V127 -to SD_DAT[3]
set_instance_assignment -name IO_STANDARD "1.8 V" -to SD_DAT[3]
set_location_assignment PIN_P124 -to SD_DETECT
set_instance_assignment -name IO_STANDARD "1.8 V" -to SD_DETECT
set_location_assignment PIN_P132 -to USB_CLK
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_CLK
set_location_assignment PIN_AD135 -to USB_DATA[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_DATA[0]
set_location_assignment PIN_M132 -to USB_DATA[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_DATA[1]
set_location_assignment PIN_K132 -to USB_DATA[2]
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_DATA[2]
set_location_assignment PIN_AG129 -to USB_DATA[3]
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_DATA[3]
set_location_assignment PIN_J134 -to USB_DATA[4]
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_DATA[4]
set_location_assignment PIN_AG120 -to USB_DATA[5]
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_DATA[5]
set_location_assignment PIN_G134 -to USB_DATA[6]
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_DATA[6]
set_location_assignment PIN_G135 -to USB_DATA[7]
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_DATA[7]
set_location_assignment PIN_J135 -to USB_DIR
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_DIR
set_location_assignment PIN_BU118 -to USB_HUB_RST
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to USB_HUB_RST
set_location_assignment PIN_AD134 -to USB_NXT
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_NXT
set_location_assignment PIN_AP120 -to USB_REFCLK_p
set_location_assignment PIN_B134 -to USB_RST
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_RST
set_location_assignment PIN_AM133 -to USB_SSRX_n
set_location_assignment PIN_AM135 -to USB_SSRX_p
set_location_assignment PIN_AN126 -to USB_SSTX_n
set_location_assignment PIN_AN129 -to USB_SSTX_p
set_location_assignment PIN_L135 -to USB_STP
set_instance_assignment -name IO_STANDARD "1.8 V" -to USB_STP

export_assignments

project_close

