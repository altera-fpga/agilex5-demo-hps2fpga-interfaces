#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2025 Intel Corporation
# SPDX-FileCopyrightText: Copyright (C) 2026 Altera Corporation
# SPDX-License-Identifier: MIT-0
#

# change into the directory of this script
cd "$(dirname "$0")" || exit 1

# use the HPS RBF from the hw_a55_no_periph project as the reference hash value
HPS_RBF="merged_hps.hps.rbf"
REFERENCE_FILE="./hw_a55_no_periph/${HPS_RBF:?}"

# extract the expected hash value from the reference file
# grab the last field on the line starting with "HPS IO hash"
EXPECTED_HASH=$(quartus_pfg -i "${REFERENCE_FILE:?}" 2>/dev/null | awk -F': ' '/HPS IO hash/ {print $2}')

if [ -z "$EXPECTED_HASH" ]; then
	echo "ERROR: Could not retrieve expected hash from ${REFERENCE_FILE:?}"
	exit 1
fi

echo "Expected Hash: $EXPECTED_HASH"
echo "----------------------------------------------------"

# compare reference hash to all HPS RBF files in all subdirectories
find . -mindepth 2 -name "${HPS_RBF:?}" -type f | while read -r FILE; do

	# Extract the hash from the current file
	CURRENT_LINE=$(quartus_pfg -i "$FILE" 2>/dev/null | grep "HPS IO hash")
	CURRENT_HASH=$(echo "$CURRENT_LINE" | awk -F': ' '{print $2}')

	if [ -z "$CURRENT_LINE" ]; then
		echo "ERROR: [ $FILE ] - 'HPS IO hash' line not found."
	elif [ "$CURRENT_HASH" != "$EXPECTED_HASH" ]; then
		echo "ERROR: [ $FILE ] - Hash mismatch!"
		echo "       Found: $CURRENT_HASH"
	else
		echo "SUCCESS: [ $FILE ] - Hash matches."
	fi
done

