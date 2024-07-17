#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

TAG_NAME="0.8.11"

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
[ -d ./toybox ] && {
	echo "INFO: toybox directory already exists"
	exit 0
}

# copy toybox repo
tar xf ../../repo_downloads/toybox-${TAG_NAME:?}.tgz \
	|| { echo "ERROR" ; exit 1 ; }

mv toybox-${TAG_NAME:?} toybox \
	|| { echo "ERROR" ; exit 1 ; }

# change into the repo directory
cd toybox \
	|| { echo "ERROR" ; exit 1 ; }

# configure the project
make defconfig \
	|| { echo "ERROR" ; exit 1 ; }
sed -i.bak -e "s/^# CONFIG_SH is not set$/CONFIG_SH=y/" .config \
	|| { echo "ERROR" ; exit 1 ; }

# make the toybox rootfs and install it
make root \
	|| { echo "ERROR" ; exit 1 ; }

make install \
	|| { echo "ERROR" ; exit 1 ; }
