#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# change into the directory of this script
cd $(dirname ${0})

#
# if install directory does not exist, stop
#
INSTALL_DIR="../toybox/install"
[ -d "${INSTALL_DIR:?}" ] || {
	echo "ERROR: install directory does not exist"
	echo "'${INSTALL_DIR:?}'"
	exit 1
}

#
# if destination scripts directory already exists, remove it
#
SCRIPTS_DIR="${INSTALL_DIR:?}/scripts"
[ -d "${SCRIPTS_DIR:?}" ] && {
	echo "INFO: deleting destination scripts directory"
	echo "'${SCRIPTS_DIR:?}'"
	rm -rf "${SCRIPTS_DIR:?}"
}

#
# create destination scripts directory
#
SCRIPTS_DIR="${INSTALL_DIR:?}/scripts"
[ -d "${SCRIPTS_DIR:?}" ] || {
	mkdir "${SCRIPTS_DIR:?}" || {
		echo "ERROR: cannot create destination scripts directory"
		echo "'${SCRIPTS_DIR:?}'"
		exit 1
	}
}

#
# copy all top level scripts
#
TOP_SCRIPTS="
../../../common_sw/toybox_scripts/demo
../../../common_sw/toybox_scripts/init
../../../common_sw/toybox_scripts/start
"

for NEXT in ${TOP_SCRIPTS:?}
do
	cp -f "${NEXT:?}" \
		"${INSTALL_DIR:?}/$(basename ${NEXT:?})" \
		|| { echo "ERROR" ; exit 1 ; }
done

#
# copy all scripts level scripts
#
SCRIPTS_SCRIPTS="
../../../common_sw/toybox_scripts/prog-a55-rpd
../../../common_sw/toybox_scripts/prog-a76-rpd
../../../common_sw/toybox_scripts/read_sensors
"

for NEXT in ${SCRIPTS_SCRIPTS:?}
do
	cp "${NEXT:?}" \
		"${SCRIPTS_DIR:?}/$(basename ${NEXT:?})" \
		|| { echo "ERROR" ; exit 1 ; }
done

echo "INFO: completed installing script objects into toybox rootfs"

