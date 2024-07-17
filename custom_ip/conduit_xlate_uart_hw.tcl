#
# SPDX-FileCopyrightText: Copyright (C) 2023-2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require -exact qsys 22.2


#
# module conduit_xlate_uart
#
set_module_property DESCRIPTION "Translate HPS UART conduit to FPGA UART conduit."
set_module_property NAME conduit_xlate_uart
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "RSF"
set_module_property DISPLAY_NAME conduit_xlate_uart
set_module_property INSTANTIATE_IN_SYSTEM_MODULE false
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property LOAD_ELABORATION_LIMIT 0


#
# file sets
#

#
# parameters
#


#
# display items
#


#
# connection point hps_uart
#
add_interface hps_uart conduit end
set_interface_property hps_uart associatedClock ""
set_interface_property hps_uart associatedReset ""
set_interface_property hps_uart ENABLED true
set_interface_property hps_uart EXPORT_OF ""
set_interface_property hps_uart PORT_NAME_MAP ""
set_interface_property hps_uart CMSIS_SVD_VARIABLES ""
set_interface_property hps_uart SVD_ADDRESS_GROUP ""
set_interface_property hps_uart IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port hps_uart uart_cts_n cts_n Output 1
add_interface_port hps_uart uart_dsr_n dsr_n Output 1
add_interface_port hps_uart uart_dcd_n dcd_n Output 1
add_interface_port hps_uart uart_ri_n ri_n Output 1
add_interface_port hps_uart uart_rx rx Output 1
add_interface_port hps_uart uart_dtr_n dtr_n Input 1
add_interface_port hps_uart uart_rts_n rts_n Input 1
add_interface_port hps_uart uart_in1_n out1_n Input 1
add_interface_port hps_uart uart_in2_n out2_n Input 1
add_interface_port hps_uart uart_tx tx Input 1

set_port_property uart_cts_n DRIVEN_BY "1'b0"
set_port_property uart_dsr_n DRIVEN_BY "1'b0"
set_port_property uart_dcd_n DRIVEN_BY "1'b0"
set_port_property uart_ri_n DRIVEN_BY "1'b1"
set_port_property uart_rx DRIVEN_BY "uart_io_txd"


#
# connection point fpga_uart_io
#
add_interface fpga_uart_io conduit end
set_interface_property fpga_uart_io associatedClock ""
set_interface_property fpga_uart_io associatedReset ""
set_interface_property fpga_uart_io ENABLED true
set_interface_property fpga_uart_io EXPORT_OF ""
set_interface_property fpga_uart_io PORT_NAME_MAP ""
set_interface_property fpga_uart_io CMSIS_SVD_VARIABLES ""
set_interface_property fpga_uart_io SVD_ADDRESS_GROUP ""
set_interface_property fpga_uart_io IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port fpga_uart_io uart_io_rxd rxd Output 1
add_interface_port fpga_uart_io uart_io_txd txd Input 1

set_port_property uart_io_rxd DRIVEN_BY "uart_tx"

