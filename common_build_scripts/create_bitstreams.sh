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

# source the hardware build directories variable declaration
. ./hw_build_dirs.src

RPD_DIRECTORIES="
./hw_a55_no_periph \
./hw_a76_no_periph
"

for NEXT_BUILD_DIR in ${HW_BUILD_DIRECTORIES:?}
do
        echo "Creating RBF bitstream in directory: '${NEXT_BUILD_DIR:?}'"

	if [ ! -f ./${NEXT_BUILD_DIR:?}/output_files/no_pins_top.sof ]
	then
		echo "initial SOF file does not exist..."
		continue
	fi

	if [ ! -f ./sw_builds/u-boot-socfpga/spl/u-boot-spl-dtb.hex ]
	then
		echo "HEX file does not exist..."
		continue
	fi

	if [ -f ./${NEXT_BUILD_DIR:?}/merged_hps.core.rbf ]
	then
		echo "core RBF file already exist..."
		continue
	fi

	quartus_pfg -c \
		./${NEXT_BUILD_DIR:?}/output_files/no_pins_top.sof \
		./${NEXT_BUILD_DIR:?}/merged_hps.sof \
		-o hps_path=./sw_builds/u-boot-socfpga/spl/u-boot-spl-dtb.hex \
		> /dev/null \
		|| { echo "ERROR" ; exit 1 ; }

	if [ ! -f ./${NEXT_BUILD_DIR:?}/merged_hps.sof ]
	then
		echo "merged SOF file does not exist..."
		continue
	fi

	quartus_pfg -c \
		./${NEXT_BUILD_DIR:?}/merged_hps.sof \
		./${NEXT_BUILD_DIR:?}/merged_hps.rbf \
		-o hps=on \
		> /dev/null \
		|| { echo "ERROR" ; exit 1 ; }

        echo "RBF bitstream generation complete..."
done

for NEXT_BUILD_DIR in ${RPD_DIRECTORIES:?}
do
        echo "Creating RPD bitstream in directory: '${NEXT_BUILD_DIR:?}'"

	if [ -f ./${NEXT_BUILD_DIR:?}/merged_hps.rpd ]
	then
		echo "RPD file already exist..."
		continue
	fi

	if [ ! -f ./${NEXT_BUILD_DIR:?}/merged_hps.sof ]
	then
		echo "merged SOF file does not exist..."
		continue
	fi

	quartus_pfg -c \
		./${NEXT_BUILD_DIR:?}/merged_hps.sof \
		./${NEXT_BUILD_DIR:?}/merged_hps.jic \
		./${NEXT_BUILD_DIR:?}/merged_hps.rpd  \
		-o hps=on \
		-o mode=ASX4 \
		-o flash_loader=A5ED065BB32AE4SR0 \
		-o device=MT25QU256 \
		-o bitswap=on \
		> /dev/null \
		|| { echo "ERROR" ; exit 1 ; }

        echo "RPD bitstream generation complete..."
done

