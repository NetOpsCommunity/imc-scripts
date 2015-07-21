
#**************************************************************************
#Identification: backup_running_config_cli
#Purpose:        backup running configuration by cli.
#**************************************************************************

	send "terminal length 0\r"
	send "show run\r"
	# Look for interface section to make sure we skip possible prompt characters in banner section
	expect -re "\nend"
	expect *
	expect -re "\n\[\S ]*$enable_prompt"
