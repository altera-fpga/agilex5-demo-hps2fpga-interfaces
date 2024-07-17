/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include "alt_types.h"
#include "intel_lw_uart_regs.h"
#include "system.h"

int main(void) {

	alt_u32 status;
	alt_u32 rx_char;

	while(1) {
		status = IORD_INTEL_LW_UART_STATUS(LW_UART_BASE);
		status &= INTEL_LW_UART_STATUS_RRDY_MSK;
		if(status == INTEL_LW_UART_STATUS_RRDY_MSK) {
			rx_char = IORD_INTEL_LW_UART_RXDATA(LW_UART_BASE);
			do {
				status =
					IORD_INTEL_LW_UART_STATUS(LW_UART_BASE);
				status &= INTEL_LW_UART_STATUS_TRDY_MSK;
				if(status == INTEL_LW_UART_STATUS_TRDY_MSK) {
					IOWR_INTEL_LW_UART_TXDATA(LW_UART_BASE,
								~rx_char);
				}
			} while(status != INTEL_LW_UART_STATUS_TRDY_MSK);
		}
	}
}

