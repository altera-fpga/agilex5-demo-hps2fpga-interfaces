#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# verify that the tools we need are available in the environment
TOOLS_REQUIRED="
quartus_sh \
qsys-script \
qsys-generate
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

# check if an SOF already exists
[ -f ./output_files/no_pins_top.sof ] && {
	echo "INFO: SOF file already exists"
	exit 0
}

# build the hardware
(
ln -s ../hw_base/custom_ip.ipx . && \
quartus_sh --script=../hw_base/create_quartus_project.tcl && \
qsys-script --quartus-project=no_pins_top --script=create_pd_sys.tcl && \
qsys-script --qpf=none --script=../../scripts/update_sysid.tcl --system-file=f2sdram_bridge.qsys && \
qsys-script --qpf=none --script=../../scripts/sync_sysid.tcl --system-file=f2sdram_bridge.qsys && \
qsys-generate --quartus-project=no_pins_top no_pins_pd_top.qsys --synthesis=VERILOG && \
quartus_sh --flow compile no_pins_top && \
echo Build flow completed successfully... || \
echo Build flow encountered errors...
) > build_hw.log 2>&1

