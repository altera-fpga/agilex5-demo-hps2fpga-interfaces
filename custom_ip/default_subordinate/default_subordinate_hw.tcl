#
# SPDX-FileCopyrightText: Copyright (C) 2021-2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
package require -exact qsys 21.3


#
# module default_subordinate
#
set_module_property DESCRIPTION "A trivial default subordinate that implements a variety of useful responses."
set_module_property NAME default_subordinate
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR RSF
set_module_property DISPLAY_NAME default_subordinate
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property LOAD_ELABORATION_LIMIT 0
set_module_property ELABORATION_CALLBACK elaboration


#
# file sets
#
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL default_subordinate
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file default_subordinate.v VERILOG PATH default_subordinate.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL default_subordinate
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file default_subordinate.v VERILOG PATH default_subordinate.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL default_subordinate
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file default_subordinate.v VERILOG PATH default_subordinate.v


#
# HDL parameters
#
add_parameter ALLOW_AWREADY INTEGER 1 ""
set_parameter_property ALLOW_AWREADY DEFAULT_VALUE 1
set_parameter_property ALLOW_AWREADY DISPLAY_NAME "Assert awready and wready"
set_parameter_property ALLOW_AWREADY UNITS None
set_parameter_property ALLOW_AWREADY ALLOWED_RANGES {0:NO 1:YES}
set_parameter_property ALLOW_AWREADY DESCRIPTION "Set YES to allow the subordinate to assert the awready and wready strobes to accept write command and data transactions.  Set NO to disallow the subordinate from asserting these strobes which will cause any request to the interface to stall forever."
set_parameter_property ALLOW_AWREADY AFFECTS_GENERATION false
set_parameter_property ALLOW_AWREADY HDL_PARAMETER true

add_parameter ALLOW_ARREADY INTEGER 1 ""
set_parameter_property ALLOW_ARREADY DEFAULT_VALUE 1
set_parameter_property ALLOW_ARREADY DISPLAY_NAME "Assert arready"
set_parameter_property ALLOW_ARREADY UNITS None
set_parameter_property ALLOW_ARREADY ALLOWED_RANGES {0:NO 1:YES}
set_parameter_property ALLOW_ARREADY DESCRIPTION "Set YES to allow the subordinate to assert the arready strobe to accept read command transactions.  Set NO to disallow the subordinate from asserting this strobe which will cause any request to the interface to stall forever."
set_parameter_property ALLOW_ARREADY AFFECTS_GENERATION false
set_parameter_property ALLOW_ARREADY HDL_PARAMETER true

add_parameter ALLOW_BVALID INTEGER 1 ""
set_parameter_property ALLOW_BVALID DEFAULT_VALUE 1
set_parameter_property ALLOW_BVALID DISPLAY_NAME "Assert bvalid"
set_parameter_property ALLOW_BVALID WIDTH ""
set_parameter_property ALLOW_BVALID UNITS None
set_parameter_property ALLOW_BVALID ALLOWED_RANGES {0:NO 1:YES}
set_parameter_property ALLOW_BVALID DESCRIPTION "Set YES to allow the subordinate to assert the bvalid strobe to respond to write command and data transactions.  Set NO to disallow the subordinate from asserting this strobe which will cause any write request accepted by the interface to go unanswered.  This will leave the manager that requested the transaction waiting forever."
set_parameter_property ALLOW_BVALID AFFECTS_GENERATION false
set_parameter_property ALLOW_BVALID HDL_PARAMETER true

add_parameter ALLOW_RVALID INTEGER 1 ""
set_parameter_property ALLOW_RVALID DEFAULT_VALUE 1
set_parameter_property ALLOW_RVALID DISPLAY_NAME "Assert rvalid"
set_parameter_property ALLOW_RVALID UNITS None
set_parameter_property ALLOW_RVALID ALLOWED_RANGES {0:NO 1:YES}
set_parameter_property ALLOW_RVALID DESCRIPTION "Set YES to allow the subordinate to assert the rvalid strobe to respond to read command transactions.  Set NO to disallow the subordinate from asserting this strobe which will cause any read request accepted by the interface to go unanswered.  This will leave the manager that requested the transaction waiting forever."
set_parameter_property ALLOW_RVALID AFFECTS_GENERATION false
set_parameter_property ALLOW_RVALID HDL_PARAMETER true

add_parameter DEFAULT_BRESP STD_LOGIC_VECTOR 0 ""
set_parameter_property DEFAULT_BRESP DEFAULT_VALUE 0
set_parameter_property DEFAULT_BRESP DISPLAY_NAME "bresp value"
set_parameter_property DEFAULT_BRESP WIDTH 2
set_parameter_property DEFAULT_BRESP UNITS None
set_parameter_property DEFAULT_BRESP ALLOWED_RANGES {0:OKAY 2:SLVERR 3:DECERR}
set_parameter_property DEFAULT_BRESP DESCRIPTION "Set the bresp value that should be returned in the write transaction response.<br><br>2'b00:OKAY<br>2'b10:SLVERR<br>2'b11:DECERR"
set_parameter_property DEFAULT_BRESP AFFECTS_GENERATION false
set_parameter_property DEFAULT_BRESP HDL_PARAMETER true

add_parameter DEFAULT_RRESP STD_LOGIC_VECTOR 0 ""
set_parameter_property DEFAULT_RRESP DEFAULT_VALUE 0
set_parameter_property DEFAULT_RRESP DISPLAY_NAME "rresp value"
set_parameter_property DEFAULT_RRESP WIDTH 2
set_parameter_property DEFAULT_RRESP UNITS None
set_parameter_property DEFAULT_RRESP ALLOWED_RANGES {0:OKAY 2:SLVERR 3:DECERR}
set_parameter_property DEFAULT_RRESP DESCRIPTION "Set the rresp value that should be returned in the read transaction response.<br><br>2'b00:OKAY<br>2'b10:SLVERR<br>2'b11:DECERR"
set_parameter_property DEFAULT_RRESP AFFECTS_GENERATION false
set_parameter_property DEFAULT_RRESP HDL_PARAMETER true

add_parameter DEFAULT_RDATA STD_LOGIC_VECTOR 0 ""
set_parameter_property DEFAULT_RDATA DEFAULT_VALUE 0x0000006f
set_parameter_property DEFAULT_RDATA DISPLAY_NAME "rdata value"
set_parameter_property DEFAULT_RDATA WIDTH 32
set_parameter_property DEFAULT_RDATA UNITS None
set_parameter_property DEFAULT_RDATA DESCRIPTION "Set the rdata value that should be returned in the read transaction response.<br><br>NOTE: the Nios V instruction 'jal x0, 0' causes the Nios V to jump to the same address as the instruction.  The value for that Nios V instruction is 'h0000_006F.  This could be used to capture the Nios V into an infinite loop if it ever executes an instruction fetch from this subordinate."
set_parameter_property DEFAULT_RDATA AFFECTS_GENERATION false
set_parameter_property DEFAULT_RDATA HDL_PARAMETER true


#
# display parameters
#
add_parameter USE_AWVALID_RESET INTEGER 1 ""
set_parameter_property USE_AWVALID_RESET DEFAULT_VALUE 1
set_parameter_property USE_AWVALID_RESET DISPLAY_NAME "Use awvalid_reset"
set_parameter_property USE_AWVALID_RESET UNITS None
set_parameter_property USE_AWVALID_RESET DISPLAY_HINT BOOLEAN
set_parameter_property USE_AWVALID_RESET DESCRIPTION "Enable this to expose the awvalid_reset interface port.  Disable this to hide it.  This port drives active when a write command transaction request is detected by the subordinate."
set_parameter_property USE_AWVALID_RESET AFFECTS_GENERATION false
set_parameter_property USE_AWVALID_RESET AFFECTS_ELABORATION true
set_parameter_property USE_AWVALID_RESET HDL_PARAMETER false

add_parameter USE_WVALID_RESET INTEGER 1 ""
set_parameter_property USE_WVALID_RESET DEFAULT_VALUE 1
set_parameter_property USE_WVALID_RESET DISPLAY_NAME "Use wvalid_reset"
set_parameter_property USE_WVALID_RESET UNITS None
set_parameter_property USE_WVALID_RESET DISPLAY_HINT BOOLEAN
set_parameter_property USE_WVALID_RESET DESCRIPTION "Enable this to expose the wvalid_reset interface port.  Disable this to hide it.  This port drives active when a write data transaction request is detected by the subordinate."
set_parameter_property USE_WVALID_RESET AFFECTS_GENERATION false
set_parameter_property USE_WVALID_RESET AFFECTS_ELABORATION true
set_parameter_property USE_WVALID_RESET HDL_PARAMETER false

add_parameter USE_ARVALID_RESET INTEGER 1 ""
set_parameter_property USE_ARVALID_RESET DEFAULT_VALUE 1
set_parameter_property USE_ARVALID_RESET DISPLAY_NAME "Use arvalid_reset"
set_parameter_property USE_ARVALID_RESET UNITS None
set_parameter_property USE_ARVALID_RESET DISPLAY_HINT BOOLEAN
set_parameter_property USE_ARVALID_RESET DESCRIPTION "Enable this to expose the arvalid_reset interface port.  Disable this to hide it.  This port drives active when a read command transaction request is detected by the subordinate."
set_parameter_property USE_ARVALID_RESET AFFECTS_GENERATION false
set_parameter_property USE_ARVALID_RESET AFFECTS_ELABORATION true
set_parameter_property USE_ARVALID_RESET HDL_PARAMETER false

add_parameter USE_ANY_VALID_RESET INTEGER 1 ""
set_parameter_property USE_ANY_VALID_RESET DEFAULT_VALUE 1
set_parameter_property USE_ANY_VALID_RESET DISPLAY_NAME "Use any_valid_reset"
set_parameter_property USE_ANY_VALID_RESET UNITS None
set_parameter_property USE_ANY_VALID_RESET DISPLAY_HINT BOOLEAN
set_parameter_property USE_ANY_VALID_RESET DESCRIPTION "Enable this to expose the any_valid_reset interface port.  Disable this to hide it.  This port drives active when any valid transaction request is detected by the subordinate."
set_parameter_property USE_ANY_VALID_RESET AFFECTS_GENERATION false
set_parameter_property USE_ANY_VALID_RESET AFFECTS_ELABORATION true
set_parameter_property USE_ANY_VALID_RESET HDL_PARAMETER false



add_parameter USE_AWVALID_IRQ INTEGER 1 ""
set_parameter_property USE_AWVALID_IRQ DEFAULT_VALUE 1
set_parameter_property USE_AWVALID_IRQ DISPLAY_NAME "Use awvalid_irq"
set_parameter_property USE_AWVALID_IRQ UNITS None
set_parameter_property USE_AWVALID_IRQ DISPLAY_HINT BOOLEAN
set_parameter_property USE_AWVALID_IRQ DESCRIPTION "Enable this to expose the awvalid_irq interface port.  Disable this to hide it.  This port drives active when a write command transaction request is detected by the subordinate."
set_parameter_property USE_AWVALID_IRQ AFFECTS_GENERATION false
set_parameter_property USE_AWVALID_IRQ AFFECTS_ELABORATION true
set_parameter_property USE_AWVALID_IRQ HDL_PARAMETER false

add_parameter USE_WVALID_IRQ INTEGER 1 ""
set_parameter_property USE_WVALID_IRQ DEFAULT_VALUE 1
set_parameter_property USE_WVALID_IRQ DISPLAY_NAME "Use wvalid_irq"
set_parameter_property USE_WVALID_IRQ UNITS None
set_parameter_property USE_WVALID_IRQ DISPLAY_HINT BOOLEAN
set_parameter_property USE_WVALID_IRQ DESCRIPTION "Enable this to expose the wvalid_irq interface port.  Disable this to hide it.  This port drives active when a write data transaction request is detected by the subordinate."
set_parameter_property USE_WVALID_IRQ AFFECTS_GENERATION false
set_parameter_property USE_WVALID_IRQ AFFECTS_ELABORATION true
set_parameter_property USE_WVALID_IRQ HDL_PARAMETER false

add_parameter USE_ARVALID_IRQ INTEGER 1 ""
set_parameter_property USE_ARVALID_IRQ DEFAULT_VALUE 1
set_parameter_property USE_ARVALID_IRQ DISPLAY_NAME "Use arvalid_irq"
set_parameter_property USE_ARVALID_IRQ UNITS None
set_parameter_property USE_ARVALID_IRQ DISPLAY_HINT BOOLEAN
set_parameter_property USE_ARVALID_IRQ DESCRIPTION "Enable this to expose the arvalid_irq interface port.  Disable this to hide it.  This port drives active when a read command transaction request is detected by the subordinate."
set_parameter_property USE_ARVALID_IRQ AFFECTS_GENERATION false
set_parameter_property USE_ARVALID_IRQ AFFECTS_ELABORATION true
set_parameter_property USE_ARVALID_IRQ HDL_PARAMETER false

add_parameter USE_ANY_VALID_IRQ INTEGER 1 ""
set_parameter_property USE_ANY_VALID_IRQ DEFAULT_VALUE 1
set_parameter_property USE_ANY_VALID_IRQ DISPLAY_NAME "Use any_valid_irq"
set_parameter_property USE_ANY_VALID_IRQ UNITS None
set_parameter_property USE_ANY_VALID_IRQ DISPLAY_HINT BOOLEAN
set_parameter_property USE_ANY_VALID_IRQ DESCRIPTION "Enable this to expose the any_valid_irq interface port.  Disable this to hide it.  This port drives active when any valid transaction request is detected by the subordinate."
set_parameter_property USE_ANY_VALID_IRQ AFFECTS_GENERATION false
set_parameter_property USE_ANY_VALID_IRQ AFFECTS_ELABORATION true
set_parameter_property USE_ANY_VALID_IRQ HDL_PARAMETER false



add_parameter USE_AWVALID_COND INTEGER 1 ""
set_parameter_property USE_AWVALID_COND DEFAULT_VALUE 1
set_parameter_property USE_AWVALID_COND DISPLAY_NAME "Use awvalid_cond"
set_parameter_property USE_AWVALID_COND UNITS None
set_parameter_property USE_AWVALID_COND DISPLAY_HINT BOOLEAN
set_parameter_property USE_AWVALID_COND DESCRIPTION "Enable this to expose the awvalid_cond interface port.  Disable this to hide it.  This port drives active when a write command transaction request is detected by the subordinate."
set_parameter_property USE_AWVALID_COND AFFECTS_GENERATION false
set_parameter_property USE_AWVALID_COND AFFECTS_ELABORATION true
set_parameter_property USE_AWVALID_COND HDL_PARAMETER false

add_parameter USE_WVALID_COND INTEGER 1 ""
set_parameter_property USE_WVALID_COND DEFAULT_VALUE 1
set_parameter_property USE_WVALID_COND DISPLAY_NAME "Use wvalid_cond"
set_parameter_property USE_WVALID_COND UNITS None
set_parameter_property USE_WVALID_COND DISPLAY_HINT BOOLEAN
set_parameter_property USE_WVALID_COND DESCRIPTION "Enable this to expose the wvalid_cond interface port.  Disable this to hide it.  This port drives active when a write data transaction request is detected by the subordinate."
set_parameter_property USE_WVALID_COND AFFECTS_GENERATION false
set_parameter_property USE_WVALID_COND AFFECTS_ELABORATION true
set_parameter_property USE_WVALID_COND HDL_PARAMETER false

add_parameter USE_ARVALID_COND INTEGER 1 ""
set_parameter_property USE_ARVALID_COND DEFAULT_VALUE 1
set_parameter_property USE_ARVALID_COND DISPLAY_NAME "Use arvalid_cond"
set_parameter_property USE_ARVALID_COND UNITS None
set_parameter_property USE_ARVALID_COND DISPLAY_HINT BOOLEAN
set_parameter_property USE_ARVALID_COND DESCRIPTION "Enable this to expose the arvalid_cond interface port.  Disable this to hide it.  This port drives active when a read command transaction request is detected by the subordinate."
set_parameter_property USE_ARVALID_COND AFFECTS_GENERATION false
set_parameter_property USE_ARVALID_COND AFFECTS_ELABORATION true
set_parameter_property USE_ARVALID_COND HDL_PARAMETER false

add_parameter USE_ANY_VALID_COND INTEGER 1 ""
set_parameter_property USE_ANY_VALID_COND DEFAULT_VALUE 1
set_parameter_property USE_ANY_VALID_COND DISPLAY_NAME "Use any_valid_cond"
set_parameter_property USE_ANY_VALID_COND UNITS None
set_parameter_property USE_ANY_VALID_COND DISPLAY_HINT BOOLEAN
set_parameter_property USE_ANY_VALID_COND DESCRIPTION "Enable this to expose the any_valid_cond interface port.  Disable this to hide it.  This port drives active when any valid transaction request is detected by the subordinate."
set_parameter_property USE_ANY_VALID_COND AFFECTS_GENERATION false
set_parameter_property USE_ANY_VALID_COND AFFECTS_ELABORATION true
set_parameter_property USE_ANY_VALID_COND HDL_PARAMETER false


#
# display items
#
add_display_item "Overview" OVERVIEW00 TEXT "This component implements a trivial default subordinate that implements a variety of useful responses."
add_display_item "Overview" OVERVIEW01 TEXT "Hover over the parameters below to read the tool tips which contain additional details."

add_display_item "Write Channel Options" ALLOW_AWREADY PARAMETER ""
add_display_item "Write Channel Options" ALLOW_BVALID PARAMETER ""
add_display_item "Write Channel Options" DEFAULT_BRESP PARAMETER ""

add_display_item "Read Channel Options" ALLOW_ARREADY PARAMETER ""
add_display_item "Read Channel Options" ALLOW_RVALID PARAMETER ""
add_display_item "Read Channel Options" DEFAULT_RRESP PARAMETER ""
add_display_item "Read Channel Options" DEFAULT_RDATA PARAMETER ""

add_display_item "Status Reset Interfaces" USE_AWVALID_RESET PARAMETER ""
add_display_item "Status Reset Interfaces" USE_WVALID_RESET PARAMETER ""
add_display_item "Status Reset Interfaces" USE_ARVALID_RESET PARAMETER ""
add_display_item "Status Reset Interfaces" USE_ANY_VALID_RESET PARAMETER ""

add_display_item "Status Interrupt Interfaces" USE_AWVALID_IRQ PARAMETER ""
add_display_item "Status Interrupt Interfaces" USE_WVALID_IRQ PARAMETER ""
add_display_item "Status Interrupt Interfaces" USE_ARVALID_IRQ PARAMETER ""
add_display_item "Status Interrupt Interfaces" USE_ANY_VALID_IRQ PARAMETER ""

add_display_item "Status Conduit Interfaces" USE_AWVALID_COND PARAMETER ""
add_display_item "Status Conduit Interfaces" USE_WVALID_COND PARAMETER ""
add_display_item "Status Conduit Interfaces" USE_ARVALID_COND PARAMETER ""
add_display_item "Status Conduit Interfaces" USE_ANY_VALID_COND PARAMETER ""


#
# connection point clock
#
add_interface clock clock end
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""
set_interface_property clock IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port clock clk clk Input 1


#
# connection point reset
#
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""
set_interface_property reset IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port reset reset reset Input 1


#
# connection point default_sub
#
add_interface default_sub axi4lite end
set_interface_property default_sub associatedClock clock
set_interface_property default_sub associatedReset reset
set_interface_property default_sub readAcceptanceCapability 1
set_interface_property default_sub writeAcceptanceCapability 1
set_interface_property default_sub combinedAcceptanceCapability 1
set_interface_property default_sub bridgesToMaster ""
set_interface_property default_sub ENABLED true
set_interface_property default_sub EXPORT_OF ""
set_interface_property default_sub PORT_NAME_MAP ""
set_interface_property default_sub CMSIS_SVD_VARIABLES ""
set_interface_property default_sub SVD_ADDRESS_GROUP ""
set_interface_property default_sub IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port default_sub default_sub_araddr araddr Input 12
add_interface_port default_sub default_sub_arprot arprot Input 3
add_interface_port default_sub default_sub_arready arready Output 1
add_interface_port default_sub default_sub_arvalid arvalid Input 1
add_interface_port default_sub default_sub_awaddr awaddr Input 12
add_interface_port default_sub default_sub_awprot awprot Input 3
add_interface_port default_sub default_sub_awready awready Output 1
add_interface_port default_sub default_sub_awvalid awvalid Input 1
add_interface_port default_sub default_sub_bready bready Input 1
add_interface_port default_sub default_sub_bresp bresp Output 2
add_interface_port default_sub default_sub_bvalid bvalid Output 1
add_interface_port default_sub default_sub_rdata rdata Output 32
add_interface_port default_sub default_sub_rready rready Input 1
add_interface_port default_sub default_sub_rresp rresp Output 2
add_interface_port default_sub default_sub_rvalid rvalid Output 1
add_interface_port default_sub default_sub_wdata wdata Input 32
add_interface_port default_sub default_sub_wready wready Output 1
add_interface_port default_sub default_sub_wstrb wstrb Input 4
add_interface_port default_sub default_sub_wvalid wvalid Input 1


#
# connection point awvalid_reset
#
add_interface awvalid_reset reset start
set_interface_property awvalid_reset associatedClock ""
set_interface_property awvalid_reset associatedDirectReset ""
set_interface_property awvalid_reset associatedResetSinks "reset"
set_interface_property awvalid_reset synchronousEdges NONE
set_interface_property awvalid_reset ENABLED true
set_interface_property awvalid_reset EXPORT_OF ""
set_interface_property awvalid_reset PORT_NAME_MAP ""
set_interface_property awvalid_reset CMSIS_SVD_VARIABLES ""
set_interface_property awvalid_reset SVD_ADDRESS_GROUP ""
set_interface_property awvalid_reset IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port awvalid_reset awvalid_reset reset Output 1


#
# connection point wvalid_reset
#
add_interface wvalid_reset reset start
set_interface_property wvalid_reset associatedClock ""
set_interface_property wvalid_reset associatedDirectReset ""
set_interface_property wvalid_reset associatedResetSinks "reset"
set_interface_property wvalid_reset synchronousEdges NONE
set_interface_property wvalid_reset ENABLED true
set_interface_property wvalid_reset EXPORT_OF ""
set_interface_property wvalid_reset PORT_NAME_MAP ""
set_interface_property wvalid_reset CMSIS_SVD_VARIABLES ""
set_interface_property wvalid_reset SVD_ADDRESS_GROUP ""
set_interface_property wvalid_reset IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port wvalid_reset wvalid_reset reset Output 1


#
# connection point arvalid_reset
#
add_interface arvalid_reset reset start
set_interface_property arvalid_reset associatedClock ""
set_interface_property arvalid_reset associatedDirectReset ""
set_interface_property arvalid_reset associatedResetSinks "reset"
set_interface_property arvalid_reset synchronousEdges NONE
set_interface_property arvalid_reset ENABLED true
set_interface_property arvalid_reset EXPORT_OF ""
set_interface_property arvalid_reset PORT_NAME_MAP ""
set_interface_property arvalid_reset CMSIS_SVD_VARIABLES ""
set_interface_property arvalid_reset SVD_ADDRESS_GROUP ""
set_interface_property arvalid_reset IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port arvalid_reset arvalid_reset reset Output 1


#
# connection point any_valid_reset
#
add_interface any_valid_reset reset start
set_interface_property any_valid_reset associatedClock ""
set_interface_property any_valid_reset associatedDirectReset ""
set_interface_property any_valid_reset associatedResetSinks "reset"
set_interface_property any_valid_reset synchronousEdges NONE
set_interface_property any_valid_reset ENABLED true
set_interface_property any_valid_reset EXPORT_OF ""
set_interface_property any_valid_reset PORT_NAME_MAP ""
set_interface_property any_valid_reset CMSIS_SVD_VARIABLES ""
set_interface_property any_valid_reset SVD_ADDRESS_GROUP ""
set_interface_property any_valid_reset IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port any_valid_reset any_valid_reset reset Output 1


#
# connection point awvalid_irq
#
add_interface awvalid_irq interrupt end
set_interface_property awvalid_irq associatedClock clock
set_interface_property awvalid_irq associatedReset reset
set_interface_property awvalid_irq bridgedReceiverOffset ""
set_interface_property awvalid_irq bridgesToReceiver ""
set_interface_property awvalid_irq ENABLED true
set_interface_property awvalid_irq EXPORT_OF ""
set_interface_property awvalid_irq PORT_NAME_MAP ""
set_interface_property awvalid_irq CMSIS_SVD_VARIABLES ""
set_interface_property awvalid_irq SVD_ADDRESS_GROUP ""
set_interface_property awvalid_irq IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port awvalid_irq awvalid_irq irq Output 1


#
# connection point wvalid_irq
#
add_interface wvalid_irq interrupt end
set_interface_property wvalid_irq associatedClock clock
set_interface_property wvalid_irq associatedReset reset
set_interface_property wvalid_irq bridgedReceiverOffset ""
set_interface_property wvalid_irq bridgesToReceiver ""
set_interface_property wvalid_irq ENABLED true
set_interface_property wvalid_irq EXPORT_OF ""
set_interface_property wvalid_irq PORT_NAME_MAP ""
set_interface_property wvalid_irq CMSIS_SVD_VARIABLES ""
set_interface_property wvalid_irq SVD_ADDRESS_GROUP ""
set_interface_property wvalid_irq IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port wvalid_irq wvalid_irq irq Output 1


#
# connection point arvalid_irq
#
add_interface arvalid_irq interrupt end
set_interface_property arvalid_irq associatedClock clock
set_interface_property arvalid_irq associatedReset reset
set_interface_property arvalid_irq bridgedReceiverOffset ""
set_interface_property arvalid_irq bridgesToReceiver ""
set_interface_property arvalid_irq ENABLED true
set_interface_property arvalid_irq EXPORT_OF ""
set_interface_property arvalid_irq PORT_NAME_MAP ""
set_interface_property arvalid_irq CMSIS_SVD_VARIABLES ""
set_interface_property arvalid_irq SVD_ADDRESS_GROUP ""
set_interface_property arvalid_irq IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port arvalid_irq arvalid_irq irq Output 1


#
# connection point any_valid_irq
#
add_interface any_valid_irq interrupt end
set_interface_property any_valid_irq associatedClock clock
set_interface_property any_valid_irq associatedReset reset
set_interface_property any_valid_irq bridgedReceiverOffset ""
set_interface_property any_valid_irq bridgesToReceiver ""
set_interface_property any_valid_irq ENABLED true
set_interface_property any_valid_irq EXPORT_OF ""
set_interface_property any_valid_irq PORT_NAME_MAP ""
set_interface_property any_valid_irq CMSIS_SVD_VARIABLES ""
set_interface_property any_valid_irq SVD_ADDRESS_GROUP ""
set_interface_property any_valid_irq IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port any_valid_irq any_valid_irq irq Output 1


#
# connection point awvalid_cond
#
add_interface awvalid_cond conduit end
set_interface_property awvalid_cond associatedClock clock
set_interface_property awvalid_cond associatedReset reset
set_interface_property awvalid_cond ENABLED true
set_interface_property awvalid_cond EXPORT_OF ""
set_interface_property awvalid_cond PORT_NAME_MAP ""
set_interface_property awvalid_cond CMSIS_SVD_VARIABLES ""
set_interface_property awvalid_cond SVD_ADDRESS_GROUP ""
set_interface_property awvalid_cond IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port awvalid_cond awvalid_conduit awvalid_cond Output 1


#
# connection point wvalid_cond
#
add_interface wvalid_cond conduit end
set_interface_property wvalid_cond associatedClock clock
set_interface_property wvalid_cond associatedReset reset
set_interface_property wvalid_cond ENABLED true
set_interface_property wvalid_cond EXPORT_OF ""
set_interface_property wvalid_cond PORT_NAME_MAP ""
set_interface_property wvalid_cond CMSIS_SVD_VARIABLES ""
set_interface_property wvalid_cond SVD_ADDRESS_GROUP ""
set_interface_property wvalid_cond IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port wvalid_cond wvalid_conduit wvalid_cond Output 1


#
# connection point arvalid_cond
#
add_interface arvalid_cond conduit end
set_interface_property arvalid_cond associatedClock clock
set_interface_property arvalid_cond associatedReset reset
set_interface_property arvalid_cond ENABLED true
set_interface_property arvalid_cond EXPORT_OF ""
set_interface_property arvalid_cond PORT_NAME_MAP ""
set_interface_property arvalid_cond CMSIS_SVD_VARIABLES ""
set_interface_property arvalid_cond SVD_ADDRESS_GROUP ""
set_interface_property arvalid_cond IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port arvalid_cond arvalid_conduit arvalid_cond Output 1


#
# connection point any_valid_cond
#
add_interface any_valid_cond conduit end
set_interface_property any_valid_cond associatedClock clock
set_interface_property any_valid_cond associatedReset reset
set_interface_property any_valid_cond ENABLED true
set_interface_property any_valid_cond EXPORT_OF ""
set_interface_property any_valid_cond PORT_NAME_MAP ""
set_interface_property any_valid_cond CMSIS_SVD_VARIABLES ""
set_interface_property any_valid_cond SVD_ADDRESS_GROUP ""
set_interface_property any_valid_cond IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port any_valid_cond any_valid_conduit any_valid_cond Output 1


#
# elaboration function
#
proc elaboration {} {

set_interface_property awvalid_reset   ENABLED [ get_parameter_value USE_AWVALID_RESET ]
set_interface_property wvalid_reset    ENABLED [ get_parameter_value USE_WVALID_RESET ]
set_interface_property arvalid_reset   ENABLED [ get_parameter_value USE_ARVALID_RESET ]
set_interface_property any_valid_reset ENABLED [ get_parameter_value USE_ANY_VALID_RESET ]

set_interface_property awvalid_irq   ENABLED [ get_parameter_value USE_AWVALID_IRQ ]
set_interface_property wvalid_irq    ENABLED [ get_parameter_value USE_WVALID_IRQ ]
set_interface_property arvalid_irq   ENABLED [ get_parameter_value USE_ARVALID_IRQ ]
set_interface_property any_valid_irq ENABLED [ get_parameter_value USE_ANY_VALID_IRQ ]

set_interface_property awvalid_cond   ENABLED [ get_parameter_value USE_AWVALID_COND ]
set_interface_property wvalid_cond    ENABLED [ get_parameter_value USE_WVALID_COND ]
set_interface_property arvalid_cond   ENABLED [ get_parameter_value USE_ARVALID_COND ]
set_interface_property any_valid_cond ENABLED [ get_parameter_value USE_ANY_VALID_COND ]

}

