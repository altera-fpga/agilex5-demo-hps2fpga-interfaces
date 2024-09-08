/*
 * SPDX-FileCopyrightText: Copyright (C) 2024 Intel Corporation
 * SPDX-License-Identifier: MIT-0
 */

#include <exports.h>
#include "help_text.h"
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

int boot_app(int argc, char *const argv[])
{
	int i;
	int column;
	int c;
	uint64_t cntpct_el0;
	uint64_t cntfrq_el0;
	uint64_t sdm_cmd;
	uint64_t sdm_result;
	uint64_t sdm_jtag_usercode;
	uint64_t midr_el1;
	uint64_t mpidr_el1;
	uint64_t currentel;
	uint64_t daif;
	uint64_t cntpct_copy;
	uint64_t days;
	uint64_t hours;
	uint64_t minutes;
	uint64_t seconds;
	uint64_t milliseconds;
	uint64_t microseconds;
	uint64_t nanoseconds;
	struct menu_s menus[] = {
		{
			/* menu selection letter */
			"",
			/* display name */
			"%5s%s%s",
			/* software name */
			" ",
			/* script name */
			"Boot Application Menu",
			/* hardware name */
			"",
			/* help text */
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
		},
		{
			/* menu selection letter */
			"A",
			/* display name */
			"acknowledgements",
			/* software name */
			"sw_boot_app",
			/* script name */
			"script-attribution",
			/* hardware name */
			"",
			/* help text */
			A_menu_HELP_TEXT
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
"-------------------------------------------------| Switch to Linux Demos |----",
			/* help text */
		},
		{
			/* menu selection letter */
			"L",
			/* display name */
			"start linux",
			/* software name */
			"",
			/* script name */
			"script-start-linux",
			/* hardware name */
			"",
			/* help text */
			L_menu_HELP_TEXT
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
		},
		{
			/* menu selection letter */
			"s",
			/* display name */
			"system counter",
			/* software name */
			"sw_system_counter",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			s_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"a",
			/* display name */
			"armv8 registers",
			/* software name */
			"sw_armv8_regs",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			a_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"v",
			/* display name */
			"read volt/temp sensors",
			/* software name */
			"sw_read_sensors",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			v_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"q",
			/* display name */
			"SDM query, chip id and more",
			/* software name */
			"sw_sdm_query",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			q_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"o",
			/* display name */
			"cache status registers",
			/* software name */
			"sw_cache_reg",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			o_menu_HELP_TEXT
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
		},
		{
			/* menu selection letter */
			"g",
			/* display name */
			"hps gp demo",
			/* software name */
			"sw_hps_gp",
			/* script name */
			"",
			/* hardware name */
			"hw_hps_gp",
			/* help text */
			g_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"i",
			/* display name */
			"f2h irq demo",
			/* software name */
			"sw_f2h_irq",
			/* script name */
			"",
			/* hardware name */
			"hw_f2h_irq",
			/* help text */
			i_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"l",
			/* display name */
			"f2h irq handler demo",
			/* software name */
			"sw_f2h_irq_handler",
			/* script name */
			"",
			/* hardware name */
			"hw_f2h_irq",
			/* help text */
			l_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"z",
			/* display name */
			"config clock demo",
			/* software name */
			"sw_config_clk",
			/* script name */
			"",
			/* hardware name */
			"hw_config_clk",
			/* help text */
			z_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"y",
			/* display name */
			"h2f user clock demo",
			/* software name */
			"sw_h2f_user_clk",
			/* script name */
			"",
			/* hardware name */
			"hw_h2f_user_clk",
			/* help text */
			y_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"x",
			/* display name */
			"lwh2f bridge demo",
			/* software name */
			"sw_lwh2f_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_lwh2f_bridge",
			/* help text */
			x_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"w",
			/* display name */
			"lwh2f bridge default subordinate",
			/* software name */
			"sw_lwh2f_bridge_def_sub",
			/* script name */
			"",
			/* hardware name */
			"hw_lwh2f_bridge",
			/* help text */
			w_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"t",
			/* display name */
			"h2f bridge",
			/* software name */
			"sw_h2f_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_h2f_bridge",
			/* help text */
			t_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"r",
			/* display name */
			"h2f bridge default subordinate",
			/* software name */
			"sw_h2f_bridge_def_sub",
			/* script name */
			"",
			/* hardware name */
			"hw_h2f_bridge",
			/* help text */
			r_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"p",
			/* display name */
			"f2sdram bridge",
			/* software name */
			"sw_f2sdram_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_f2sdram_bridge",
			/* help text */
			p_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"b",
			/* display name */
			"f2h bridge",
			/* software name */
			"sw_f2h_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_f2h_bridge",
			/* help text */
			b_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"k",
			/* display name */
			"hps uart",
			/* software name */
			"sw_uart",
			/* script name */
			"",
			/* hardware name */
			"hw_uart",
			/* help text */
			k_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"f",
			/* display name */
			"hps spi bridge",
			/* software name */
			"sw_spi_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_spi_bridge",
			/* help text */
			f_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"e",
			/* display name */
			"hps i2c bridge",
			/* software name */
			"sw_i2c_bridge",
			/* script name */
			"",
			/* hardware name */
			"hw_i2c_bridge",
			/* help text */
			e_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"T",
			/* display name */
			"hps emac",
			/* software name */
			"sw_emac",
			/* script name */
			"",
			/* hardware name */
			"hw_emac",
			/* help text */
			T_menu_HELP_TEXT
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
		},
		{
			/* menu selection letter */
			"c",
			/* display name */
			"exit to u-boot console",
			/* software name */
			"",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			c_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"m",
			/* display name */
			"display menu",
			/* software name */
			"sw_boot_app",
			/* script name */
			"",
			/* hardware name */
			"",
			/* help text */
			m_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"5",
			/* display name */
			"program a55 rpd image into flash",
			/* software name */
			"sw_boot_app",
			/* script name */
			"script-prog-a55-rpd",
			/* hardware name */
			"",
			/* help text */
			m5_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"7",
			/* display name */
			"program a76 rpd image into flash",
			/* software name */
			"sw_boot_app",
			/* script name */
			"script-prog-a76-rpd",
			/* hardware name */
			"",
			/* help text */
			m7_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"n",
			/* display name */
			"load no-peripheral FPGA image",
			/* software name */
			"sw_boot_app",
			/* script name */
			"",
			/* hardware name */
			"hw_no_periph",
			/* help text */
			n_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"j",
			/* display name */
			"load jamb FPGA image",
			/* software name */
			"sw_boot_app",
			/* script name */
			"",
			/* hardware name */
			"hw_hps_jamb",
			/* help text */
			j_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"u",
			/* display name */
			"update u-boot.itb image in flash",
			/* software name */
			"sw_boot_app",
			/* script name */
			"script-update-uboot-itb",
			/* hardware name */
			"",
			/* help text */
			u_menu_HELP_TEXT
		},
		{
			/* menu selection letter */
			"d",
			/* display name */
			"update demos.itb image in flash",
			/* software name */
			"sw_boot_app",
			/* script name */
			"script-update-demos-itb",
			/* hardware name */
			"",
			/* help text */
			d_menu_HELP_TEXT
		},
		/* used menu letters: abcdefg_ijklmnopqrstuvwxyz57 */
		{
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		},
	};

	/* initialize u-boot standalone application environment */
	app_startup(argv);

	/* validate the u-boot API version */
	if(get_version() != XF_VERSION) {
		puts("\n");
		puts("Unexpected U-Boot ABI version\n");
		printf("EXPECT: %d\n", XF_VERSION);
		printf("ACTUAL: %d\n", (int)get_version());
		puts("\n");
		return 1;
	}

menu_loop:
	asm volatile (
		"mrs %[cntpct_el0], cntpct_el0\n"
		: [cntpct_el0] "=r" (cntpct_el0)
	);

	asm volatile (
		"mrs %[cntfrq_el0], cntfrq_el0\n"
		: [cntfrq_el0] "=r" (cntfrq_el0)
	);

	/* read value from sdm */
	sdm_cmd = SMC_CMD_GET_USERCODE;
	asm volatile (
		"mov x0, %[sdm_cmd]\n"
		"mov x1, #0\n"
		"mov x2, #0\n"
		"mov x3, #0\n"
		"mov x4, #0\n"
		"mov x5, #0\n"
		"mov x6, #0\n"
		"smc #0\n"
		"mov %[sdm_result], x0\n"
		"mov %[sdm_jtag_usercode], x1\n"
		:
		       [sdm_result] "=r" (sdm_result),
		[sdm_jtag_usercode] "=r" (sdm_jtag_usercode)
		:
		          [sdm_cmd] "r"  (sdm_cmd)
		: "x0", "x1", "x2", "x3", "x4", "x5", "x6"
	);

	env_set_hex("JTAGUSERCODE", sdm_jtag_usercode);

	puts("\n");
	puts("\n");

	printf("%26.26s", "Running on board: ");
	if(sdm_result != 0)
		puts("FAILED TO QUERY JTAG USERCODE");
	else {
		switch(sdm_jtag_usercode) {
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
	}
	puts("\n");

	cntpct_copy = cntpct_el0;
	seconds = cntpct_copy / cntfrq_el0;
	days = seconds / (60 * 60 * 24);
	seconds = seconds % (60 * 60 * 24);
	hours = seconds / (60 * 60);
	seconds = seconds % (60 * 60);
	minutes = seconds / 60;
	seconds = seconds % 60;
	cntpct_copy %= cntfrq_el0;
	cntpct_copy *= 1000;
	milliseconds = cntpct_copy / cntfrq_el0;
	cntpct_copy %= cntfrq_el0;
	cntpct_copy *= 1000;
	microseconds = cntpct_copy / cntfrq_el0;
	cntpct_copy %= cntfrq_el0;
	cntpct_copy *= 1000;
	nanoseconds = cntpct_copy / cntfrq_el0;
	printf("%26.26s", "Uptime: ");
	printf("%04lldd'%02lldh'%02lldm'%02llds'%03lldms'%03lldus'%03lldns\n",
	days, hours, minutes, seconds, milliseconds, microseconds, nanoseconds);

	asm volatile (
		"mrs %[mpidr_el1], mpidr_el1\n"
		: [mpidr_el1] "=r" (mpidr_el1)
	);

	printf("%26.26s", "Running on core: ");
	printf("%lld\n",
		(mpidr_el1 & MPIDR_EL1_AFF1_MASK) >> MPIDR_EL1_AFF1_OFST);

	asm volatile (
		"mrs %[midr_el1], midr_el1\n"
		: [midr_el1] "=r" (midr_el1)
	);

	printf("%26.26s", "Core type: ");
	if (((midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A55_VAL)
		puts("Cortex A55 ");
	else if (((midr_el1 & MIDR_EL1_PN_MASK) >> MIDR_EL1_PN_OFST) ==
							MIDR_EL1_A76_VAL)
		puts("Cortex A76 ");
	else
		puts("UNKNOWN ");

	printf("r%lldp%lld core\n",
		(midr_el1 & MIDR_EL1_VAR_MASK) >> MIDR_EL1_VAR_OFST,
		(midr_el1 & MIDR_EL1_REV_MASK) >> MIDR_EL1_REV_OFST);

	asm volatile (
		"mrs %[currentel], currentel\n"
		: [currentel] "=r" (currentel)
	);

	printf("%26.26s", "Current exception level: ");
	printf("EL%lld\n", (currentel & CURRENTEL_MASK ) >> CURRENTEL_OFST);

	asm volatile (
		"mrs %[daif], daif\n"
		: [daif] "=r" (daif)
	);

	printf("%26.26s", "Current exception masks: ");
	printf("%c%c%c%c\n",
		(daif & DAIF_D_MASK) ? 'D' : 'd',
		(daif & DAIF_A_MASK) ? 'A' : 'a',
		(daif & DAIF_I_MASK) ? 'I' : 'i',
		(daif & DAIF_F_MASK) ? 'F' : 'f');

	printf("%26.26s", "MPU CLOCK: ");
	printf("%ld HZ\n", cm_get_mpu_clk_hz());

	puts("\n");

	i = 0;
	column = 0;
	while(menus[i].select_letter != NULL) {
		if(menus[i].select_letter[0] != '\0') {
			printf(" %-1.1s - %-34.34s",
				menus[i].select_letter,
				menus[i].display_name);

			if(column == 1)
				puts("\n");

			column++;
			column %= 2;
		} else {
			if(column == 1)
				puts("\n");

			printf(menus[i].display_name,
				menus[i].sw_name,
				menus[i].sc_name,
				menus[i].hw_name);

			puts("\n");
			column = 0;
		}
		i++;
	}

	puts("\n");
	printf ("Enter menu selection:");

	/* wait for console input */
	while (!tstc());
	c = getc();
	i = 0;
	while(menus[i].select_letter != NULL) {
		if(c == menus[i].select_letter[0]) {
			printf("\nRunning menu option: %c\n", c);
			if(menus[i].sw_name[0] != '\0')
				env_set("NEXTPROG", menus[i].sw_name);
			if(menus[i].sc_name[0] != '\0')
				env_set("NEXTSCRIPT", menus[i].sc_name);
			if(menus[i].hw_name[0] != '\0')
				env_set("NEXTFPGA", menus[i].hw_name);
			return 0;
		}
		i++;
	}

	if(c == 'H') {
		help_menu(&menus[0]);
		goto menu_loop;
	}

	printf("\nCannot locate menu option: %c\n", c);
	puts("Please try again...\n");

	goto menu_loop;
}

void help_menu(struct menu_s *menus) {

	int i;
	int column;
	int c;

help_menu_loop:

	puts("\n");
	puts("\n");
	printf(" %s\n %s\n %s\n %s\n %s\n %s\n",
"******************************************************************************",
"*                                 HELP MENU                                  *",
"******************************************************************************",
"*                       Exit help mode by pressing 'h'                       *",
"*             Enter menu letters below for additional information            *",
"******************************************************************************"
);
	puts("\n");

	i = 0;
	column = 0;
	while(menus[i].select_letter != NULL) {
		if(menus[i].select_letter[0] != '\0') {
			printf(" %-1.1s - %-34.34s",
				menus[i].select_letter,
				menus[i].display_name);

			if(column == 1)
				puts("\n");

			column++;
			column %= 2;
		} else {
			if(column == 1)
				puts("\n");

			printf(menus[i].display_name,
				menus[i].sw_name,
				menus[i].sc_name,
				menus[i].hw_name);

			puts("\n");
			column = 0;
		}
		i++;
	}

	puts("\n");
	printf ("Enter help menu selection:");

	/* wait for console input */
	while (!tstc());
	c = getc();
	i = 0;
	while(menus[i].select_letter != NULL) {
		if(c == menus[i].select_letter[0]) {
			printf("%s", BLANK_LINES_30);
			printf("Help for menu option: %c\n", c);
			puts("\n");
			printf("%s", menus[i].help_text_1);
			printf("%s\n", menus[i].help_text_2);
			puts("\n");
			printf("Press any key to continue.");
			while (!tstc());
			c = getc();
			(void)(c);
			puts("\n");
			goto help_menu_loop;
		}
		i++;
	}

	if(c == 'h')
		return;

	printf("\nCannot locate menu option: %c\n", c);
	puts("Please try again...\n");

	goto help_menu_loop;
}
