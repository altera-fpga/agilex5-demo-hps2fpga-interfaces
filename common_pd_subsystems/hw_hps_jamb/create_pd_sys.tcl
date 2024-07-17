#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#
package require -exact qsys 23.4

# create the system "no_pins_pd_top"
source ./do_create_no_pins_pd_top.tcl

# create the system "hps_jamb"
source ../../common_pd_subsystems/do_create_hps_jamb.tcl

# create the system "no_pins_hps"
source ../hw_base/a55_do_create_no_pins_hps.tcl

# create all the systems, from bottom up
do_create_no_pins_hps
reload_ip_catalog
do_create_hps_jamb
reload_ip_catalog
do_create_no_pins_pd_top

