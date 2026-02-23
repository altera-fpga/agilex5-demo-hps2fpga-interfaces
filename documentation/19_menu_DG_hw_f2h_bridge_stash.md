# menu-DG on hw_f2h_bridge_stash
<!-- SPDX-FileCopyrightText: Copyright (C) 2026 Altera Corporation -->
<!-- SPDX-License-Identifier: MIT-0 -->

Return to [**Index**](01_index.md)

Hardware projects referenced from this document:
* common_pd_subsystems/hw_f2h_bridge_stash

u-boot software applications referenced from this document:
* common_sw/u-boot_standalone_apps/f2h_bridge_stash.c

Linux software applications referenced from this document:
* common_sw/linux_apps/f2h_bridge_stash_vfio_noflush.c
* common_sw/linux_apps/f2h_bridge_stash_vfio_flush.c

## Overview

The menu-D and menu-G demos demonstrate essentially the same things that the F2H bridge demos demonstrate with one twist. Rather than passing coherent transactions through the F2H bridge to read and write system memory buffers, it passes cache stash write coherent transactions through the F2H bridge. So this demonstrates essentially the same type of coherent behavior with the addition of cache stash behavior on writes through the F2H bridge.

The hardware structure of the f2h_bridge_stash hardware project is identical to the f2h_bridge hardware project. The only difference is the F2H adapter that is placed into the FPGA logic, it drives cache stash signalling in addition to the coherent signalling of the F2H bridge hardware project.

**NOTE:** due to a current limitation with the ES devices, this demo must be run first after the device has been wiped, meaning a power cycle, nCONFIG assertion, etc. If this demo is run after the FPGA has previously been configured with a hardware design, then this demo will fail.

## Hardware system

Please refer to the menu-b documentation for information about how the hardware system is configured. The hw_f2h_bridge_stash project is essentially just like the hw_f2h_bridge project with the one difference mentioned above. The F2H adapter drives cache stash signalling as well as coherent signalling.

## Software demo - u-boot standalone - menu-D

In the u-boot standalone application we configure the msgdma core to move a 32KB randomized data pattern from an initial buffer allocated in HPS EMIF memory to the FPGA OCRAM memory. Then we configure the msgdma core to move the 32KB data from the FPGA OCRAM memory to a secondary buffer in HPS EMIF memory. The initial buffer contents are then checked against the secondary buffer contents to ensure the data movement occurred as expected.

Since the f2h bridge can pass cache coherent transactions, this demo is executed two different ways, first with the data cache flushed prior to the msgdma transfer and then with the data cache left charged with data prior to the msgdma transfer. This illustrates the different behavior that is experienced when the msgdma interacts with cached and non-cached buffers.

The source code for this example is essentially the same as the source code shared for the menu-b demo.

The output from this demo is shown below. The value of the signature read back from the hps_gp_in constant is displayed as well as the System ID values. The status of the initial and secondary buffer comparison is also displayed. The time required to execute each stage of the process is also printed in the output. The same buffer comparison and timing information is displayed for the data cache flush pass and the non-flush pass.

```text
F2H Cache Stash Demo

HPS_GP_IN signature value = 0x53483246 : F2HS

SYSID_ID: 0x53483246
SYSID_TS: 0x00000000

---------- data cache flushed ----------

No errors detected...

   DCACHE FLUSH TIME:     27665.000ns
 BUFFER COMPARE TIME:    136805.000ns
HPS to FPGA DMA TIME:     12497.500ns :   2.441GB/s
FPGA to HPS DMA TIME:     19340.000ns :   1.577GB/s

---------- data cache NOT flushed ----------

No errors detected...

 BUFFER COMPARE TIME:    134350.000ns
HPS to FPGA DMA TIME:      8827.500ns :   3.457GB/s
FPGA to HPS DMA TIME:     17425.000ns :   1.751GB/s

Press any key to exit this demo.
```

## Software demo - Linux - menu-D

The menu-D Linux variant of this demo is essentially the same as the menu-B version of the F2H bridge demo, it uses the vfio platform driver framework and the iommufd framework.

The HPS EMIF memory buffer that we use is allocated from the user space heap and the SMMU is configured through the iommufd framework. The non-contiguous cacheable buffer that we allocate from the heap is translated into iova's that we can program into the msgdma for DMA transfers through the F2H bridge using the iommufd framework.

The menu-D variant demonstrates a polled and interrupt driven example for determining when the msgdma core has completed the transfers. The interrupt method is demonstrated through the vfio framework.

The menu-D variant does not perform any cache flushing as it executes, so you can observe how the performance of the coherent cache stash DMA through the F2H bridge interacts with the cacheable buffer that is warmed up with data.

## Software demo - Linux - menu-G

The menu-G Linux variant of this demo is essentially the same as the menu-B version of the F2H bridge demo, it uses the vfio platform driver framework and the iommufd framework.

The HPS EMIF memory buffer that we use is allocated from the user space heap and the SMMU is configured through the iommufd framework. The non-contiguous cacheable buffer that we allocate from the heap is translated into iova's that we can program into the msgdma for DMA transfers through the F2H bridge using the iommufd framework.

The menu-G variant demonstrates a polled and interrupt driven example for determining when the msgdma core has completed the transfers. The interrupt method is demonstrated through the vfio framework.

The menu-G variant performs cache flushing as it executes, so you can observe how the performance of the coherent cache stash DMA through the F2H bridge interacts with the cacheable buffer that is cold, with no data preloaded into the cache.

---
Return to [**Index**](01_index.md)
