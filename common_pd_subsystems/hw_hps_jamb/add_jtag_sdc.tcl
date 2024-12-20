#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

package require ::quartus::project

set PROJECT_NAME "no_pins_top"
if ![project_exists $PROJECT_NAME] {
        post_message -type error "project does not exist..."
        post_message -type error "'$PROJECT_NAME'"
        qexit -error
}
project_open $PROJECT_NAME

set_global_assignment -name SDC_FILE jtag.sdc

export_assignments

project_close

