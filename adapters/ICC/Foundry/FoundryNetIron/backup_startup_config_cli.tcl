
#**************************************************************************
# Identification:backup_startup_config_cli
# Purpose:       backup startup configuration by cli
#**************************************************************************

	send "terminal length 0\r"
	send "show config\r"
	# Look for interface section to make sure we skip possible prompt characters in banner section
	expect -re "\nend"
	expect *
	expect -re "\n\[\S ]*$enable_prompt"
