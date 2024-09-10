/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include "linux_help_text.h"
#include "standalone_common.h"

struct menu_s {
	char *select_letter;
	char *display_name;
	char *sw_name;
	char *sc_name;
	char *hw_name;
	char help_text_1[1024];
	char help_text_2[1024];
};

void help_menu(struct menu_s *);

int main(void)
{
	int i;
	int the_fd;
	int the_len;
	int result;
	int column;
	char c;
	char *env_ptr;
	uint64_t cntvct_el0;
	uint64_t cntfrq_el0;
	uint32_t jtag_usercode;
	uint64_t uboot_exit_ts;
	uint64_t linux_entry_ts;
	uint64_t midr_el1;
	uint64_t cntvct_copy;
	uint64_t days;
	uint64_t hours;
	uint64_t minutes;
	uint64_t seconds;
	uint64_t milliseconds;
	uint64_t microseconds;
	uint64_t nanoseconds;
	uint64_t delta;
	uint64_t ns_time;
	uint64_t ps_time;
	struct termios orig_attr;
	struct termios new_attr;
	struct menu_s menus[] = {
		{
			/* menu selection letter */
			"",
			/* display name */
			"%5s%s%s",
			/* software name */
			" ",
			/* script name */
			"Linux Application Menu",
			/* hardware name */
			"",
			/* help text */
			"",
			""
		},
		{
			/* menu selection letter */
			"",
			/* display name */
			"%s%s%80s",
			/* software name */
			"",
			/* script name */
			"",
			/* hardware name */
"------------------------------------------------------------------| Help |----",
			/* help text */
			"",
			""
		},
		{
			/* menu selection letter */
			"",
			/* display name */
			" %-1.1s - %-34.34s%s",
			/* software name */
			"H",
			/* script name */
			"help menu",
			/* hardware name */
			"",
			/* help text */
			"",
			""
		},
		{
			/* menu selection letter */
			"",
			/* display name */
			"%s%s%80s",
			/* software name */
			"",
			/* script name */
			"",
			/* hardware name */
"------------------------------------------------| Software Only Examples |----",
			/* help text */
			"",
			""
		},
		{
			/* menu selection letter */
			"s",
			/* display name */
			"system counter",
			/* software name */
			"system_counter",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			linux_s_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"a",
			/* display name */
			"armv8 registers",
			/* software name */
			"armv8_regs",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			linux_a_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"v",
			/* display name */
			"read volt/temp sensors",
			/* software name */
			"boot_app",
			/* script name */
			"read_sensors",
			/* hardware name */
			"",
			/* help text */
			linux_v_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"",
			/* display name */
			"%s%s%80s",
			/* software name */
			"",
			/* script name */
			"",
			/* hardware name */
"-----------------------------------------------------| Hardware Examples |----",
			/* help text */
			"",
			""
		},
		{
			/* menu selection letter */
			"g",
			/* display name */
			"hps gp demo",
			/* software name */
			"hps_gp",
			/* script name */
			"",
			/* hardware name */
			"hw_hps_gp",
			/* help text */
			linux_g_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"i",
			/* display name */
			"f2h irq demo",
			/* software name */
			"f2h_irq",
			/* script name */
			"",
			/* hardware name */
			"hw_f2h_irq",
			/* help text */
			linux_i_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"l",
			/* display name */
			"f2h irq handler demo",
			/* software name */
			"f2h_irq_handler",
			/* script name */
			"",
			/* hardware name */
			"hw_f2h_irq",
			/* help text */
			linux_l_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"z",
			/* display name */
			"config clock demo",
			/* software name */
			"config_clk",
			/* script name */
			"",
			/* hardware name */
			"hw_config_clk",
			/* help text */
			linux_z_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"y",
			/* display name */
			"h2f user clock demo",
			/* software name */
			"h2f_user_clk",
			/* script name */
			"",
			/* hardware name */
			"hw_h2f_user_clk",
			/* help text */
			linux_y_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"x",
			/* display name */
			"lwh2f bridge demo",
			/* software name */
			"lwh2f_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_lwh2f_bridge",
			/* help text */
			linux_x_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"w",
			/* display name */
			"lwh2f bridge default subordinate",
			/* software name */
			"lwh2f_bridge_def_sub",
			/* script name */
			"",
			/* hardware name */
			"hw_lwh2f_bridge",
			/* help text */
			linux_w_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"t",
			/* display name */
			"h2f bridge",
			/* software name */
			"h2f_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_h2f_bridge",
			/* help text */
			linux_t_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"r",
			/* display name */
			"h2f bridge default subordinate",
			/* software name */
			"h2f_bridge_def_sub",
			/* script name */
			"",
			/* hardware name */
			"hw_h2f_bridge",
			/* help text */
			linux_r_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"p",
			/* display name */
			"f2sdram bridge",
			/* software name */
			"f2sdram_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_f2sdram_bridge",
			/* help text */
			linux_p_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"b",
			/* display name */
			"f2h bridge",
			/* software name */
			"f2h_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_f2h_bridge",
			/* help text */
			linux_b_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"k",
			/* display name */
			"hps uart - uio driver",
			/* software name */
			"uart",
			/* script name */
			"",
			/* hardware name */
			"hw_uart",
			/* help text */
			linux_k_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"K",
			/* display name */
			"hps uart - linux driver",
			/* software name */
			"uart_drvr",
			/* script name */
			"",
			/* hardware name */
			"hw_uart_drvr",
			/* help text */
			linux_K_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"f",
			/* display name */
			"hps spi bridge - uio driver",
			/* software name */
			"spi_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_spi_bridge",
			/* help text */
			linux_f_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"F",
			/* display name */
			"hps spi bridge - linux driver",
			/* software name */
			"spi_bridge_drvr",
			/* script name */
			"",
			/* hardware name */
			"hw_spi_bridge_drvr",
			/* help text */
			linux_F_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"e",
			/* display name */
			"hps i2c bridge - uio driver",
			/* software name */
			"i2c_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_i2c_bridge",
			/* help text */
			linux_e_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"E",
			/* display name */
			"hps i2c bridge - linux driver",
			/* software name */
			"i2c_bridge_drvr",
			/* script name */
			"",
			/* hardware name */
			"hw_i2c_bridge_drvr",
			/* help text */
			linux_E_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"T",
			/* display name */
			"hps emac - uio driver",
			/* software name */
			"emac",
			/* script name */
			"",
			/* hardware name */
			"hw_emac",
			/* help text */
			linux_T_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"",
			/* display name */
			"%s%s%80s",
			/* software name */
			"",
			/* script name */
			"",
			/* hardware name */
"---------------------------------------------------| Maintenance Options |----",
			/* help text */
			"",
			""
		},
		{
			/* menu selection letter */
			"c",
			/* display name */
			"exit to linux console",
			/* software name */
			"",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			linux_c_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"m",
			/* display name */
			"display menu",
			/* software name */
			"boot_app",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			linux_m_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"5",
			/* display name */
			"program a55 rpd image into flash",
			/* software name */
			"boot_app",
			/* script name */
			"prog-a55-rpd",
			/* hardware name */
			"",
			/* help text */
			linux_m5_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"7",
			/* display name */
			"program a76 rpd image into flash",
			/* software name */
			"boot_app",
			/* script name */
			"prog-a76-rpd",
			/* hardware name */
			"",
			/* help text */
			linux_m7_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"n",
			/* display name */
			"load no-peripheral FPGA image",
			/* software name */
			"boot_app",
			/* script name */
			"",
			/* hardware name */
			"hw_no_periph",
			/* help text */
			linux_n_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"j",
			/* display name */
			"load jamb FPGA image",
			/* software name */
			"boot_app",
			/* script name */
			"",
			/* hardware name */
			"hw_hps_jamb",
			/* help text */
			linux_j_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"R",
			/* display name */
			"reboot HPS",
			/* software name */
			"",
			/* script name */
			"reboot",
			/* hardware name */
			"",
			/* help text */
			linux_R_menu_HELP_TEXT,
			""
		},
		{
			/* menu selection letter */
			"P",
			/* display name */
			"poweroff HPS",
			/* software name */
			"",
			/* script name */
			"poweroff",
			/* hardware name */
			"",
			/* help text */
			linux_P_menu_HELP_TEXT,
			""
		},
		{
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			{0},
			{0}
		},
	};

menu_loop:
	asm volatile (
		"mrs %[cntvct_el0], cntvct_el0\n"
		: [cntvct_el0] "=r" (cntvct_el0)
	);

	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	env_ptr = getenv("JTAG_USERCODE");
	if(env_ptr == NULL)
		jtag_usercode = 0;
	else
		jtag_usercode  = strtoul(env_ptr, NULL, 0);

	env_ptr = getenv("LINUX_ENTRY_TS");
	if(env_ptr == NULL)
		linux_entry_ts = 0;
	else
		linux_entry_ts  = strtoull(env_ptr, NULL, 0);

	env_ptr = getenv("UBOOT_EXIT_TS");
	if(env_ptr == NULL)
		uboot_exit_ts = 0;
	else
		uboot_exit_ts  = strtoull(env_ptr, NULL, 0);

	puts("");
	puts("");

	printf("%26.26s", "Running on board: ");
	switch(jtag_usercode) {
		case(USERCODE_ARROWAXE5):
			puts("Arrow AXE5-Eagle");
			break;
		case(USERCODE_CLMITYSBC):
			puts("Critical Link MitySBC-A5E");
			break;
		case(USERCODE_ALTERAPREM):
			puts("Altera Premium Dev Kit");
			break;
		case(USERCODE_MACNICASULFUR):
			puts("Macnica Sulfur");
			break;
		default:
			puts("UNKNOWN JTAG USERCODE");
	}

	cntvct_copy = cntvct_el0;
	seconds = cntvct_copy / cntfrq_el0;
	days = seconds / (60 * 60 * 24);
	seconds = seconds % (60 * 60 * 24);
	hours = seconds / (60 * 60);
	seconds = seconds % (60 * 60);
	minutes = seconds / 60;
	seconds = seconds % 60;
	cntvct_copy %= cntfrq_el0;
	cntvct_copy *= 1000;
	milliseconds = cntvct_copy / cntfrq_el0;
	cntvct_copy %= cntfrq_el0;
	cntvct_copy *= 1000;
	microseconds = cntvct_copy / cntfrq_el0;
	cntvct_copy %= cntfrq_el0;
	cntvct_copy *= 1000;
	nanoseconds = cntvct_copy / cntfrq_el0;
	printf("%26.26s", "Uptime: ");
	printf("%04ldd'%02ldh'%02ldm'%02lds'%03ldms'%03ldus'%03ldns\n",
	days, hours, minutes, seconds, milliseconds, microseconds, nanoseconds);

	asm volatile (
		"mrs %[midr_el1], midr_el1\n"
		: [midr_el1] "=r" (midr_el1)
	);

	printf("%26.26s", "Core type: ");
	if (((midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A55_VAL)
		printf("Cortex A55 ");
	else if (((midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A76_VAL)
		printf("Cortex A76 ");
	else
		printf("UNKNOWN ");

	printf("r%ldp%ld core\n",
		(midr_el1 & MIDR_EL1_VAR_MASK) >> MIDR_EL1_VAR_OFST,
		(midr_el1 & MIDR_EL1_REV_MASK) >> MIDR_EL1_REV_OFST);

	printf("%26.26s", "Last Linux Boot Time: ");
	if(linux_entry_ts > uboot_exit_ts) {
		delta = linux_entry_ts - uboot_exit_ts;
		ns_time = delta * 1000000000 / cntfrq_el0;
		ps_time = delta * 1000000000 % cntfrq_el0;
		ps_time *= 1000;
		ps_time /= cntfrq_el0;
		printf("%ld.%03ld ns\n", ns_time, ps_time);
	} else {
		puts("UNKNOWN");
	}

	puts("");

	i = 0;
	column = 0;
	while(menus[i].select_letter != NULL) {
		if(menus[i].select_letter[0] != '\0') {
			printf(" %-1.1s - %-34.34s",
				menus[i].select_letter,
				menus[i].display_name);

			if(column == 1)
				puts("");

			column++;
			column %= 2;
		} else {
			if(column == 1)
				puts("");

			printf(menus[i].display_name,
				menus[i].sw_name,
				menus[i].sc_name,
				menus[i].hw_name);

			puts("");
			column = 0;
		}
		i++;
	}

	if(column == 1)
		puts("");

	puts("");
	printf ("Enter menu selection:");
	fflush(stdout);

	/* adjust termios so we see each character input and no echo */
	tcgetattr(STDIN_FILENO, &orig_attr);
	new_attr = orig_attr;
	new_attr.c_lflag &= ~(ICANON | ECHO);
	tcsetattr(STDIN_FILENO, TCSANOW, &new_attr);

	/* wait for console input */
	do {
		result = read(STDIN_FILENO, &c, 1);
	} while(result == 0);

	/* restore termios */
	tcsetattr(STDIN_FILENO, TCSANOW, &orig_attr);

	i = 0;
	while(menus[i].select_letter != NULL) {
		if(c == menus[i].select_letter[0]) {
			printf("\nRunning menu option: %c\n", c);
			if(menus[i].sw_name[0] != '\0') {
				the_fd = open("/NEXTPROG",
						O_WRONLY | O_TRUNC | O_CREAT,
						S_IRWXU | S_IRUSR | S_IRGRP |
						S_IWGRP | S_IROTH | S_IWOTH);
				if(the_fd < 0) {
					puts("ERROR: opening NEXTPROG file");
					return 1;
				}
				the_len = strnlen(menus[i].sw_name, 32);
				result = write(the_fd,
						menus[i].sw_name, the_len);
				if((result < 0) || (result != the_len)) {
					puts("ERROR: writing NEXTPROG file");
					return 1;
				}
				result = close(the_fd);
				if(result < 0) {
					puts("ERROR: closing NEXTPROG file");
					return 1;
				}
			}
			if(menus[i].sc_name[0] != '\0') {
				the_fd = open("/NEXTSCRIPT",
						O_WRONLY | O_TRUNC | O_CREAT,
						S_IRWXU | S_IRUSR | S_IRGRP |
						S_IWGRP | S_IROTH | S_IWOTH);
				if(the_fd < 0) {
					puts("ERROR: opening NEXTSCRIPT file");
					return 1;
				}
				the_len = strnlen(menus[i].sc_name, 32);
				result = write(the_fd,
						menus[i].sc_name, the_len);
				if((result < 0) || (result != the_len)) {
					puts("ERROR: writing NEXTSCRIPT file");
					return 1;
				}
				result = close(the_fd);
				if(result < 0) {
					puts("ERROR: closing NEXTSCRIPT file");
					return 1;
				}
			}
			if(menus[i].hw_name[0] != '\0') {
				the_fd = open("/NEXTFPGA",
						O_WRONLY | O_TRUNC | O_CREAT,
						S_IRWXU | S_IRUSR | S_IRGRP |
						S_IWGRP | S_IROTH | S_IWOTH);
				if(the_fd < 0) {
					puts("ERROR: opening NEXTFPGA file");
					return 1;
				}
				the_len = strnlen(menus[i].hw_name, 32);
				result = write(the_fd,
						menus[i].hw_name, the_len);
				if((result < 0) || (result != the_len)) {
					puts("ERROR: writing NEXTFPGA file");
					return 1;
				}
				result = close(the_fd);
				if(result < 0) {
					puts("ERROR: closing NEXTFPGA file");
					return 1;
				}
			}
			return 0;
		}
		i++;
	}

	if(c == 'H') {
		help_menu(&menus[0]);
		goto menu_loop;
	}

	printf("\nCannot locate menu option: %c\n", c);
	puts("Please try again...");

	goto menu_loop;
}

void help_menu(struct menu_s *menus) {

	int i;
	int column;
	char c;
	int result;
	struct termios orig_attr;
	struct termios new_attr;

help_menu_loop:

	puts("");
	puts("");
	printf(" %s\n %s\n %s\n %s\n %s\n %s\n",
"******************************************************************************",
"*                                 HELP MENU                                  *",
"******************************************************************************",
"*                       Exit help mode by pressing 'h'                       *",
"*             Enter menu letters below for additional information            *",
"******************************************************************************"
);
	puts("");

	i = 0;
	column = 0;
	while(menus[i].select_letter != NULL) {
		if(menus[i].select_letter[0] != '\0') {
			printf(" %-1.1s - %-34.34s",
				menus[i].select_letter,
				menus[i].display_name);

			if(column == 1)
				puts("");

			column++;
			column %= 2;
		} else {
			if(column == 1)
				puts("");

			printf(menus[i].display_name,
				menus[i].sw_name,
				menus[i].sc_name,
				menus[i].hw_name);

			puts("");
			column = 0;
		}
		i++;
	}

	if(column == 1)
		puts("");

	puts("");
	printf ("Enter help menu selection:");
	fflush(stdout);

	/* adjust termios so we see each character input and no echo */
	tcgetattr(STDIN_FILENO, &orig_attr);
	new_attr = orig_attr;
	new_attr.c_lflag &= ~(ICANON | ECHO);
	tcsetattr(STDIN_FILENO, TCSANOW, &new_attr);

	/* wait for console input */
	do {
		result = read(STDIN_FILENO, &c, 1);
	} while(result == 0);

	/* restore termios */
	tcsetattr(STDIN_FILENO, TCSANOW, &orig_attr);

	i = 0;
	while(menus[i].select_letter != NULL) {
		if(c == menus[i].select_letter[0]) {
			printf("%s", BLANK_LINES_30);
			printf("Help for menu option: %c\n", c);
			puts("");
			printf("%s", menus[i].help_text_1);
			printf("%s\n", menus[i].help_text_2);
			puts("");
			printf("Press any key to continue.");
			fflush(stdout);

			/* adjust termios so we see each character input and no
			 * echo
			 */
			tcgetattr(STDIN_FILENO, &orig_attr);
			new_attr = orig_attr;
			new_attr.c_lflag &= ~(ICANON | ECHO);
			tcsetattr(STDIN_FILENO, TCSANOW, &new_attr);

			/* wait for console input */
			do {
				result = read(STDIN_FILENO, &c, 1);
			} while(result == 0);

			/* restore termios */
			tcsetattr(STDIN_FILENO, TCSANOW, &orig_attr);

			puts("");
			goto help_menu_loop;
		}
		i++;
	}

	if(c == 'h')
		return;

	printf("\nCannot locate menu option: %c\n", c);
	puts("Please try again...");

	goto help_menu_loop;
}
