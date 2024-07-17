#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# change into the directory of this script
cd $(dirname ${0})

[ -z "${BOARD_DIR}" ] && {
	echo ""
	echo "USAGE: BOARD_DIR=<board-dir-name> ${0}"
	echo ""
	echo "Set BOARD_DIR environment variable to the board directory name."
	echo ""
	echo "Currently valid board directories:"
	echo "    'brd_altera_a5e065_premium_es'"
	echo "    'brd_arrow_axe5_eagle_es'"
	echo "    'brd_criticallink_mitysbc_es'"
	echo ""
	exit 1
}

[ -d "${BOARD_DIR:?}" ] || {
	echo ""
	echo "ERROR: board directory does not exist..."
	echo "'${BOARD_DIR:?}'"
	echo ""
	exit 1
}

./repo_downloads/download_repos.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/init_hw_build_scripts.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/build_hw.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/sw_builds/build_bootloaders.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/create_bitstreams.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/sw_builds/build_toybox.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/sw_builds/build_linux_apps.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/sw_builds/linux_apps/install_toybox_hw.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/sw_builds/linux_apps/install_toybox_sw.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/sw_builds/linux_apps/install_toybox_scripts.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/sw_builds/build_linux_kernel.sh \
	|| { echo "ERROR" ; exit 1 ; }
./"${BOARD_DIR:?}"/images/build_images.sh \
	|| { echo "ERROR" ; exit 1 ; }

