#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

ifndef THE_DTC
$(error THE_DTC is not set)
endif

DTC := $(THE_DTC)

DTSSRCS := \
./hw_config_clk.dts \
./hw_emac.dts \
./hw_f2h_bridge.dts \
./hw_f2h_irq.dts \
./hw_f2sdram_bridge.dts \
./hw_h2f_bridge.dts \
./hw_h2f_user_clk.dts \
./hw_hps_gp.dts \
./hw_hps_jamb.dts \
./hw_i2c_bridge.dts \
./hw_i2c_bridge_drvr.dts \
./hw_lwh2f_bridge.dts \
./hw_no_periph.dts \
./hw_spi_bridge.dts \
./hw_spi_bridge_drvr.dts \
./hw_uart.dts \
./hw_uart0_drvr.dts \
./hw_uart1_drvr.dts

DTBOS := $(patsubst %.dts, %.dtbo, $(DTSSRCS))

#-------------------------------------------------------------------------------
# PHONY targets
#-------------------------------------------------------------------------------
.PHONY: all
all: $(DTBOS)

.PHONY: show
show:
	$(info DTSSRCS = $(DTSSRCS))
	$(info DTBOS   = $(DTBOS))

.PHONY: clean
clean:
	rm -f $(DTBOS)

#-------------------------------------------------------------------------------
# rules
#-------------------------------------------------------------------------------
$(DTBOS) : %.dtbo: %.dts
	$(DTC) -I dts -O dtb -o $@ $<

