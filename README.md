# agilex5-demo-hps2fpga-interfaces
<!-- SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation -->
<!-- SPDX-License-Identifier: MIT-0 -->

- **id**:
- **title**: agilex5-demo-hps2fpga-interfaces
- **source**: GitHub
- **family**: Agilex 5
- **quartus_version**: Version 24.2.0 Build 40 06/27/2024 SC Pro Edition
- **devkit**: Agilex 5 FPGA E-Series 065B Premium Development Kit, and others
- **device_part**: A5ED065BB32AE5SR0, A5ED065BB32AE4SR0, A5ED065BB32AE6SR0
- **description**: Agilex 5 HPS-to-FPGA interfaces demos.
- **rich_description**: This project is a demonstration and evaluation example that shows how users can implement and interact with the various hardware interfaces between the Hard Processing System (SoC) and FPGA fabric on the Agilex 5 FPGA device family.
- **url**: https://github.com/altera-fpga/agilex5-demo-hps2fpga-interfaces
- **downloadURL**: https://github.com/altera-fpga/agilex5-demo-hps2fpga-interfaces

## Project documentation

The project documentation index is available [**here**](./documentation/01_index.md).

## Project build instructions

The project build instructions are documented [**here**](./documentation/17_building_project.md).

## Currently supported boards

| Repo Directory | Board Info |
| :--- | :--- |
| brd_altera_a5e065_premium_es | **Company:** Altera, An Intel Company<br>**Board Name:** Agilex* 5 FPGA E-Series 065B Premium Development Kit<br>**OPN:** DK-A5E065BB32AES1<br>**Comment:** ES device |
| brd_arrow_axe5_eagle_es | **Company:** Arrow Electronics, Inc.<br>**Board Name:** Arrow AXE5-Eagle Development Platform<br>**OPN:** AXE5-EAGLE-ES<br>**Comment:** ES device |
| brd_criticallink_mitysbc_es | **Company:** Critical Link, LLC<br>**Board Name:** MitySBC-A5E Single Board Computer<br>**OPN:** A5ED-B9-C7F-RC-SBC-X<br>**Comment:** ES device |
| brd_macnica_sulfur_es_125 | **Company:** Macnica, Inc.<br>**Board Name:** Macnica Mpression Sulfur Kit / Type A<br>**OPN:** ALTSULFUR_A5ED065B_E5_ES0_typeA<br>**Comment:** ES device - 125MHz SDM_OSC_CLK |
| brd_macnica_sulfur_es_25 | **Company:** Macnica, Inc.<br>**Board Name:** Macnica Mpression Sulfur Kit / Type A<br>**OPN:** ALTSULFUR_A5ED065B_E5_ES0_typeA<br>**Comment:** ES device - 25MHz SDM_OSC_CLK |

**Trademarks and disclaimers**\
All trademarks are the property of their respective owners.\
All brands or product names are the property of their respective holders.

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
