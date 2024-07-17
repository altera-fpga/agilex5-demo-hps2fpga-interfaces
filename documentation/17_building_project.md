# building project
<!-- SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation -->
<!-- SPDX-License-Identifier: MIT-0 -->

Return to [**Index**](01_index.md)

## Overview

The examples represented in this repo have been tested on their respective boards. Adding additional boards is simple, a properly formatted QSF file and HPS EMIF Platform Designer instance for any given board is all that is required, that QSF data can be transformed into a new board base design that should then be able to support all the examples within this repo.

## Development host configuration

The build scripts assume a Linux development environment, specifically a bash shell environment. Any Linux environment that is capable of running the Quartus development tools should be sufficient.

Ensure that your Quartus tools are properly licensed in your development environment.

Ensure that you have the proper version of the Quartus tools installed and present in your build environment to build the demo sources.

#### Typical PATH environment configuration for Quartus tools

The following paths into your Quartus tools installation should be configured in your PATH environment variable so that all of the required tools can be located. This build flow does not require all of these paths, but these are considered the complete superset of possible paths for various tool usage scenarios.
```text
${QUARTUS_ROOTDIR}/dspba
${QUARTUS_ROOTDIR}/../questa_fe/linux_x86_64
${QUARTUS_ROOTDIR}/../riscfree/RiscFree
${QUARTUS_ROOTDIR}/../riscfree/toolchain/riscv32-unknown-elf/bin
${QUARTUS_ROOTDIR}/../niosv/bin
${QUARTUS_ROOTDIR}/bin
${QUARTUS_ROOTDIR}/../syscon/bin
${QUARTUS_ROOTDIR}/../qsys/bin
${QUARTUS_ROOTDIR}/sopc_builder/bin
```

**NOTE:** this build flow builds off the native Linux command line, under a bash shell environment. It does not assume that commands are executed from within the "niosv-shell" environment as other Altera examples tend to demonstrate. Executing from within a "niosv-shell" environment may not work as expected and is not a tested flow.

---
---
#### Special Note: Quartus 24.2 build 40 tools patch requirement

In the Quartus 24.2 build 40 tools release, there is an issue with the SPI-Slave-to-Avalon-Master-Bridge IP core where the component is not marked as supported in the Agilex 5 device family. You can run the following sed command to edit the component in the Quartus installation tree. This error must be corrected in order to build the complete images for the demos.
```text
sed -i.bak -e '/SUPPORTED_DEVICE_FAMILIES/ s|set_module_property SUPPORTED_DEVICE_FAMILIES {"Arria 10" "Cyclone 10 GX" "Stratix 10" "Agilex" "Agilex 7" "Agilex 9"}|set_module_property SUPPORTED_DEVICE_FAMILIES {"Arria 10" "Cyclone 10 GX" "Stratix 10" "Agilex" "Agilex 7" "Agilex 9" "Agilex 5"}|' ${QUARTUS_ROOTDIR:?}/../ip/altera/sopc_builder_ip/altera_avalon_spislave_to_avalonmm_bridge/SPISlaveToAvalonMasterBridge_hw.tcl
```
---
---

You should not need to configure the CROSS_COMPILE or ARCH environment variables because the software build scripts do this themselves.

This build flow is organized to align the hardware/software project intradependencies that must be executed in the proper order to avoid missing dependencies in each stage of the flow.

## Automated build flow

From the top-level directory of the demo repo, you can run this automated build script to build the entire project for any board in the repo:

```text
BOARD_DIR=<board-dir-name> ./build_a_board.sh
```

## Manual build flow

From the top-level directory of the demo repo, you can perform these manual build operations. To build the entire project for a given board, all operations should be performed in the following sequence. For development and experimentation, it is acceptable to reiterate on various build steps to make incremental changes and test them.

Download remote repos and archives:
```text
[]$ ./repo_downloads/download_repos.sh
```

Initialize the hardware project build scripts:
```text
[]$ ./<board-dir>/init_hw_build_scripts.sh
```

Build all the hardware projects by running this script:
```text
[]$ ./<board-dir>/build_hw.sh
```

Or build one specific hardware project like this:
```text
[]$ ./<board-dir>/<hw-example-dir>/init_proj.sh
[]$ ./<board-dir>/<hw-example-dir>/build_hw.sh
```

Build the bootloaders next:
```text
[]$ ./<board-dir>/sw_builds/build_bootloaders.sh
```

Create the bitstreams for each hardware project:
```text
[]$ ./<board-dir>/create_bitstreams.sh
```

Build the rest of the software:
```text
[]$ ./<board-dir>/sw_builds/build_toybox.sh
[]$ ./<board-dir>/sw_builds/build_linux_apps.sh
[]$ ./<board-dir>/sw_builds/linux_apps/install_toybox_hw.sh
[]$ ./<board-dir>/sw_builds/linux_apps/install_toybox_sw.sh
[]$ ./<board-dir>/sw_builds/linux_apps/install_toybox_scripts.sh
[]$ ./<board-dir>/sw_builds/build_linux_kernel.sh
```

Package the flash programming image, JIC image:
```text
[]$ ./<board-dir>/images/build_images.sh
```

Once you have the JIC image created, you can program the SDM QSPI flash on the board you've built it for:
```text
[]$ quartus_pgm -m jtag -c 1 -o pi\;sdm_qspi.jic
```

Power cycle the board and it should boot into the demo menu.

---
Return to [**Index**](01_index.md)
