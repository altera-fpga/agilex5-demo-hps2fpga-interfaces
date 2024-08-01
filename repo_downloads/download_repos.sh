#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# change into the directory of this script
cd $(dirname ${0})


QPDS_TAG="QPDS24.2_REL_GSRD_PR"
TOYBOX_TAG="0.8.11"

REPO_LIST="
https://github.com/altera-opensource/arm-trusted-firmware/archive/refs/tags/${QPDS_TAG:?}.tar.gz
https://github.com/altera-opensource/linux-socfpga/archive/refs/tags/${QPDS_TAG:?}.tar.gz
https://github.com/altera-opensource/u-boot-socfpga/archive/refs/tags/${QPDS_TAG:?}.tar.gz
https://github.com/landley/toybox/archive/refs/tags/${TOYBOX_TAG:?}.tar.gz
"

# download the repo archives if we don't already have them
for NEXT in ${REPO_LIST:?}
do
	ARCHIVE_NAME=${NEXT##*/}
	TAG_NAME=${ARCHIVE_NAME%%.tar.gz}
	REPO_NAME_1=${NEXT#*github.com/*/}
	REPO_NAME=${REPO_NAME_1%%/*}
	LOCAL_ARCHIVE_NAME="${REPO_NAME:?}-${TAG_NAME:?}.tgz"

	[ -f "${LOCAL_ARCHIVE_NAME:?}" ] || {
		wget \
		-O "${LOCAL_ARCHIVE_NAME:?}" \
		"${NEXT:?}" \
		|| { echo "ERROR" ; exit 1 ; }
	}
done

# download the musl compiler if we don't already have it
[ -f aarch64-linux-musleabi-cross.tar.xz ] || {
	wget \
	https://landley.net/toybox/downloads/binaries/toolchains/latest/aarch64-linux-musleabi-cross.tar.xz \
	|| { echo "ERROR" ; exit 1 ; }
}

# create source archive for distribution
[ -f repo_downloads.tar ] || {
	tar -cf repo_downloads.tar \
	aarch64-linux-musleabi-cross.tar.xz \
	arm-trusted-firmware-${QPDS_TAG:?}.tgz \
	u-boot-socfpga-${QPDS_TAG:?}.tgz \
	linux-socfpga-${QPDS_TAG:?}.tgz \
	toybox-${TOYBOX_TAG:?}.tgz \
	|| { echo "ERROR" ; exit 1 ; }
}

exit 0
