
#**************************************************************************
# Identification:backup_startup_config_cli
# Purpose:       backup startup configuration by cli
#**************************************************************************

set timeout $long_timeout

send "show startup-config\r"
expect { 
	-re "Error:" {
		set ERROR_RESULT true
		expect $enable_prompt
	} $enable_prompt {
	}
}

set timeout $standard_timeout