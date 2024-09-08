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
DEST_DIR="../toybox/install/lib/firmware"
[ -d "${DEST_DIR:?}" ] && {
	echo "INFO: deleting destination directory"
	echo "'${DEST_DIR:?}'"
	rm -rf "${DEST_DIR:?}"
}

#
# create destination directory
#
mkdir -p "${DEST_DIR:?}" || {
	echo "ERROR: cannot create destination directory"
	echo "'${DEST_DIR:?}'"
	exit 1
}

#
# copy hw_no_periph RBF by itself since it does not match the pattern rules
#
cp ../../hw_a55_no_periph/merged_hps.core.rbf "${DEST_DIR:?}/hw_no_periph.rbf" \
	|| { echo "ERROR" ; exit 1 ; }

#
# copy all other RBFs that match pattern rules
#
RBF_DIRS="
hw_config_clk
hw_emac
hw_f2h_bridge
hw_f2h_irq
hw_f2sdram_bridge
hw_h2f_bridge
hw_h2f_user_clk
hw_hps_gp
hw_hps_jamb
hw_i2c_bridge
hw_lwh2f_bridge
hw_spi_bridge
hw_uart
"

for NEXT in ${RBF_DIRS:?}
do
	cp "../../${NEXT:?}/merged_hps.core.rbf" \
		"${DEST_DIR:?}/${NEXT:?}.rbf" \
		|| { echo "ERROR" ; exit 1 ; }
done

#
# copy all RPDs that match pattern rules
#
RPD_DIRS="
a55
a76
"

for NEXT in ${RPD_DIRS:?}
do
	cp "../../hw_${NEXT:?}_no_periph/merged_hps.rpd" \
		"${DEST_DIR:?}/${NEXT:?}.rpd" \
		|| { echo "ERROR" ; exit 1 ; }
done

#
# build DTBOs
#
THE_DTC=$(realpath ../u-boot-socfpga/scripts/dtc/dtc) make -C ../../../common_sw/devicetree_overlays

#
# copy DTBOs
#
cp ../../../common_sw/devicetree_overlays/*.dtbo \
	"${DEST_DIR:?}/" \
	|| { echo "ERROR" ; exit 1 ; }

#
# duplicate the uart DTBO
#
COPIED_UART_DTBO=0

[ "$(basename $(dirname $(dirname $(pwd))))" == "brd_altera_a5e065_premium_es" ] && {
	cp "${DEST_DIR:?}/hw_uart1_drvr.dtbo" "${DEST_DIR:?}/hw_uart_drvr.dtbo" \
		|| { echo "ERROR" ; exit 1 ; }
	COPIED_UART_DTBO=1
}

[ "$(basename $(dirname $(dirname $(pwd))))" == "brd_arrow_axe5_eagle_es" ] && {
	cp "${DEST_DIR:?}/hw_uart1_drvr.dtbo" "${DEST_DIR:?}/hw_uart_drvr.dtbo" \
		|| { echo "ERROR" ; exit 1 ; }
	COPIED_UART_DTBO=1
}

[ "$(basename $(dirname $(dirname $(pwd))))" == "brd_criticallink_mitysbc_es" ] && {
	cp "${DEST_DIR:?}/hw_uart0_drvr.dtbo" "${DEST_DIR:?}/hw_uart_drvr.dtbo" \
		|| { echo "ERROR" ; exit 1 ; }
	COPIED_UART_DTBO=1
}

[ "$(basename $(dirname $(dirname $(pwd))))" == "brd_macnica_sulfur_es_125" ] && {
	cp "${DEST_DIR:?}/hw_uart1_drvr.dtbo" "${DEST_DIR:?}/hw_uart_drvr.dtbo" \
		|| { echo "ERROR" ; exit 1 ; }
	COPIED_UART_DTBO=1
}

[ "$(basename $(dirname $(dirname $(pwd))))" == "brd_macnica_sulfur_es_25" ] && {
	cp "${DEST_DIR:?}/hw_uart1_drvr.dtbo" "${DEST_DIR:?}/hw_uart_drvr.dtbo" \
		|| { echo "ERROR" ; exit 1 ; }
	COPIED_UART_DTBO=1
}

[ ${COPIED_UART_DTBO:?} -eq 1 ] || { echo "ERROR" ; exit 1 ; }

echo "INFO: completed installing hardware objects into toybox rootfs"

