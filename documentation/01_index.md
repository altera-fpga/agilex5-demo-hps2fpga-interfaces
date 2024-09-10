# Documentation Index
<!-- SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation -->
<!-- SPDX-License-Identifier: MIT-0 -->

## Overview

This project is a demonstration and evaluation example that shows how users can implement and interact with the various hardware interfaces between the Hard Processing System (SoC) and FPGA fabric on the Agilex 5 FPGA device family. This is accomplished through several individual small design examples that demonstrate how to create an FPGA hardware design to implement each hardware interface and provide a software demonstration that interacts with that FPGA design through the interface. The software demonstrations are performed as u-boot standalone applications as well as Linux user space applications.​

The project has been ported to several development boards provided by Altera and third-party partners. Binary images produced by the project can be programmed directly into any supported dev kit and executed.​

## Getting Started

The primary use case for this demo is to download the prebuilt binary image for the board of interest and program it into the SDM QSPI flash on the board and execute the various demos. The project documentation referenced above explains what the demos do and how they do it and source code for all the hardware and software demos is provided within the repo.

The prebuilt binary images are uploaded to the release section of the repo:\
[https://github.com/altera-fpga/agilex5-demo-hps2fpga-interfaces/releases](https://github.com/altera-fpga/agilex5-demo-hps2fpga-interfaces/releases)

Locate the archive of the JIC image for your board and download it.

Extract the archive:
```text
[]$ unzip <jic-archive>
```

Program the JIC image into the SDM QSPI flash:
```text
[]$ quartus_pgm -m jtag -c <cable-number> -o pi\;<jic-image>
```

If your board is already programmed with an image that configures the HPS onto the JTAG chain, then you may need to point the JIC image programming into the second device location:
```text
[]$ quartus_pgm -m jtag -c <cable-number> -o pi\;<jic-image>@2
```

It may be necessary to slow down the JTAG clock while programming the JIC image into the flash device if you experience programming failures. Do that like this:
```text
[]$ jtagconfig --setparam <cable-number> JtagClock 16M
```

## Demo menus

When the demo boots on the development kit, it stops in u-boot and presents this menu:

```text
        Running on board: Altera Premium Dev Kit
                  Uptime: 0000d'00h'00m'15s'183ms'653us'342ns
         Running on core: 0
               Core type: Cortex A55 r2p0 core
 Current exception level: EL2
 Current exception masks: DaIF
               MPU CLOCK: 800000000 HZ

     Boot Application Menu
  ------------------------------------------------------------------| Help |----
 H - help menu
 A - acknowledgements
  -------------------------------------------------| Switch to Linux Demos |----
 L - start linux
  ------------------------------------------------| Software Only Examples |----
 s - system counter                     a - armv8 registers
 v - read volt/temp sensors             q - SDM query, chip id and more
 o - cache status registers
  -----------------------------------------------------| Hardware Examples |----
 g - hps gp demo                        i - f2h irq demo
 l - f2h irq handler demo               z - config clock demo
 y - h2f user clock demo                x - lwh2f bridge demo
 w - lwh2f bridge default subordinate   t - h2f bridge
 r - h2f bridge default subordinate     p - f2sdram bridge
 b - f2h bridge                         k - hps uart
 f - hps spi bridge                     e - hps i2c bridge
 T - hps emac
  ---------------------------------------------------| Maintenance Options |----
 c - exit to u-boot console             m - display menu
 5 - program a55 rpd image into flash   7 - program a76 rpd image into flash
 n - load no-peripheral FPGA image      j - load jamb FPGA image
 u - update u-boot.itb image in flash   d - update demos.itb image in flash
 R - reset HPS

Enter menu selection:
```

If you select menu-L from the u-boot demo application, then the system boots into Linux and presents this menu in the Linux demo. You will notice that it is basically the same menu layout, however some of the u-boot choices are removed and a few additional choices are added. The removals are because the Linux demos are running from user space, so some of the demonstrations that can be shown in u-boot are not possible from Linux user space and are removed. The additions are because we have access to Linux drivers that we can demonstrate for various peripherals.

```text
        Running on board: Altera Premium Dev Kit
                  Uptime: 0000d'00h'00m'18s'388ms'965us'190ns
               Core type: Cortex A55 r2p0 core
    Last Linux Boot Time: 2116628472.500 ns

     Linux Application Menu
  ------------------------------------------------------------------| Help |----
 H - help menu
  ------------------------------------------------| Software Only Examples |----
 s - system counter                     a - armv8 registers
 v - read volt/temp sensors
  -----------------------------------------------------| Hardware Examples |----
 g - hps gp demo                        i - f2h irq demo
 l - f2h irq handler demo               z - config clock demo
 y - h2f user clock demo                x - lwh2f bridge demo
 w - lwh2f bridge default subordinate   t - h2f bridge
 r - h2f bridge default subordinate     p - f2sdram bridge
 b - f2h bridge                         k - hps uart - uio driver
 K - hps uart - linux driver            f - hps spi bridge - uio driver
 F - hps spi bridge - linux driver      e - hps i2c bridge - uio driver
 E - hps i2c bridge - linux driver      T - hps emac - uio driver
  ---------------------------------------------------| Maintenance Options |----
 c - exit to linux console              m - display menu
 5 - program a55 rpd image into flash   7 - program a76 rpd image into flash
 n - load no-peripheral FPGA image      j - load jamb FPGA image
 R - reboot HPS                         P - poweroff HPS

Enter menu selection:
```

## Hardware demo documentation

* [**Top-Level PD System**](02_top_pd_sys.md) - top-level Platform Designer system documentation, describes the top-level system that is used for the phase 1 bitstream image that configures the device at power-on or after device wipe

* [**menu-g on hw_hps_gp**](03_menu_g_hw_hps_gp.md) - hps_gp interface demo documentation, describes the hardware project design and software demos that interact with the hps_gp interface which provides a 32-bit GPI/GPO interface between the HPS and FPGA logic

* [**menu-i, menu-l on hw_f2h_irq**](04_menu_il_hw_f2h_irq.md) - f2h_irq interface demo documentation, describes the hardware project design and software demos that interact with the f2h_irq interface which provides a 64-bit interrupt interface from the FPGA into the HPS

* [**menu-z on hw_config_clk**](05_menu_z_hw_config_clk.md) - configuration clock demo documentation, describes the hardware project design and software demos that measure the configuration clock frequency

* [**menu-y on hw_h2f_user_clk**](06_menu_y_hw_h2f_user_clk.md) - H2F user clocks demo documentation, describes the hardware project design and software demos that measure the H2F user clock frequencies

* [**menu-x, menu-w on hw_lwh2f_bridge**](07_menu_xw_hw_lwh2f_bridge.md) - LWH2F bridge demo documentation, describes the hardware project design and software demos that interact through the memory mapped LWH2F bridge into the FPGA logic design

* [**menu-t, menu-r on hw_h2f_bridge**](08_menu_tr_hw_h2f_bridge.md) - H2F bridge demo documentation, describes the hardware project design and software demos that interact through the memory mapped H2F bridge into the FPGA logic design

* [**menu-p on hw_f2sdram_bridge**](09_menu_p_hw_f2sdram_bridge.md) - F2SDRAM bridge demo documentation, describes the hardware project design and software demos that interact through the memory mapped F2SDRAM bridge allowing FPGA logic to interact with HPS EMIF memory

* [**menu-b on hw_f2h_bridge**](10_menu_b_hw_f2h_bridge.md) - F2H bridge demo documentation, describes the hardware project design and software demos that interacts through the memory mapped F2H bridge allowing FPGA logic to interact coherently with HPS EMIF memory

* [**menu-k on hw_uart**](11_menu_k_hw_uart.md) - HPS UART demo documentation, describes the hardware project design and software demos that interact through the HPS UART peripheral into FPGA logic

* [**menu-f on hw_spi_bridge**](12_menu_f_hw_spi_bridge.md) - HPS SPI demo documentation, describes the hardware project design and software demos that interact through the HPS SPI perihperal into FPGA logic

* [**menu-e on hw_i2c_bridge**](13_menu_e_hw_i2c_bridge.md) - HPS I2C demo documentation, describes the hardware project design and software demos that interact through the HPS I2C peripheral into FPGA logic

* [**menu-T on hw_emac**](18_menu_T_hw_emac.md) - HPS EMAC demo documentation, describes the hardware project design and software demos that interact through the HPS EMAC peripheral into FPGA logic

## Software-only demo documentation

* [Software-only Demos](15_software_demos.md) - general overview of software-only demos

## Maintenance menu operations

* [Maintenance Menus](16_maintenance_menus.md) - general overview of maintenance menu operations

* [**menu-j on hw_hps_jamb**](14_menu_j_hw_hps_jamb.md) - JTAG Avalon Master Bridge maintenance image documentation, describes the hardware project design and the development and debugging techniques that can be used with it
