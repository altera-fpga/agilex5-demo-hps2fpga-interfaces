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
	echo "Building hardware directory: '${NEXT_BUILD_DIR:?}'"
	"${NEXT_BUILD_DIR:?}"/init_proj.sh && \
	"${NEXT_BUILD_DIR:?}"/build_hw.sh
done

