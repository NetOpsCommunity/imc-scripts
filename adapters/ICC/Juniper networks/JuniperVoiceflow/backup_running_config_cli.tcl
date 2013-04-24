
#**************************************************************************
#Identification: backup_running_config_cli
#Purpose:        backup running configuration by cli.
#**************************************************************************

set timeout $long_timeout
send "show running-config\r"
expect { 
	-re "Error:" {
		set ERROR_RESULT true
		expect $enable_prompt
	} $enable_prompt {
	}
}

set timeout $standard_timeout
	