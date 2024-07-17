#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# verify that the tools we need are available in the environment
TOOLS_REQUIRED="
sed
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

# create the attribution u-boot script
ATTRIB_FILE="attribution.txt"
ATTRIB_SCRIPT="attribution.script"

cat << EOF > ${ATTRIB_FILE:?}


This project is licensed under the MIT-0 license.
Please see the full license text below.

EOF

[ -f ../../ACKNOWLEDGEMENTS ] \
	|| { echo "ERROR" ; exit 1 ; }
cat ../../ACKNOWLEDGEMENTS >> ${ATTRIB_FILE:?}


cat << EOF >> ${ATTRIB_FILE:?}

--------------------------------------------------------------------------------
  The main license from this project.
--------------------------------------------------------------------------------
  --------------------------------------------------
    FILE: ./LICENSE
  --------------------------------------------------
EOF

[ -f ../../LICENSE ] \
	|| { echo "ERROR" ; exit 1 ; }
cat ../../LICENSE >> ${ATTRIB_FILE:?}

cat << EOF >> ${ATTRIB_FILE:?}

--------------------------------------------------------------------------------
  The main license from the arm-trusted-firmware project.
  Please refer to the project source for additional license details.
--------------------------------------------------------------------------------
  --------------------------------------------------
    FILE: ./docs/license.rst
  --------------------------------------------------
EOF

[ -f ../sw_builds/arm-trusted-firmware/docs/license.rst ] \
	|| { echo "ERROR" ; exit 1 ; }
cat ../sw_builds/arm-trusted-firmware/docs/license.rst >> ${ATTRIB_FILE:?}

cat << EOF >> ${ATTRIB_FILE:?}

--------------------------------------------------------------------------------
  The main license from the u-boot-socfpga project.
  Please refer to the project source for additional license details.
--------------------------------------------------------------------------------
  --------------------------------------------------
    FILE: ./Licenses/README
  --------------------------------------------------
EOF

[ -f ../sw_builds/u-boot-socfpga/Licenses/README ] \
	|| { echo "ERROR" ; exit 1 ; }
cat ../sw_builds/u-boot-socfpga/Licenses/README >> ${ATTRIB_FILE:?}

cat << EOF >> ${ATTRIB_FILE:?}

--------------------------------------------------------------------------------
  The main license from the linux-socfpga project.
  Please refer to the project source for additional license details.
--------------------------------------------------------------------------------
  --------------------------------------------------
    FILE: ./COPYING
  --------------------------------------------------
EOF

[ -f ../sw_builds/linux-socfpga/COPYING ] \
	|| { echo "ERROR" ; exit 1 ; }
cat ../sw_builds/linux-socfpga/COPYING >> ${ATTRIB_FILE:?}

cat << EOF >> ${ATTRIB_FILE:?}

  --------------------------------------------------
    FILE: ./LICENSES/preferred/GPL-2.0
  --------------------------------------------------
EOF

[ -f ../sw_builds/linux-socfpga/LICENSES/preferred/GPL-2.0 ] \
	|| { echo "ERROR" ; exit 1 ; }
cat ../sw_builds/linux-socfpga/LICENSES/preferred/GPL-2.0 >> ${ATTRIB_FILE:?}

cat << EOF >> ${ATTRIB_FILE:?}

  --------------------------------------------------
    FILE: ./LICENSES/exceptions/Linux-syscall-note
  --------------------------------------------------
EOF

[ -f ../sw_builds/linux-socfpga/LICENSES/exceptions/Linux-syscall-note ] \
	|| { echo "ERROR" ; exit 1 ; }
cat ../sw_builds/linux-socfpga/LICENSES/exceptions/Linux-syscall-note >> ${ATTRIB_FILE:?}

cat << EOF >> ${ATTRIB_FILE:?}

--------------------------------------------------------------------------------
  The main license from the toybox project.
  Please refer to the project source for additional license details.
--------------------------------------------------------------------------------
  --------------------------------------------------
    FILE: ./LICENSE
  --------------------------------------------------
EOF

[ -f ../sw_builds/toybox/LICENSE ] \
	|| { echo "ERROR" ; exit 1 ; }
cat ../sw_builds/toybox/LICENSE >> ${ATTRIB_FILE:?}

cat << EOF >> ${ATTRIB_FILE:?}


EOF

cat ${ATTRIB_FILE:?} | \
sed \
	-e "s/\f/\n/g" \
	-e "s/\([[:punct:]]\)/\\\\\1/g" \
	-e "s/ /\\\ /g" \
	-e "s/\t/\\\\\t/g" \
	| \
sed -e "s/\(^.*$\)/echo \1/" > ${ATTRIB_SCRIPT:?}
