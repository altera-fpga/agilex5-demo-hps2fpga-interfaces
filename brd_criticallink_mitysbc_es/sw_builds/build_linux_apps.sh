#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# change into the directory of this script
cd $(dirname ${0})

# extract the musl compiler if we don't already have it
[ -d aarch64-linux-musleabi-cross ] || {
	tar xf ../../repo_downloads/aarch64-linux-musleabi-cross.tar.xz \
		|| { echo "ERROR" ; exit 1 ; }
}

# configure the cross compile environment
export CROSS_COMPILE=$(realpath aarch64-linux-musleabi-cross/bin/aarch64-linux-musleabi-)
export ARCH=arm64

# verify that the tools we need are available in the environment
TOOLS_REQUIRED="
${CROSS_COMPILE:?}gcc \
git \
make \
sed
"
ERROR_DETECTED=0
for NEXT_TOOL in ${TOOLS_REQUIRED:?}
do
	type -P "${NEXT_TOOL}" > /dev/null 2>&1 || {
		echo "ERROR: required tool is not avaialble in environment"
		echo "'${NEXT_TOOL}'"
		ERROR_DETECTED=1
	}
done
[ ${ERROR_DETECTED} -ne 0 ] && {
	exit 1
}

# check if source directory already exists
[ -d ./linux_apps ] && {
	echo "INFO: linux_apps directory already exists"
	exit 0
}

# create the source directory
mkdir ./linux_apps \
	|| { echo "ERROR" ; exit 1 ; }

# change into the source directory
cd linux_apps \
	|| { echo "ERROR" ; exit 1 ; }

# create symlinks to source files
SOURCES="
../../../common_sw/linux_apps/install_toybox_hw.sh
../../../common_sw/linux_apps/install_toybox_scripts.sh
../../../common_sw/linux_apps/install_toybox_sw.sh
../../../common_sw/linux_apps/armv8_regs.c
../../../common_sw/linux_apps/boot_app.c
../../../common_sw/linux_apps/cache_regs.c
../../../common_sw/linux_apps/config_clk.c
../../../common_sw/linux_apps/emac.c
../../../common_sw/linux_apps/f2h_bridge.c
../../../common_sw/linux_apps/f2h_irq.c
../../../common_sw/linux_apps/f2h_irq_handler.c
../../../common_sw/linux_apps/f2sdram_bridge.c
../../../common_sw/linux_apps/h2f_bridge.c
../../../common_sw/linux_apps/h2f_bridge_def_sub.c
../../../common_sw/linux_apps/h2f_user_clk.c
../../../common_sw/linux_apps/hps_gp.c
../../../common_sw/linux_apps/i2c_bridge.c
../../../common_sw/linux_apps/i2c_bridge_drvr.c
../../../common_sw/linux_apps/linux_help_text.h
../../../common_sw/linux_apps/lwh2f_bridge.c
../../../common_sw/linux_apps/lwh2f_bridge_def_sub.c
../../../common_sw/linux_apps/Makefile
../../../common_sw/linux_apps/spi_bridge.c
../../../common_sw/linux_apps/spi_bridge_drvr.c
../../../common_sw/linux_apps/system_counter.c
../../../common_sw/linux_apps/uart.c
../../../common_sw/linux_apps/uart_drvr.c
../../../common_sw/linux_apps/uio_helpers.c
../../../common_sw/linux_apps/uio_helpers.h
../../../common_sw/linux_apps/waitforonechar.c
../../../common_sw/u-boot_standalone_apps/help_text.h
../../../common_sw/u-boot_standalone_apps/standalone_common.h
"

for NEXT in ${SOURCES:?}
do
	[ -f "$(basename "${NEXT:?}")" ] || {
		cp -s -t ./ "${NEXT:?}" || { echo "ERROR" ; exit 1 ; }
		echo "Created symbolic link for '$(basename ${NEXT:?})'"
	}
done

cp -s \
../../../common_sw/u-boot_standalone_apps/select_uart0.h \
./select_uart.h \
	|| { echo "ERROR" ; exit 1 ; }
echo "Created symbolic link for '$(basename ./select_uart.h)'"

# make the applications
make \
	|| { echo "ERROR" ; exit 1 ; }
