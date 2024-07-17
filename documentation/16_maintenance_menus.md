# maintenance menus
<!-- SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation -->
<!-- SPDX-License-Identifier: MIT-0 -->

Return to [**Index**](01_index.md)

## Overview

There are several maintenance menus that are primarily used for development and debugging purposes, but can also be useful for configuring the board for experiments that are not performed by this demonstration environment.

Below is a brief description of each menu extracted from the online help information displayed in the demonstration application.

## exit to u-boot console - menu-c

#### OVERVIEW

Exit to the u-boot console.

## display menu - menu-m

#### OVERVIEW

Redisplay the menu.

## program a55 rpd image into flash - menu-5

#### OVERVIEW

Program the Cortex A55 boot RPD image into the SDM QSPI flash.

Upon the next Agilex 5 device reconfiguration, the HPS will boot on the Cortex A55 processor.

## program a76 rpd image into flash - menu-7

#### OVERVIEW

Program the Cortex A76 boot RPD image into the SDM QSPI flash.

Upon the next Agilex 5 device reconfiguration, the HPS will boot on the Cortex A76 processor.

## load no-peripheral FPGA image - menu-n

#### OVERVIEW

Loads an FPGA design with no peripherals defined within it.

## load jamb FPGA image - menu-j

#### OVERVIEW

Loads an FPGA design with a JTAG Avalon Master Bridge connected to the HPS F2SDRAM bridge.  This allows system-console to transfer binary data images into the HPS EMIF memory space to facilitate various debug and maintenance operations during development.

#### ADDITIONAL INFO

Additional documentation on the hardware design and development techniques is available [**here**](14_menu_j_hw_hps_jamb.md).

## update u-boot.itb image in flash - menu-u

#### OVERVIEW

Verifies that HPS EMIF memory contains a valid u-boot.itb FIT image at address 0x8600_0000.  If it validates a u-boot.itb FIT image in memory, it programs that image into the SDM QSPI flash so that it will be accessed by the FSBL upon the next HPS reset.

## update demos.itb image in flash - menu-d

#### OVERVIEW

Verifies that HPS EMIF memory contains a valid demo.itb FIT image at address 0x8600_0000.  If it validates a demo.itb FIT image in memory, it programs that image into the SDM QSPI flash so that it will be accessed by the SSBL upon the next HPS reset.

---
Return to [**Index**](01_index.md)
