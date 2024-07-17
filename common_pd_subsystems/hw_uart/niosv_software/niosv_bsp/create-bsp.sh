#!/bin/bash -x
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

niosv-bsp \
  settings.bsp \
  --create \
  --cpu-instance=niosv_c \
  --type=hal \
  --qsys=../../uart.qsys \
  --quartus-project=../../no_pins_top.qpf \
  --script=create_bsp.tcl

