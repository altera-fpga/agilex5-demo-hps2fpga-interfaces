#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# change into the directory of this script
cd $(dirname ${0})

# verify that the project directory exists in the common PD subsystems directory
COMMON_PD_SUBSYSTEMS_DIR="../../common_pd_subsystems"
PROJ_DIR="$(basename $(pwd))"

[ -d "${COMMON_PD_SUBSYSTEMS_DIR:?}/${PROJ_DIR:?}" ] || {
	echo ""
	echo "ERROR: common project directory does not exist..."
	echo "'${COMMON_PD_SUBSYSTEMS_DIR:?}/${PROJ_DIR:?}'"
	echo ""
	exit 1
}

# copy the contents of the common directory into this directory
cp -R "${COMMON_PD_SUBSYSTEMS_DIR:?}/${PROJ_DIR:?}"/* .

