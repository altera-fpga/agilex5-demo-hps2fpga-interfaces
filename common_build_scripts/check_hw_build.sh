#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# change into the directory of this script
cd $(dirname ${0})

# source the hardware build directories variable declaration
. ./hw_build_dirs.src

for NEXT_BUILD_DIR in ${HW_BUILD_DIRECTORIES:?}
do
	if [ -f ${NEXT_BUILD_DIR:?}/output_files/no_pins_top.sof ]
	then
		echo "${NEXT_BUILD_DIR:?}: built"
	else
		echo "${NEXT_BUILD_DIR:?}: **** NOT BUILT ****"
	fi
done

