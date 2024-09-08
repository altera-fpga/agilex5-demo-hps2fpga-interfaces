#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

TAG_NAME="QPDS24.2_REL_GSRD_PR"

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
rsync
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

# check if source repos already exists
[ -d ./arm-trusted-firmware ] && {
	echo "INFO: arm-trusted-firmware directory already exists"
	exit 0
}

[ -d ./u-boot-socfpga ] && {
	echo "INFO: u-boot-socfpga directory already exists"
	exit 0
}

# build the bootloaders
tar xf ../../repo_downloads/arm-trusted-firmware-${TAG_NAME:?}.tgz \
	|| { echo "ERROR" ; exit 1 ; }

mv arm-trusted-firmware-${TAG_NAME:?} arm-trusted-firmware \
	|| { echo "ERROR" ; exit 1 ; }

tar xf ../../repo_downloads/u-boot-socfpga-${TAG_NAME:?}.tgz \
	|| { echo "ERROR" ; exit 1 ; }

mv u-boot-socfpga-${TAG_NAME:?} u-boot-socfpga \
	|| { echo "ERROR" ; exit 1 ; }

cd arm-trusted-firmware || { echo "ERROR" ; exit 1 ; }

make -j 48 PLAT=agilex5 bl31 || { echo "ERROR" ; exit 1 ; }

cd ../u-boot-socfpga || { echo "ERROR" ; exit 1 ; }

make mrproper || { echo "ERROR" ; exit 1 ; }

make socfpga_agilex5_defconfig || { echo "ERROR" ; exit 1 ; }

ln -s ../arm-trusted-firmware/build/agilex5/release/bl31.bin \
	|| { echo "ERROR" ; exit 1 ; }

./scripts/kconfig/merge_config.sh -O ./ ./.config \
	../../../common_sw/u-boot_patches/config-fragment \
	|| { echo "ERROR" ; exit 1 ; }

PATCH_FILES="
../../../common_sw/u-boot_patches/include-exports.h.patch \
../../../common_sw/u-boot_patches/include-configs-socfpga_soc64_common.h.patch \
../../../common_sw/u-boot_patches/include-_exports.h.patch \
../../../common_sw/u-boot_patches/examples-standalone-Makefile.patch \
../../../common_sw/u-boot_patches/examples-Makefile.patch \
../../../common_sw/u-boot_patches/brd_macnica_sulfur_es_125-arch-arm-dts-socfpga_agilex5_socdk-u-boot.dtsi.patch
"
for NEXT_PATCH in ${PATCH_FILES:?}
do
	patch -p1 \
	-i ${NEXT_PATCH:?} \
		|| { echo "ERROR" ; exit 1 ; }
done

ln	-s \
	-t ./examples/standalone/ \
../../../../../common_sw/u-boot_standalone_apps/armv8_regs.c \
../../../../../common_sw/u-boot_standalone_apps/boot_app.c \
../../../../../common_sw/u-boot_standalone_apps/cache_regs.c \
../../../../../common_sw/u-boot_standalone_apps/emac.c \
../../../../../common_sw/u-boot_standalone_apps/config_clk.c \
../../../../../common_sw/u-boot_standalone_apps/f2h_bridge.c \
../../../../../common_sw/u-boot_standalone_apps/f2h_irq.c \
../../../../../common_sw/u-boot_standalone_apps/f2h_irq_handler.c \
../../../../../common_sw/u-boot_standalone_apps/f2sdram_bridge.c \
../../../../../common_sw/u-boot_standalone_apps/h2f_bridge.c \
../../../../../common_sw/u-boot_standalone_apps/h2f_bridge_def_sub.c \
../../../../../common_sw/u-boot_standalone_apps/h2f_user_clk.c \
../../../../../common_sw/u-boot_standalone_apps/help_text.h \
../../../../../common_sw/u-boot_standalone_apps/hps_gp.c \
../../../../../common_sw/u-boot_standalone_apps/i2c_bridge.c \
../../../../../common_sw/u-boot_standalone_apps/lwh2f_bridge.c \
../../../../../common_sw/u-boot_standalone_apps/lwh2f_bridge_def_sub.c \
../../../../../common_sw/u-boot_standalone_apps/read_sensors.c \
../../../../../common_sw/u-boot_standalone_apps/sdm_query.c \
../../../../../common_sw/u-boot_standalone_apps/spi_bridge.c \
../../../../../common_sw/u-boot_standalone_apps/standalone_common.h \
../../../../../common_sw/u-boot_standalone_apps/system_counter.c \
../../../../../common_sw/u-boot_standalone_apps/uart.c \
	|| { echo "ERROR" ; exit 1 ; }

ln	-s \
../../../../../common_sw/u-boot_standalone_apps/select_uart1.h \
./examples/standalone/select_uart.h \
	|| { echo "ERROR" ; exit 1 ; }

make -j 48 || { echo "ERROR" ; exit 1 ; }

