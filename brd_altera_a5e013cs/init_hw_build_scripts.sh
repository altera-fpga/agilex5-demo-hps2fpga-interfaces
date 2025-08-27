#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# change into the directory of this script
cd $(dirname ${0})

cp -s \
-t ./ \
../common_build_scripts/build_hw.sh \
../common_build_scripts/check_hw_build.sh \
../common_build_scripts/create_bitstreams.sh \
../common_build_scripts/hw_build_dirs.src \
|| { echo "ERROR" ; exit 1 ; }

# source the hardware build directories variable declaration
. ./hw_build_dirs.src

for NEXT_BUILD_DIR in ${HW_BUILD_DIRECTORIES:?}
do
	echo "Creating hardware directory: '${NEXT_BUILD_DIR:?}'"
	mkdir "${NEXT_BUILD_DIR:?}" && \
	ln -s \
	../../common_build_scripts/uart0_init_proj.sh \
	./${NEXT_BUILD_DIR:?}/init_proj.sh \
	|| { echo "ERROR" ; exit 1 ; }
done

