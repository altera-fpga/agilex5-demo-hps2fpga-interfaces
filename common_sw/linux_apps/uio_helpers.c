/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "uio_helpers.h"

/*
	- this function attempts munmap and close a UIO device with
	  uio_map->uio_mmap_addr and uio_map->uio_length and uio_map->uio_fd
	- returns 0 on success, otherwise non-zero
 */
int munmap_uio(struct uio_map_s *uio_map) {
	int result;
	result = munmap(uio_map->uio_mmap_addr, uio_map->uio_length);
	if(result != 0) {
		result = close(uio_map->uio_fd);
		if(result != 0) {
			return 2;
		}
		return 1;
	}
	result = close(uio_map->uio_fd);
	if(result != 0) {
		return 3;
	}
	return 0;
}

/*
	- this function attempts open and mmap a UIO device with the index
	  passed in through uio_map->uio_index
	- all the mmap attributes are passed in through the uio_map struct
	- only mmap's one UIO memory region specified by uio_map->uio_offset
	- returns 0 on success, otherwise non-zero
 */
int mmap_uio(struct uio_map_s *uio_map) {

	int the_fd;
	char uio_path[32];

	snprintf(uio_path, 32, "/dev/uio%d", uio_map->uio_index);
	the_fd = open(uio_path, O_RDWR | O_SYNC);
	if(the_fd < 0)
		return 1;
	uio_map->uio_fd = the_fd;
	uio_map->uio_mmap_addr = mmap(NULL,
					uio_map->uio_length,
					uio_map->uio_prot,
					uio_map->uio_flags,
					uio_map->uio_fd,
					uio_map->uio_offset);
	if(uio_map->uio_mmap_addr == MAP_FAILED)
		return 2;
	return 0;
}

/*
	- this function attempts open ONLY a UIO device with the index
	  passed in through uio_map->uio_index
	- returns 0 on success, otherwise non-zero
 */
int open_only_uio(struct uio_map_s *uio_map) {

	int the_fd;
	char uio_path[32];

	snprintf(uio_path, 32, "/dev/uio%d", uio_map->uio_index);
	the_fd = open(uio_path, O_RDWR | O_SYNC);
	if(the_fd < 0)
		return 1;
	uio_map->uio_fd = the_fd;
	return 0;
}

/*
	- this function attempts to locate a UIO device by name
	- it searches for the name passed in by uio_map->uio_name
	- if located it returns the UIO index in uio_map->uio_index
	- returns 0 on success, otherwise non-zero
 */
int find_uio_index(struct uio_map_s *uio_map) {

	int i;
	int the_fd;
	int result;
	char uio_name_path[32];
	char uio_name[32];

	result = strnlen(uio_map->uio_name, 32);
	if(result == 0)
		return 1;

	for(i = 0 ; i < (64 + 10) ; i++) {
		snprintf(uio_name_path, 32, "/sys/class/uio/uio%d/name", i);
		the_fd = open(uio_name_path, O_RDONLY | O_SYNC);
		if(the_fd < 0) {
			continue;
		}
		memset(uio_name, 0, 32);
		result = read(the_fd, uio_name, 32);
		if(close(the_fd) != 0) {
			puts("ERROR: find_uio_index close the_fd");
			exit(EXIT_FAILURE);
		}
		if(result < 0) {
			continue;
		}
		result = strnlen(uio_name, 32);
		if((result == 32) || (result == 0)) {
			continue;
		}
		uio_name[result - 1] = '\0';
		result = strncmp(uio_map->uio_name,uio_name, 32);
		if(result != 0) {
			continue;
		}
		else {
			uio_map->uio_index = i;
			return 0;
		}
	}
	return 2;
}

