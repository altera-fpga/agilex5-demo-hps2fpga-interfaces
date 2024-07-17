#****************************************************************************
#
# SPDX-License-Identifier: MIT-0
# SPDX-FileCopyrightText: Copyright(c) 2023-2024 Intel Corporation.
#
#****************************************************************************
#
# This script synchronizes the SYSID from the .ip file into the .qsys system.
#
# To execute this script using qsys-script first run the update script:
#   qsys-script --qpf=none --script=update_sysid.tcl --system-file=<QSYS FILE>
#
# Then run this script:
#   qsys-script --qpf=none --script=sync_sysid.tcl --system-file=<QSYS FILE>
#
#****************************************************************************
package require -exact qsys 23.1

sync_sysinfo_parameters
save_system

