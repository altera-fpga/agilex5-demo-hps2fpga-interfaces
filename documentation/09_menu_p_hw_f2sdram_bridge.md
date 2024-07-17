# menu-p on hw_f2sdram_bridge
<!-- SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation -->
<!-- SPDX-License-Identifier: MIT-0 -->

Return to [**Index**](01_index.md)

Hardware projects referenced from this document:
* common_pd_subsystems/hw_f2sdram_bridge

u-boot software applications referenced from this document:
* common_sw/u-boot_standalone_apps/f2sdram_bridge.c

Linux software applications referenced from this document:
* common_sw/linux_apps/f2sdram_bridge.c

## Overview

The menu-p demo demonstrates the functionality of the f2sdram bridge. The f2sdram bridge is a memory mapped bridge that allows initiators in the FPGA fabric to read/write into the 1TB address map of the HPS. The f2sdram bridge only provides connectivity to the 512GB spans of DRAM connected through the HPS EMIF controller. The data width of the f2sdram bridge is configurable in the Platform Designer parameters for the HPS and can be 64-bit, 128-bits or 256-bits. This example uses the 256-bit data width configuration and a 4GB address span configuration. This allows the f2sdram bridge to access the lowest 2GB aperture of DRAM available thru the HPS EMIF controller beginning at 0x8000_0000 and spanning through 0xFFFF_FFFF.

## Hardware system

The menu-p, f2sdram bridge demo, connects the lwh2f bridge to an msgdma core which is connected to the f2sdram bridge and a 32KB FPGA OCRAM. This allows software to control the msgdma core through the lwh2f bridge and command it to move data from the HPS EMIF memory to FPGA OCRAM and vice versa.

A System ID core is also connected to the lwh2f bridge, along with a default subordinate core. The System ID core provides a 32-bit value that we can set in Platform Designer to be a fixed constant and a timestamp value that is set with the build time of the hardware subsystem. We can use the System ID value as a signature to validate the presence of this specific design in the FPGA. The default subordinate is configured as the default slave on the lwh2f manager's interconnect so any undecoded transactions will be sent to the default subordinate, which will then respond with an error response over it's AXI interface.

| hw_f2sdram_bridge top level |
| :---: |
| ![hw_f2sdram_bridge_top.png](./images/captures/hw_f2sdram_bridge_top.png) |

Inside the f2sdram_bridge subsystem, we instantiate a component that splits the hps_gp_in and hps_gp_out interfaces from the hps_gp conduit. The hps_gp_in interface receives input from a constant component. We also see the msgdma, FPGA OCRAM, default subordinate and System ID core that was mentioned above.

Two additional components are visible in the f2sdram_bridge subsystem, a limiter_removal core and an f2sdram_adapter core. The limiter_removal core translates the Avalon MM interfaces from the msgdma core into AXI4 so that the Platform Designer interconnect generator does not see a need to insert limiter cores within the interconnect that it generates along that data path. The f2sdram_adapter core is used to decorate the AXI4 transactions passed into the f2sdram bridge properly, so they are routed and managed properly within the HPS subsystem.

| f2sdram_bridge subsystem |
| :---: |
| ![hw_f2sdram_bridge_subsys.png](./images/captures/hw_f2sdram_bridge_subsys.png) |


## Software demo - u-boot standalone - menu-p

In the u-boot standalone application we configure the msgdma core to move a 32KB randomized data pattern from an initial buffer allocated in HPS EMIF memory to the FPGA OCRAM memory. Then we configure the msgdma core to move the 32KB data from the FPGA OCRAM memory to a secondary buffer in HPS EMIF memory. The initial buffer contents are then checked against the secondary buffer contents to ensure the data movement occurred as expected.

```text
	/*
	 * we will now DMA data from dma_buffer_0 to the FPGA OCRAM buffer
	 * and then DMA from the FPGA OCRAM buffer to dma_buffer_1
	 */

	/* clear the three buffers that we'll use for DMA transfers */
	/* this isn't necessary but for demonstration purposes we'll do it */
	memset(dma_buffer_0, 0, F2SDRAM_OCRAM_32K_SPAN);
	memset(dma_buffer_1, 0, F2SDRAM_OCRAM_32K_SPAN);
	memset((void*)(F2SDRAM_OCRAM_32K_BASE), 0, F2SDRAM_OCRAM_32K_SPAN);

	/* fill the initial buffer with a randomized data pattern */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	temp ^= 0xFbFdF1F3F5F7FbFd;
	temp += 0x0b0d010305070b0d;
	for(i = 0 ; i < (F2SDRAM_OCRAM_32K_SPAN / sizeof(uint64_t)) ; i++) {
		temp += 0x0b0d010305070b0d;
		dma_buffer_0_word_ptr[i] = temp++;
	}

	/* flush the data cache */
	flush_dcache_range((uint64_t)dma_buffer_0,
		(uint64_t)((void*)(dma_buffer_0) + F2SDRAM_OCRAM_32K_SPAN));
	flush_dcache_range((uint64_t)dma_buffer_1,
		(uint64_t)((void*)(dma_buffer_1) + F2SDRAM_OCRAM_32K_SPAN));

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(F2SDRAM_MSGDMA_CSR_BASE))[0];
	if(temp_32 != 0x00000002) {
		f2sdram_bridge->error = 2;
		return;
	}

	/* build our descriptor for dma_buffer_0 to FPGA OCRAM */
	descriptor[0] = (uint64_t)(dma_buffer_0) & 0xFFFFFFFF;
	descriptor[1] = MSGDMA_OCRAM_32K_BASE & 0xFFFFFFFF;
	descriptor[2] = F2SDRAM_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = (uint64_t)(dma_buffer_0) >> 32;
	descriptor[6] = MSGDMA_OCRAM_32K_BASE >> 32;
	descriptor[7] = 0x80000000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 8 ; i++) {
		((volatile uint32_t *)(F2SDRAM_MSGDMA_DES_BASE))[i] =
								descriptor[i];
	}

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = ((volatile uint32_t *)(F2SDRAM_MSGDMA_CSR_BASE))[0];
	while((temp_32 & 0x00000001) == 0x00000001) {
		asm volatile (
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			f2sdram_bridge->error = 3;
			return;
		}
		temp_32 = ((volatile uint32_t *)(F2SDRAM_MSGDMA_CSR_BASE))[0];
	}

	/* initialize intermediate DMA pointers for F2H transfer */
	dma_rd_ptr = MSGDMA_OCRAM_32K_BASE;
	dma_wr_ptr = (uint64_t)(dma_buffer_1);

	/* make sure the MSGDMA is not currently busy */
	temp_32 = ((volatile uint32_t *)(F2SDRAM_MSGDMA_CSR_BASE))[0];
	if(temp_32 != 0x00000002) {
		f2sdram_bridge->error = 4;
		return;
	}

	/* build our descriptor for FPGA OCRAM to dma_buffer_0 */
	descriptor[0] = dma_rd_ptr & 0xFFFFFFFF;
	descriptor[1] = dma_wr_ptr & 0xFFFFFFFF;
	descriptor[2] = F2SDRAM_OCRAM_32K_SPAN;
	descriptor[3] = 0x00000000;
	descriptor[4] = 0x00000000;
	descriptor[5] = dma_rd_ptr >> 32;
	descriptor[6] = dma_wr_ptr >> 32;
	descriptor[7] = 0x80000000;

	/* push the descriptor into the MSGDMA */
	for(i = 0 ; i < 4 ; i++) {
		((volatile uint64_t *)(F2SDRAM_MSGDMA_DES_BASE))[i] =
			((uint64_t)(descriptor[(i * 2) + 1]) << 32) |
			descriptor[i * 2];
	}

	/* wait for the DMA to idle, timeout after 1ms */
	asm volatile (
		"mrs %[temp], cntpct_el0\n"
		: [temp] "=r" (temp)
	);
	timeout = temp + (cntfrq_el0 / 1000);

	temp_32 = ((volatile uint32_t *)(F2SDRAM_MSGDMA_CSR_BASE))[0];
	while((temp_32 & 0x00000001) == 0x00000001) {
		asm volatile (
			"mrs %[temp], cntpct_el0\n"
			: [temp] "=r" (temp)
		);
		if(temp >= timeout) {
			f2sdram_bridge->error = 5;
			return;
		}
		temp_32 =
		((volatile uint32_t *)(F2SDRAM_MSGDMA_CSR_BASE))[0];
	}

	/* dsb so that a76 waits for outstanding io before comparing buffers */
	asm volatile (
		"dsb sy\n"
	);

	/* verify the initial buffer matches the final buffer */
	if(memcmp(dma_buffer_0, dma_buffer_1, F2SDRAM_OCRAM_32K_SPAN) == 0) {
		f2sdram_bridge->error = 0;
	} else {
		f2sdram_bridge->error = 6;
	}
```

The output from this demo is shown below. The value of the signature read back from the hps_gp_in constant is displayed as well as the System ID values. The status of the initial and secondary buffer comparison is also displayed. The time required to execute each stage of the process is also printed in the output.

```text
F2SDRAM Demo

HPS_GP_IN signature value = 0x44533246 : F2SD

SYSID_ID: 0x44533246
SYSID_TS: 0x666D3548

No errors detected...

   DCACHE FLUSH TIME:     24542.500ns
 BUFFER COMPARE TIME:    214260.000ns
HPS to FPGA DMA TIME:      6652.500ns :   4.587GB/s
FPGA to HPS DMA TIME:      6015.000ns :   5.073GB/s

Press any key to exit this demo.
```

## Software demo - Linux - menu-p

The Linux version of this demo is essentially the same as the u-boot standalone application except in Linux we must map a virtual address to access the physical addresses of the peripherals. We use the uio driver to facilitate that for us.

The HPS EMIF memory buffer that we use is allocated from a reserved memory buffer that we define in the Linux devicetree so we completely control the allocation of that reserved memory for our own needs.

In Linux, we also demonstrate two methods of determining when the msgdma core has completed the transfers. First, we demonstrate a polling method like we used in the u-boot application, and then we demonstrate an interrupt method which we also facilitate through a uio driver.

---
Return to [**Index**](01_index.md)
