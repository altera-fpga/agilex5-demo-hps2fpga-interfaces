#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

ifndef CROSS_COMPILE
$(error CROSS_COMPILE is not set)
endif

CC := $(CROSS_COMPILE)gcc
LD := $(CROSS_COMPILE)ld
STRIP := $(CROSS_COMPILE)strip

#-fsanitize=cfi
#-pie \

CFLAGS := -O2 \
-Wall \
-Wextra \
-Werror \
-flto \
-fvisibility=hidden \
-Wformat \
-Wformat-security \
-Werror=format-security \
-z noexecstack \
-fPIC \
-fPIE \
-D_FORTIFY_SOURCE=2 \
-Wl,-z,relro,-z,now \
-fstack-protector-strong

# UNSUPPORTED FLAGS
#-fsanitize=cfi
#-pie \

APP_SRCS := \
./armv8_regs.c \
./boot_app.c \
./config_clk.c \
./f2h_bridge.c \
./f2h_irq.c \
./f2h_irq_handler.c \
./f2sdram_bridge.c \
./h2f_bridge.c \
./h2f_bridge_def_sub.c \
./h2f_user_clk.c \
./hps_gp.c \
./i2c_bridge.c \
./i2c_bridge_drvr.c \
./lwh2f_bridge.c \
./lwh2f_bridge_def_sub.c \
./spi_bridge.c \
./spi_bridge_drvr.c \
./system_counter.c \
./uart.c \
./uart_drvr.c \
./waitforonechar.c

OTHER_SRCS := \
./uio_helpers.c

COBJS := $(patsubst %.c, %.o, $(APP_SRCS) $(OTHER_SRCS))
ELFS := $(patsubst %.c, %.elf, $(APP_SRCS))
APPS := $(patsubst %.c, %, $(APP_SRCS))

#-------------------------------------------------------------------------------
# PHONY targets
#-------------------------------------------------------------------------------
.PHONY: all
all: $(APPS)

.PHONY: show
show:
	$(info APP_SRCS   = $(APP_SRCS))
	$(info OTHER_SRCS = $(OTHER_SRCS))
	$(info COBJS      = $(COBJS))
	$(info ELFS       = $(ELFS))
	$(info APPS       = $(APPS))

.PHONY: clean
clean:
	rm -f $(APPS) $(ELFS) $(COBJS)

#-------------------------------------------------------------------------------
# armv8_regs app
#-------------------------------------------------------------------------------
armv8_regs : armv8_regs.elf
	$(STRIP) -s -o $@ $<

armv8_regs.elf : armv8_regs.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# boot_app app
#-------------------------------------------------------------------------------
boot_app : boot_app.elf
	$(STRIP) -s -o $@ $<

boot_app.elf : boot_app.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# config_clk app
#-------------------------------------------------------------------------------
config_clk : config_clk.elf
	$(STRIP) -s -o $@ $<

config_clk.elf : config_clk.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# f2h_bridge app
#-------------------------------------------------------------------------------
f2h_bridge : f2h_bridge.elf
	$(STRIP) -s -o $@ $<

f2h_bridge.elf : f2h_bridge.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# f2h_irq app
#-------------------------------------------------------------------------------
f2h_irq : f2h_irq.elf
	$(STRIP) -s -o $@ $<

f2h_irq.elf : f2h_irq.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# f2h_irq_handler app
#-------------------------------------------------------------------------------
f2h_irq_handler : f2h_irq_handler.elf
	$(STRIP) -s -o $@ $<

f2h_irq_handler.elf : f2h_irq_handler.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# f2sdram_bridge app
#-------------------------------------------------------------------------------
f2sdram_bridge : f2sdram_bridge.elf
	$(STRIP) -s -o $@ $<

f2sdram_bridge.elf : f2sdram_bridge.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# hps_gp app
#-------------------------------------------------------------------------------
hps_gp : hps_gp.elf
	$(STRIP) -s -o $@ $<

hps_gp.elf : hps_gp.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# h2f_user_clk app
#-------------------------------------------------------------------------------
h2f_user_clk : h2f_user_clk.elf
	$(STRIP) -s -o $@ $<

h2f_user_clk.elf : h2f_user_clk.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# h2f_bridge app
#-------------------------------------------------------------------------------
h2f_bridge : h2f_bridge.elf
	$(STRIP) -s -o $@ $<

h2f_bridge.elf : h2f_bridge.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# h2f_bridge_def_sub app
#-------------------------------------------------------------------------------
h2f_bridge_def_sub : h2f_bridge_def_sub.elf
	$(STRIP) -s -o $@ $<

h2f_bridge_def_sub.elf : h2f_bridge_def_sub.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# i2c_bridge app
#-------------------------------------------------------------------------------
i2c_bridge : i2c_bridge.elf
	$(STRIP) -s -o $@ $<

i2c_bridge.elf : i2c_bridge.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# i2c_bridge_drvr app
#-------------------------------------------------------------------------------
i2c_bridge_drvr : i2c_bridge_drvr.elf
	$(STRIP) -s -o $@ $<

i2c_bridge_drvr.elf : i2c_bridge_drvr.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# lwh2f_bridge app
#-------------------------------------------------------------------------------
lwh2f_bridge : lwh2f_bridge.elf
	$(STRIP) -s -o $@ $<

lwh2f_bridge.elf : lwh2f_bridge.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# lwh2f_bridge_def_sub app
#-------------------------------------------------------------------------------
lwh2f_bridge_def_sub : lwh2f_bridge_def_sub.elf
	$(STRIP) -s -o $@ $<

lwh2f_bridge_def_sub.elf : lwh2f_bridge_def_sub.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# spi_bridge app
#-------------------------------------------------------------------------------
spi_bridge : spi_bridge.elf
	$(STRIP) -s -o $@ $<

spi_bridge.elf : spi_bridge.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# spi_bridge_drvr app
#-------------------------------------------------------------------------------
spi_bridge_drvr : spi_bridge_drvr.elf
	$(STRIP) -s -o $@ $<

spi_bridge_drvr.elf : spi_bridge_drvr.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# system_counter app
#-------------------------------------------------------------------------------
system_counter : system_counter.elf
	$(STRIP) -s -o $@ $<

system_counter.elf : system_counter.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# uart app
#-------------------------------------------------------------------------------
uart : uart.elf
	$(STRIP) -s -o $@ $<

uart.elf : uart.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# uart_drvr app
#-------------------------------------------------------------------------------
uart_drvr : uart_drvr.elf
	$(STRIP) -s -o $@ $<

uart_drvr.elf : uart_drvr.o uio_helpers.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# waitforonechar app
#-------------------------------------------------------------------------------
waitforonechar : waitforonechar.elf
	$(STRIP) -s -o $@ $<

waitforonechar.elf : waitforonechar.o
	$(CC) -static $(CFLAGS) -o $@ $^

#-------------------------------------------------------------------------------
# rules
#-------------------------------------------------------------------------------
$(COBJS) : %.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<

