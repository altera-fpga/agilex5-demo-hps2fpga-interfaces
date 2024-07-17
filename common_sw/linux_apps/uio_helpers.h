/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

struct uio_map_s {
	char	*uio_name;
	int	uio_index;
	void	*uio_mmap_addr;
	size_t	uio_length;
	int	uio_prot;
	int	uio_flags;
	int	uio_fd;
	off_t	uio_offset;
};

extern int find_uio_index(struct uio_map_s *uio_map);
extern int mmap_uio(struct uio_map_s *uio_map);
extern int open_only_uio(struct uio_map_s *uio_map);
extern int munmap_uio(struct uio_map_s *uio_map);

