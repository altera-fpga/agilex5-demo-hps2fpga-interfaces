#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

niosv-app \
  --app-dir=. \
  --bsp-dir=../niosv_bsp \
  --srcs=main.c \
  --elf-name=main.elf
