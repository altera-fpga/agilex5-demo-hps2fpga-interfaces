#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

[ "${#}" == "1" ] || {
	echo ""
	echo "USAGE: ${0} <pd-tcl-file>"
	echo ""
	exit 1
}

[ -f ${1:?} ] || {
	echo ""
	echo "ERROR: file does not exist"
	echo "'${1:?}'"
	echo ""
	exit 1
}

TEMP_COUNTER="0"
CUR_TEMP_FILE="${1:?}_${TEMP_COUNTER:?}"

cat "${1:?}" | \
sed -e "/set_module_property BONUS_DATA/,/^}/ s/\(^.*$\)/\t\\1/" > "${CUR_TEMP_FILE:?}"
echo "Bonus Data shifted right: ${CUR_TEMP_FILE:?}"

LAST_TEMP_FILE="${CUR_TEMP_FILE:?}"
((TEMP_COUNTER++))
CUR_TEMP_FILE="${1:?}_${TEMP_COUNTER:?}"

while grep -lPq -e "^proc" "${LAST_TEMP_FILE:?}" ;
do

PROC_FILE_PREFIX="$(sed -n -e "0,/^proc/ s/^proc\s\+\(\S\+\)\s\+.*$/\\1/p" "${LAST_TEMP_FILE:?}")"
PROC_FILE="${PROC_FILE_PREFIX:?}.tcl"
[ -f "${PROC_FILE:?}" ] && {
	echo ""
	echo "ERROR: file already exists"
	echo "'${PROC_FILE:?}'"
	echo ""
	exit 1
}

cat "${LAST_TEMP_FILE:?}" | \
sed -n -e "/^proc\s\+${PROC_FILE_PREFIX:?}/,/^}/p" | \
sed -e "/set_project_property\s\+DEVICE\s\+/ s/set_project_property/#set_project_property/" \
-e "/set_project_property\s\+DEVICE_FAMILY\s\+/ s/set_project_property/#set_project_property/" \
> "${PROC_FILE:?}.tmp"

cat "${LAST_TEMP_FILE:?}" | \
sed -e "/^proc\s\+${PROC_FILE_PREFIX:?}/,/^}/d" > "${CUR_TEMP_FILE:?}"

cat "${PROC_FILE:?}.tmp" | \
sed -e "/set_module_property BONUS_DATA/,/^\t}/ s/\t\(.*$\)/\\1/" > "${PROC_FILE:?}"


echo "Created proc file: ${PROC_FILE:?}"
echo "Created next temp file: ${CUR_TEMP_FILE:?}"

LAST_TEMP_FILE="${CUR_TEMP_FILE:?}"
((TEMP_COUNTER++))
CUR_TEMP_FILE="${1:?}_${TEMP_COUNTER:?}"

done

