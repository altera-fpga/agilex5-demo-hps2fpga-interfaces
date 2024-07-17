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
# if destination directory already exists, remove it
#
DEST_DIR="../toybox/install/sw_images"
[ -d "${DEST_DIR:?}" ] && {
	echo "INFO: deleting destination directory"
	echo "'${DEST_DIR:?}'"
	rm -rf "${DEST_DIR:?}"
}

#
# create destination directory
#
mkdir "${DEST_DIR:?}" || {
	echo "ERROR: cannot create destination directory"
	echo "'${DEST_DIR:?}'"
	exit 1
}

#
# copy all software applications
#
SW_APPS="
armv8_regs
boot_app
config_clk
f2h_bridge
f2h_irq
f2h_irq_handler
f2sdram_bridge
h2f_bridge
h2f_bridge_def_sub
h2f_user_clk
hps_gp
i2c_bridge
i2c_bridge_drvr
lwh2f_bridge
lwh2f_bridge_def_sub
spi_bridge
spi_bridge_drvr
system_counter
uart
uart_drvr
waitforonechar
"

for NEXT in ${SW_APPS:?}
do
	cp "./${NEXT:?}" \
		"${DEST_DIR:?}/${NEXT:?}" \
		|| { echo "ERROR" ; exit 1 ; }
done

echo "INFO: completed installing software objects into toybox rootfs"

