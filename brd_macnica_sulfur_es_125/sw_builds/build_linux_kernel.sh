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
rsync \
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

# check if source repos already exists
[ -d ./linux-socfpga ] && {
	echo "INFO: linux-socfpga directory already exists"
	exit 0
}

# copy linux-socfpga repo
tar xf ../../repo_downloads/linux-socfpga-${TAG_NAME:?}.tgz \
	|| { echo "ERROR" ; exit 1 ; }

mv linux-socfpga-${TAG_NAME:?} linux-socfpga \
	|| { echo "ERROR" ; exit 1 ; }

# change into the repo directory
cd linux-socfpga \
	|| { echo "ERROR" ; exit 1 ; }

# configure the project
make tinyconfig \
	|| { echo "ERROR" ; exit 1 ; }

# merge config fragment into the config file
./scripts/kconfig/merge_config.sh -O ./ ./.config ../../../common_sw/linux_patches/config-fragment \
	|| { echo "ERROR" ; exit 1 ; }

# apply patches to the kernel sources
PATCH_FILES="
../../../common_sw/linux_patches/brd_macnica_sulfur_es_125-arch-arm64-boot-dts-intel-socfpga_agilex5_socdk.dts.patch
"
for NEXT_PATCH in ${PATCH_FILES:?}
do
	patch -p1 \
	-i ${NEXT_PATCH:?} \
		|| { echo "ERROR" ; exit 1 ; }
done

# make the kernel and devicetree
make -j 48 Image dtbs \
	|| { echo "ERROR" ; exit 1 ; }
