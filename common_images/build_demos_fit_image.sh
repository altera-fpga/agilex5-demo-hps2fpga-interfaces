#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# verify that the tools we need are available in the environment
TOOLS_REQUIRED="
../sw_builds/u-boot-socfpga/tools/mkimage
xz
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

# change into the directory of this script
cd $(dirname ${0})

# create u-boot attribution script
./create_attribution.sh \
	|| { echo "ERROR" ; exit 1 ; }

# create the FIT image
PATH=../sw_builds/u-boot-socfpga/scripts/dtc:${PATH} \
	../sw_builds/u-boot-socfpga/tools/mkimage \
	-f ./fit_no-pins-demos.its \
	no-pins-demos.itb.bin \
	|| { echo "ERROR" ; exit 1 ; }

# compress the FIT image
rm no-pins-demos.itb.bin.lzma
xz \
	--format=lzma \
	--keep \
	no-pins-demos.itb.bin \
	|| { echo "ERROR" ; exit 1 ; }

# create the FIT image
PATH=../sw_builds/u-boot-socfpga/scripts/dtc:${PATH} \
	../sw_builds/u-boot-socfpga/tools/mkimage \
	-f ./fit_lzma-no-pins-demos.its \
	lzma-no-pins-demos.itb.bin \
	|| { echo "ERROR" ; exit 1 ; }

