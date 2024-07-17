# software demos
<!-- SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation -->
<!-- SPDX-License-Identifier: MIT-0 -->

Return to [**Index**](01_index.md)

Hardware projects referenced from this document:
* none

u-boot software applications referenced from this document:
* common_sw/u-boot_standalone_apps/armv8_regs.c
* common_sw/u-boot_standalone_apps/cache_regs.c
* common_sw/u-boot_standalone_apps/read_sensors.c
* common_sw/u-boot_standalone_apps/sdm_query.c
* common_sw/u-boot_standalone_apps/system_counter.c

Linux software applications referenced from this document:
* common_sw/linux_apps/armv8_regs.c
* common_sw/linux_apps/cache_regs.c
* common_sw/linux_apps/system_counter.c
* common_sw/toybox_scripts/read_sensors

## Overview

There several software only demos that do not require any FPGA hardware to demonstrate their functionality. The help text from the u-boot menu application is captured for each of these demos below as a brief overview of what each demo shows, along with the output displayed by each demo. Please see the source code for the software application to see the code examples that perform these operations.

## System Counter / Generic Timer Demo - menu-s

#### SOFTWARE DEMO OVERVIEW

Demonstrates the Armv8 system counter functionality, also known as the generic timer.  The demo shows how the system counter can be read using an assembly language instruction to read from a system register within the processor itself or how it can be read using a load instruction to access the system counter from the external memory map.

The demo reads the system counter ten times and reports how long each access takes for both the assembly instruction method and the memory map load method.

#### DEMO OUTPUT
```text
System Counter / Generic Timer Demo

Results using an assembly instruction to read the system counter register 10
times in a row. The system counter values are printed along with the counter
deltas between each read of the register.

    reg[0] = 0x00000ABD406F453A
    reg[1] = 0x00000ABD406F454B : delta = 0x0000000000000011 : 42.500 ns
    reg[2] = 0x00000ABD406F457D : delta = 0x0000000000000032 : 125.000 ns
    reg[3] = 0x00000ABD406F458E : delta = 0x0000000000000011 : 42.500 ns
    reg[4] = 0x00000ABD406F459E : delta = 0x0000000000000010 : 40.000 ns
    reg[5] = 0x00000ABD406F45AE : delta = 0x0000000000000010 : 40.000 ns
    reg[6] = 0x00000ABD406F45BE : delta = 0x0000000000000010 : 40.000 ns
    reg[7] = 0x00000ABD406F45CE : delta = 0x0000000000000010 : 40.000 ns
    reg[8] = 0x00000ABD406F45DE : delta = 0x0000000000000010 : 40.000 ns
    reg[9] = 0x00000ABD406F45EE : delta = 0x0000000000000010 : 40.000 ns

Results using a load instruction to read the system counter register from the
memory map 10 times in a row. The system counter values are printed along with
the counter deltas between each read of the register.

    mmap[0] = 0x00000ABD406F4616
    mmap[1] = 0x00000ABD406F4652 : delta = 0x000000000000003C : 150.000 ns
    mmap[2] = 0x00000ABD406F4682 : delta = 0x0000000000000030 : 120.000 ns
    mmap[3] = 0x00000ABD406F46B2 : delta = 0x0000000000000030 : 120.000 ns
    mmap[4] = 0x00000ABD406F46E2 : delta = 0x0000000000000030 : 120.000 ns
    mmap[5] = 0x00000ABD406F4712 : delta = 0x0000000000000030 : 120.000 ns
    mmap[6] = 0x00000ABD406F4742 : delta = 0x0000000000000030 : 120.000 ns
    mmap[7] = 0x00000ABD406F4772 : delta = 0x0000000000000030 : 120.000 ns
    mmap[8] = 0x00000ABD406F47A2 : delta = 0x0000000000000030 : 120.000 ns
    mmap[9] = 0x00000ABD406F47D2 : delta = 0x0000000000000030 : 120.000 ns

Press any key to exit this demo.
```

## Armv8 Registers Demo - Current CPU Status - menu-a

#### SOFTWARE DEMO OVERVIEW

Demonstrates how to read various Armv8 registers and explains what information they contain.

#### DEMO OUTPUT
```text
Armv8 Registers Demo - Current CPU Status

    CNTFRQ_EL0 = 0x0000000017D78400        CNTPCT_EL0 = 0x00000ABE962815E0
      MIDR_EL1 = 0x00000000412FD050         MPIDR_EL1 = 0x0000000081000000
    REVIDR_EL1 = 0x0000000000000000         CURRENTEL = 0x0000000000000008
          DAIF = 0x00000000000002C0

CNTFRQ_EL0 shows system counter frequency:
  400000000 HZ

CNTPCT_EL0 shows current system counter value:
  0000d'08h'12m'14s'198ms'183us'600ns

MIDR_EL1 shows core identification information:
  Indicates a Cortex A55 r2p0 core
        Implementer = 0x41      Variant = 0x2    Architecture = 0xF
            PartNum = 0xD05    Revision = 0x0

MPIDR_EL1 shows core affinity information:
  Running on core 0

REVIDR_EL1 shows an implementation specific value.

CURRENTEL shows the current exception level for this core:
  Current Exception Level is EL2

DAIF shows the current interrupt mask values:
  D: masked    A: NOT masked    I: masked    F: masked

HPS clocks:
        MPU CLOCK = 875000000 HZ        L4 SYS FREE CLOCK = 100000000 HZ

Press any key to exit this demo.
```

## Reading Sensors Demo - menu-v

#### SOFTWARE DEMO OVERVIEW

NOTE: the Linux version of this demo is driven by a shell script that reads the sensors using the hwmon driver.

Demonstrates how to read the voltage and temperature sensor values from the SDM.  The program issues SMC traps to invoke the ATF API to query the sensor values.

NOTE: in order to read the FPGA die temperature sensors, an FPGA core logic design must be loaded which activates the sensor. If a design is loaded which does not activate a sensor, then that sensor will not provide any readings.  This can affect core fabric sensors as well as XCVR sensors.

NOTE: the on die sensors are not calibrated on ES silicon.  So while this demonstrates functionally how to read the sensor values, they are not accurate on ES silicon.

#### DEMO OUTPUT
```text
Reading Sensors Demo

    Sensor Name     |    Value   |  Value   |   Access Time
--------------------+------------+----------+----------------
               VSIGP: 0x00000038 :   0.000 V: 20055942.500 ns
               VSIGN: 0x00000082 :   0.001 V: 20050860.000 ns
                 VCC: 0x0000B3C4 :   0.702 V: 20048322.500 ns
           VCCIO_SDM: 0x0001CE6D :   1.806 V: 20050882.500 ns
               VCCPT: 0x0001CF0A :   1.808 V: 20049700.000 ns
            VCCRCORE: 0x00013749 :   1.215 V: 20050202.500 ns
            VCCH_SDM: 0x0000EF61 :   0.935 V: 20048322.500 ns
            VCCL_SDM: 0x0000B3CC :   0.702 V: 20050887.500 ns
              VCCADC: 0x0001D317 :   1.824 V: 20049682.500 ns
                 SDM: 0x00002320 :  35.125 C: 20049935.000 ns
      LOWER LEFT MAX: 0x000052C0 :  82.750 C: 20049280.000 ns
   LOWER LEFT CORNER: 0x00005280 :  82.500 C: 20050190.000 ns
   LOWER LEFT XCVR 2: 0x000047C0 :  71.750 C: 20049400.000 ns
   LOWER LEFT XCVR 3: 0x00004720 :  71.125 C: 20050142.500 ns
   LOWER LEFT CENTER: 0x00004720 :  71.125 C: 20049352.500 ns
     LOWER RIGHT MAX: 0x000050A0 :  80.625 C: 20050540.000 ns
  LOWER RIGHT CORNER: 0x000050A0 :  80.625 C: 20049342.500 ns
  LOWER RIGHT XCVR 2: 0x000045A0 :  69.625 C: 20049862.500 ns
  LOWER RIGHT XCVR 3: 0x00004560 :  69.375 C: 20049702.500 ns
     UPPER RIGHT MAX: 0x000050A0 :  80.625 C: 20050260.000 ns
  UPPER RIGHT CORNER: 0x000050E0 :  80.875 C: 20048242.500 ns
  UPPER RIGHT XCVR 2: 0x80000002 :  ERROR   : 20048580.000 ns
  UPPER RIGHT XCVR 3: 0x00004600 :  70.000 C: 20049940.000 ns
  UPPER RIGHT CENTER: 0x000045A0 :  69.625 C: 20049455.000 ns
                 HPS: 0x00004600 :  70.000 C: 20050080.000 ns

Press any key to exit this demo.
```

## SDM Query Demo - menu-q

#### SOFTWARE DEMO OVERVIEW

NOTE: There is no Linux version of this demo because we cannot issue SMC traps from user space and there is no convenient driver that can be leveraged.

Demonstrates how to query various information from the SDM.  The demo issues SMC traps to invoke the ATF API to query the values.

The following values are queried from the SDM:

* SDM FIRMWARE VERSION
* JTAG USERCODE
* CHIP ID

#### DEMO OUTPUT
```text
SDM Query Demo

  SDM FIRMWARE VERSION = 0x00180100
    Query Result: 0x00000000
     Query Value: 0x00180100
     Access Time: 20062852.500 ns

  JTAG USERCODE = 0x33333333
    Query Result: 0x00000000
     Query Value: 0x33333333
     Access Time: 20044845.000 ns

  CHIP ID = 0x3EBBA24CD5EFE935
    Query Result: 0x00000000
      MBOX Error: 0x00000000
     ID Lo Value: 0xD5EFE935
     ID Hi Value: 0x3EBBA24C
     Access Time: 20050280.000 ns


Press any key to exit this demo.
```

## Cache Registers Demo - Current Cache Sizes - menu-o

#### SOFTWARE DEMO OVERVIEW

Demonstrates how to read the cache status registers for the L1, L2 and L3 caches on the processor.

NOTE: the L1 and L2 cache sizes are different on the Cortex A55 and Cortex A76 processor cores.

#### DEMO OUTPUT
```text
Cache Registers Demo - Current Cache Sizes

         CLIDR_EL1 = 0xC3000123
    L1I-CCSIDR_EL1 = 0x200FE01A
    L1D-CCSIDR_EL1 = 0x700FE01A
    L2D-CCSIDR_EL1 = 0x703FE01A
    L3D-CCSIDR_EL1 = 0x70FFE07A

CLIDR Details:
  L1 cache type: 0x03    Level of Unification Inner Shareable: 0x00
  L2 cache type: 0x04                      Level of Coherency: 0x03
  L3 cache type: 0x04       Level of Unification Uniprocessor: 0x00
                                         Inner Cache Boundary: 0x03

L1 Instruction Cache Details:           L1 Data Cache Details:
          FLAGS: wt|wb|RA|wa                      FLAGS: wt|WB|RA|WA
           SETS: 0x007F | 128 sets                 SETS: 0x007F | 128 sets
  ASSOCIATIVITY: 0x0003 | 4 ways          ASSOCIATIVITY: 0x0003 | 4 ways
      LINE SIZE: 0x0002 | 64 bytes            LINE SIZE: 0x0002 | 64 bytes
     CACHE SIZE: 32 KB                       CACHE SIZE: 32 KB

L2 Data Cache Details:                  L3 Data Cache Details:
          FLAGS: wt|WB|RA|WA                      FLAGS: wt|WB|RA|WA
           SETS: 0x01FF | 512 sets                 SETS: 0x07FF | 2048 sets
  ASSOCIATIVITY: 0x0003 | 4 ways          ASSOCIATIVITY: 0x000F | 16 ways
      LINE SIZE: 0x0002 | 64 bytes            LINE SIZE: 0x0002 | 64 bytes
     CACHE SIZE: 128 KB                      CACHE SIZE: 2048 KB

Press any key to exit this demo.
```

---
Return to [**Index**](01_index.md)
