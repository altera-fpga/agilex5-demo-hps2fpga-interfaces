#
# SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
# SPDX-License-Identifier: MIT-0
#

# Remove existing memory regions and section mappings
foreach region_info [get_current_memory_regions] {
    delete_memory_region [lindex $region_info 0]
}

foreach mapping_info [get_current_section_mappings] {
    delete_section_mapping [lindex $mapping_info 0]
}

# Settings
set_setting hal.dfl_start_address {-1}
set_setting hal.enable_c_plus_plus {false}
set_setting hal.enable_clean_exit {false}
set_setting hal.enable_exit {false}
set_setting hal.enable_instruction_related_exceptions_api {false}
set_setting hal.enable_lightweight_device_driver_api {true}
set_setting hal.enable_reduced_device_drivers {false}
set_setting hal.enable_runtime_stack_checking {false}
set_setting hal.enable_sim_optimize {false}
set_setting hal.linker.allow_code_at_reset {true}
set_setting hal.linker.enable_alt_load {true}
set_setting hal.linker.enable_alt_load_copy_exceptions {false}
set_setting hal.linker.enable_alt_load_copy_rodata {true}
set_setting hal.linker.enable_alt_load_copy_rwdata {true}
set_setting hal.linker.enable_exception_stack {false}
set_setting hal.linker.exception_stack_memory_region_name {none}
set_setting hal.linker.exception_stack_size {1024}
set_setting hal.linker.use_picolibc {false}
set_setting hal.log_flags {0}
set_setting hal.log_port {none}
set_setting hal.make.asflags {-Wa,-gdwarf2}
set_setting hal.make.cflags_debug {-g}
set_setting hal.make.cflags_defined_symbols {none}
set_setting hal.make.cflags_optimization {-O2}
set_setting hal.make.cflags_undefined_symbols {none}
set_setting hal.make.cflags_user_flags {none}
set_setting hal.make.cflags_warnings {-Wall -Wformat-security}
set_setting hal.make.cxx_flags {none}
set_setting hal.make.enable_cflag_fstack_protector_strong {true}
set_setting hal.make.enable_cflag_wformat_security {true}
set_setting hal.make.link_flags {none}
set_setting hal.make.objdump_flags {-Sdtx}
set_setting hal.max_file_descriptors {32}
set_setting hal.stderr {none}
set_setting hal.stdin {none}
set_setting hal.stdout {none}
set_setting hal.sys_clk_timer {none}
set_setting hal.timestamp_timer {none}
set_setting hal.toolchain.ar {riscv32-unknown-elf-ar}
set_setting hal.toolchain.as {riscv32-unknown-elf-gcc}
set_setting hal.toolchain.cc {riscv32-unknown-elf-gcc}
set_setting hal.toolchain.cxx {riscv32-unknown-elf-g++}
set_setting hal.toolchain.enable_executable_overrides {false}
set_setting hal.toolchain.objdump {riscv32-unknown-elf-objdump}
set_setting hal.toolchain.prefix {riscv32-unknown-elf-}
set_setting hal.use_dfl_walker {false}
set_setting intel_lw_uart.enable_ioctl {false}
set_setting intel_lw_uart.enable_small_driver {true}
set_setting intel_lw_uart.rx_timeout_cycle {-1}
set_setting intel_lw_uart.rx_timeout_us {10}
set_setting intel_lw_uart.tx_timeout_cycle {-1}
set_setting intel_lw_uart.tx_timeout_us {10}

# Software packages

# Drivers
set_driver intel_lw_uart lw_uart
set_driver intel_niosv_c_hal_driver niosv_c

# User devices

# Linker memory regions
add_memory_region reset ocram_8k 0 32
add_memory_region ocram_8k ocram_8k 32 8160

# Linker section mappings
add_section_mapping .text ocram_8k
add_section_mapping .exceptions ocram_8k
add_section_mapping .rodata ocram_8k
add_section_mapping .rwdata ocram_8k
add_section_mapping .bss ocram_8k
add_section_mapping .heap ocram_8k
add_section_mapping .stack ocram_8k
