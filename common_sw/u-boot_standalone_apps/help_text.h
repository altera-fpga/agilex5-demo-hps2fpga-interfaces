/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#ifndef __HELP_TEXT_H__
#define __HELP_TEXT_H__

//------------------------------------------------------------------------------
#define BLANK_LINES_30 \
"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

//------------------------------------------------------------------------------
#define A_menu_HELP_TEXT \
"Print attributions for third party projects\n\
\n\
    This menu will execute the u-boot script 'script-attribution' from\n\
    the demo FIT image which prints the attributions for this project\n\
    and third party projects included within it."

//------------------------------------------------------------------------------
#define L_menu_HELP_TEXT \
"Start the demo Linux environment\n\
\n\
    This menu will execute the u-boot script 'script-start-linux' from\n\
    the demo FIT image which loads the Linux kernel image into memory\n\
    and boots it.\n\
\n\
    The Linux kernel image is a self contained Linux environment that\n\
    requires no additional resources.  It contains an initramfs embedded\n\
    within it for a rootfs."

//------------------------------------------------------------------------------
#define s_menu_HELP_TEXT \
"System Counter / Generic Timer Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    No FPGA core logic design required.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates the Armv8 system counter functionality, also known as\n\
    the generic timer.  The demo shows how the system counter can be\n\
    read using an assembly language instruction to read from a system\n\
    register within the processor itself or how it can be read using a\n\
    load instruction to access the system counter from the external\n\
    memory map.\n\
\n\
    The demo reads the system counter ten times and reports how long\n\
    each access takes for both the assembly instruction method\n\
    and the memory map load method."

//------------------------------------------------------------------------------
#define a_menu_HELP_TEXT \
"Armv8 Registers Demo - Current CPU Status\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    No FPGA core logic design required.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates how to read various Armv8 registers and explains what\n\
    information they contain."

//------------------------------------------------------------------------------
#define v_menu_HELP_TEXT \
"Reading Sensors Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    No FPGA core logic design required.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates how to read the voltage and temperature sensor values\n\
    from the SDM.  The program issues SMC traps to invoke the ATF API to\n\
    query the sensor values.\n\
\n\
    NOTE: in order to read the FPGA die temperature sensors, an FPGA\n\
          core logic design must be loaded which activates the sensor.\n\
          If a design is loaded which does not activate a sensor, then\n\
          that sensor will not provide any readings.  This can affect\n\
          core fabric sensors as well as XCVR sensors.\n\
\n\
    NOTE: the on die sensors are not calibrated on ES silicon.  So while\n\
          this demonstrates functionally how to read the sensor values,\n\
          they are not accurate on ES silicon."

//------------------------------------------------------------------------------
#define q_menu_HELP_TEXT \
"SDM Query Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    No FPGA core logic design required.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates how to query various information from the SDM.  The\n\
    demo issues SMC traps to invoke the ATF API to query the values.\n\
\n\
    The following values are queried from the SDM:\n\
\n\
        - SDM FIRMWARE VERSION\n\
        - JTAG USERCODE\n\
        - CHIP ID"

//------------------------------------------------------------------------------
#define o_menu_HELP_TEXT \
"Cache Registers Demo - Current Cache Sizes\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    No FPGA core logic design required.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates how to read the cache status registers for the L1, L2\n\
    and L3 caches on the processor.\n\
\n\
    NOTE: the L1 and L2 cache sizes are different on the Cortex A55 and\n\
          Cortex A76 processor cores."

//------------------------------------------------------------------------------
#define g_menu_HELP_TEXT \
"HPS GP Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the HPS GPOUT port back into the\n\
    HPS GPIN port.  Both of these interfaces are 32-bits wide.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates how to access the HPS GPOUT and GPIN registers.\n\
\n\
    The demo measures the time that it takes to read and write the\n\
    registers as it executes and reports the results in the demo summary\n\
    output.  The demo walks a one bit through every bit position of the\n\
    HPS GPOUT port and reads back the value presented to the HPS GPIN\n\
    port."

//------------------------------------------------------------------------------
#define i_menu_HELP_TEXT \
"F2H IRQ Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the HPS GPOUT interface to the lower\n\
    32-bits of the F2H IRQ interface.  The F2H IRQ interface is 64-bits\n\
    wide but we only exercise the lower 32-bits with this hardware demo.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates how the lower 32-bits of the F2H IRQ vector can be\n\
    sampled programmatically from the GIC peripheral.\n\
\n\
    The demo can write values to the HPS GPOUT interface and verify the\n\
    read back value by reading the ISPENDRx registers from the GIC.\n\
\n\
    The demo measures the time that it takes to read the values from the\n\
    GIC and reports the results in the demo summary output."

//------------------------------------------------------------------------------
#define l_menu_HELP_TEXT \
"F2H IRQ Handler Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the HPS GPOUT interface to the lower\n\
    32-bits of the F2H IRQ interface.  The F2H IRQ interface is 64-bits\n\
    wide but we only exercise the lower 32-bits with this hardware demo.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates how the lower 32-bits of the F2H IRQ vector can be\n\
    sampled by an interrupt through the GIC.\n\
\n\
    The demo can write values to the HPS GPOUT interface to trigger GIC\n\
    interrupts.  The demo installs a trivial bare metal interrupt\n\
    handler to capture the interrupts and handle them.\n\
\n\
    The demo measures the time that it takes to respond to the interrupt\n\
    events and reports the results in the demo summary output."

//------------------------------------------------------------------------------
#define z_menu_HELP_TEXT \
"Configuration Clock Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects a 32-bit counter clocked by the\n\
    configuration clock to the HPS GPIN interface.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demo measures the frequency of the SDM configuration clock that is\n\
    provided into the core FPGA logic.\n\
\n\
    The demo can read the configuration clocked counter value through\n\
    the GPIN port.  By using the system counter in the processor, the\n\
    demo can calculate the frequency of the SDM configuration clock\n\
    provided to the FPGA core logic.\n\
","\n\
    The SDM configuration clock should be 250MHz on 4S and 5S speed\n\
    grade devices and 200MHz on 6S speed grade devices because our\n\
    Quartus project defines the SDM OSC_CLK frequency so that the SDM\n\
    can provide a precise frequency based on the external oscillator\n\
    frequency.  When the Quartus project does not define an SDM OSC_CLK\n\
    frequency, then the SDM uses an internal oscillator that will\n\
    produce a clock rate of 160MHz to 230MHz into the FPGA core logic."

//------------------------------------------------------------------------------
#define y_menu_HELP_TEXT \
"H2F User Clock Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects two 32-bit counters, each clocked by\n\
    one of the h2f_userX_clocks, to the HPS GPIN interface\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demo measures the frequency of the two H2F USER CLOCKs that are\n\
    provided into the core FPGA logic.\n\
\n\
    The demo can read the h2f_userX clocked counter values through the\n\
    HPS GPIN port.  By using the system counter in the processor, the\n\
    demo can calculate the frequency of the two h2f_userX_clocks\n\
    provided to the FPGA core logic.\n\
\n\
    The h2f_user0_clock frequency should be 200MHz and the\n\
    h2f_user1_clock frequency should be 400MHz.  These frequencies are\n\
    defined in the HPS instance parameters that were chosen for this\n\
    hardware design example in Platform Designer."

//------------------------------------------------------------------------------
#define x_menu_HELP_TEXT \
"LWH2F Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the LWH2F bridge to FPGA onchip\n\
    memory cores as well as a default subordinate core and a System ID\n\
    core.  A 2KB FPGA onchip memory core is connected to the lowest 2KB\n\
    address span of the LWH2F bridge span and a second 2KB FPGA onchip\n\
    memory core is connected to the highest 2KB address span.  The\n\
    default subordinate core is marked as the default slave for\n\
    the LWH2F interface so any transactions that are not directed to the\n\
    FPGA onchip memory cores will result in an access to the default\n\
    subordinate.  The default subordinate is configured to respond with\n\
    an AXI decode error, which results in a bus error, or data abort\n\
    SError within the CPU.\n\
\n",\
"SOFTWARE DEMO OVERVIEW\n\
    Demonstrates accesses into the 512MB span of the LWH2F bridge.\n\
\n\
    The demo measures how long it takes to read and write the FPGA\n\
    onchip memory cores through the LWH2F bridge and reports the timing\n\
    results in the demo summary output."

//------------------------------------------------------------------------------
#define w_menu_HELP_TEXT \
"LWH2F Default Subordinate Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the LWH2F bridge to FPGA onchip\n\
    memory cores as well as a default subordinate core and a System ID\n\
    core.  A 2KB FPGA onchip memory core is connected to the lowest 2KB\n\
    address span of the LWH2F bridge span and a second 2KB FPGA onchip\n\
    memory core is connected to the highest 2KB address span.  The\n\
    default subordinate core is marked as the default slave for the\n\
    LWH2F interface so any transactions that are not directed to the\n\
    FPGA onchip memory cores will result in an access to the default\n\
    subordinate.  The default subordinate is configured to respond with\n\
    an AXI decode error, which results in a bus error, or data abort\n\
    SError within the CPU.\n\
\n",\
"SOFTWARE DEMO OVERVIEW\n\
    Demonstrates an access into the 512MB span of the LWH2F bridge which\n\
    touches an undecoded address.\n\
\n\
    The demo measures how long it takes to trigger the default slave and\n\
    handle the corresponding data abort exception that results.  The\n\
    timing is reported in the demo summary output."

//------------------------------------------------------------------------------
#define t_menu_HELP_TEXT \
"H2F Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the H2F bridge to FPGA onchip memory\n\
    cores as well as a default subordinate core and a System ID core.\n\
    For each of the 1GB, 15GB and 240GB address span apertures\n\
    addressable by the H2F bridge, a 2KB FPGA onchip memory core is\n\
    connected to the lowest 2KB address span and a second 2KB FPGA\n\
    onchip memory core is connected to the highest 2KB address span of\n\
    each aperture.  The default subordinate core is marked as the\n\
    default slave for the H2F interface so any transactions that are not\n\
    directed to the FPGA onchip memory cores will result in an access to\n\
    the default subordinate.  The default subordinate is configured to\n\
    respond with an AXI decode error, which results in a bus error, or\n\
    data abort SError within the CPU.\n\
\n",\
"SOFTWARE DEMO OVERVIEW\n\
    Demonstrates accesses into the 1GB, 15GB and 240GB aperture spans of\n\
    the H2F bridge.\n\
\n\
    The demo measures how long it takes to read and write the FPGA\n\
    onchip memory cores through the H2F bridge and reports the timing\n\
    results in the demo summary output."

//------------------------------------------------------------------------------
#define r_menu_HELP_TEXT \
"H2F Default Subordinate Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the H2F bridge to FPGA onchip memory\n\
    cores as well as a default subordinate core and a System ID core.\n\
    For each of the 1GB, 15GB and 240GB address span apertures\n\
    addressable by the H2F bridge, a 2KB FPGA onchip memory core is\n\
    connected to the lowest 2KB address span and a second 2KB FPGA\n\
    onchip memory core is connected to the highest 2KB address span of\n\
    each aperture.  The default subordinate core is marked as the\n\
    default slave for the H2F interface so any transactions that are not\n\
    directed to the FPGA onchip memory cores will result in an access to\n\
    the default subordinate.  The default subordinate is configured to\n\
    respond with an AXI decode error, which results in a bus error, or\n\
    data abort SError within the CPU.\n\
\n",\
"SOFTWARE DEMO OVERVIEW\n\
    Demonstrates an access into the 1GB aperture span of the H2F bridge\n\
    which touches an undecoded address.\n\
\n\
    The demo measures how long it takes to trigger the default slave and\n\
    handle the corresponding data abort exception that results.  The\n\
    timing is reported in the demo summary output."

//------------------------------------------------------------------------------
#define p_menu_HELP_TEXT \
"F2SDRAM Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects an MSGDMA core to the F2SDRAM bridge\n\
    and a 32KB FPGA onchip memory core to facilitate DMA data movement\n\
    to/from the HPS EMIF memory and to/from the FPGA onchip memory.  The\n\
    LWH2F bridge is connected to the CSR slave of the MSGDMA to\n\
    facilitate control and monitoring of the core.  A System ID core is\n\
    also connected to the LWH2F bridge.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates DMA of a 32KB buffer from HPS EMIF memory to FPGA\n\
    onchip memory and then DMA the FPGA onchip memory buffer to a second\n\
    HPS EMIF memory buffer.  The contents of the initial HPS EMIF memory\n\
    buffer are compared to the second HPS EMIF memory buffer to verify\n\
    accurate DMA transfer.\n\
\n\
    The demo measures how long it takes to perform each DMA and reports\n\
    the results in the demo summary output."

//------------------------------------------------------------------------------
#define b_menu_HELP_TEXT \
"F2H Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects an MSGDMA core to the F2H bridge and\n\
    a 32KB FPGA onchip memory core to facilitate DMA data movement\n\
    to/from the HPS EMIF memory and to/from the FPGA onchip memory.  The\n\
    LWH2F bridge is connected to the CSR slave of the MSGDMA to\n\
    facilitate control and monitoring of the core.  A System ID core is\n\
    also connected to the LWH2F bridge.\n\
\n",\
"SOFTWARE DEMO OVERVIEW\n\
    Demonstrates DMA of a 32KB buffer from HPS EMIF memory to FPGA\n\
    onchip memory and then DMA the FPGA onchip memory buffer to a second\n\
    HPS EMIF memory buffer.  The contents of the initial HPS EMIF memory\n\
    buffer are compared to the second HPS EMIF memory buffer to verify\n\
    accurate DMA transfer.\n\
\n\
    The demo performs the DMA movement with the data cache flushed and\n\
    then again with the data cache charged to demonstrate the difference\n\
    between cache hits that return data from the data cache versus cache\n\
    misses that must interact with the HPS EMIF DRAM.  The ACE-lite\n\
    transactions created by the DMA are marked as cache coherent so they\n\
    may participate in coherency within the CCU.\n\
\n\
    The demo measures how long it takes to perform each DMA and reports\n\
    the results in the demo summary output."

//------------------------------------------------------------------------------
#define k_menu_HELP_TEXT \
"HPS UART Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the HPS UART to an FPGA LWUART core\n\
    that is monitored by a Nios V/c core.  The Nios V/c core captures\n\
    each 8-bit character received over the LWUART from the HPS and\n\
    inverts the data and sends it back out the LWUART to the HPS.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates transmitting a randomized data pattern through the HPS\n\
    UART in loopback mode, so that the HPS UART receives exactly the\n\
    same data that was transmitted.  It then transmits a randomized data\n\
    pattern through the HPS UART to the Nios V/c in the FPGA and\n\
    receives the data returned from the Nios V/c.\n\
\n\
    The data patterns that are transmitted and received during each\n\
    pass, as well as the time taken, are reported in the demo summary\n\
    output."

//------------------------------------------------------------------------------
#define f_menu_HELP_TEXT \
"HPS SPIM bridge Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the HPS SPI to an FPGA SPI-slave-to-\n\
    Avalon-Master core that is connected to a 4KB FPGA onchip memory.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates reading and writing the FPGA onchip memory through the\n\
    SPI-slave-to-Avalon-Master core.  The demo creates the appropriate\n\
    command packets defined by the SPI-slave-to-Avalon-Master core API\n\
    and transmits them through the HPS SPI interface and receives the\n\
    responses from the SPI-slave-to-Avalon-Master core.\n\
\n\
    The demo reports the time required to perform various read/write\n\
    operations through the HPS SPI interface in the demo summary output."

//------------------------------------------------------------------------------
#define e_menu_HELP_TEXT \
"HPS I2C Bridge Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the HPS I2C to an FPGA I2C-slave-to-\n\
    Avalon-Master core that is connected to a 4KB FPGA onchip memory.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates reading and writing the FPGA onchip memory through the\n\
    I2C-slave-to-Avalon-Master core.  The demo creates the appropriate\n\
    command packets defined by the I2C-slave-to-Avalon-Master core API\n\
    and transmits them through the HPS I2C interface and receives the\n\
    responses from the I2C-slave-to-Avalon-Master core.\n\
\n\
    The demo reports the time required to perform various read/write\n\
    operations through the HPS I2C interface in the demo summary output."

//------------------------------------------------------------------------------
#define T_menu_HELP_TEXT \
"HPS EMAC Demo\n\
\n\
HARDWARE DEMO OVERVIEW\n\
    FPGA core logic design connects the HPS EMAC to a GMII loopback\n\
    component.\n\
\n\
SOFTWARE DEMO OVERVIEW\n\
    Demonstrates packet transmission through the internal loopback\n\
    inside the HPS EMAC peripheral and the GMII loopback in the FPGA\n\
    logic.  The demo creates DMA descriptors in HPS EMIF memory to\n\
    transmit data from buffers in HPS EMIF memory through the HPS EMAC\n\
    and receive loopback data into receive buffers in the HPS EMIF\n\
    memory.\n\
\n\
    The demo reports the time required to transfer packets through the\n\
    HPS EMAC interface in the demo summary output."

//------------------------------------------------------------------------------
#define c_menu_HELP_TEXT \
"Exit to the u-boot console."

//------------------------------------------------------------------------------
#define m_menu_HELP_TEXT \
"Redisplay the menu."

//------------------------------------------------------------------------------
#define m5_menu_HELP_TEXT \
"Program the Cortex A55 boot RPD image into the SDM QSPI flash.\n\
\n\
Upon the next Agilex 5 device reconfiguration, the HPS will boot on the\n\
Cortex A55 processor."

//------------------------------------------------------------------------------
#define m7_menu_HELP_TEXT \
"Program the Cortex A76 boot RPD image into the SDM QSPI flash.\n\
\n\
Upon the next Agilex 5 device reconfiguration, the HPS will boot on the\n\
Cortex A76 processor."

//------------------------------------------------------------------------------
#define n_menu_HELP_TEXT \
"Loads an FPGA design with no peripherals defined within it."

//------------------------------------------------------------------------------
#define j_menu_HELP_TEXT \
"Loads an FPGA design with a JTAG Avalon Master Bridge connected to the\n\
HPS F2SDRAM bridge.  This allows system-console to transfer binary data\n\
images into the HPS EMIF memory space to facilitate various debug and\n\
maintenance operations during development."

//------------------------------------------------------------------------------
#define u_menu_HELP_TEXT \
"Verifies that HPS EMIF memory contains a valid u-boot.itb FIT image at\n\
address 0x8600_0000.  If it validates a u-boot.itb FIT image in memory,\n\
it programs that image into the SDM QSPI flash so that it will be\n\
accessed by the FSBL upon the next HPS reset."

//------------------------------------------------------------------------------
#define d_menu_HELP_TEXT \
"Verifies that HPS EMIF memory contains a valid demo.itb FIT image at\n\
address 0x8600_0000.  If it validates a demo.itb FIT image in memory, it\n\
programs that image into the SDM QSPI flash so that it will be accessed\n\
by the SSBL upon the next HPS reset."

#endif  /* __HELP_TEXT_H__ */
