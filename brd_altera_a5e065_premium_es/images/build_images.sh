#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# change into the directory of this script
cd $(dirname ${0})

IMAGE_BUILD_SCRIPTS="
../../common_images/build_demos_fit_image.sh
../../common_images/build_jic_image.sh
../../common_images/create_attribution.sh
../../common_images/fit_no-pins-demos.its
../../common_images/fit_lzma-no-pins-demos.its
../../common_images/jic_no-pins-demos.pfg
"

for NEXT in ${IMAGE_BUILD_SCRIPTS:?}
do
	[ -f "$(basename "${NEXT:?}")" ] || {
		cp -s -t ./ "${NEXT:?}" || { echo "ERROR" ; exit 1 ; }
		echo "Created symbolic link for '$(basename ${NEXT:?})'"
	}
done

./build_jic_image.sh || { echo "ERROR" ; exit 1 ; }

