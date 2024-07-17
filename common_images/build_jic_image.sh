#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# verify that the tools we need are available in the environment
TOOLS_REQUIRED="
quartus_pfg
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

# create the JIC image
./build_demos_fit_image.sh || { echo "ERROR" ; exit 1 ; }

cp ../sw_builds/u-boot-socfpga/u-boot.itb u-boot.itb.bin \
	|| { echo "ERROR" ; exit 1 ; }

quartus_pfg -c ./jic_no-pins-demos.pfg \
	|| { echo "ERROR" ; exit 1 ; }

