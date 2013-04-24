
#**************************************************************************
# Identification:deploy_running_config_cli
# Purpose:       deploy running configuration by cli
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true

foreach entry $commands {
	send "$entry\r"
	expect {
		"Error:" {
			set ERROR_RESULT true
			set ERROR_MESSAGE "An error has occured while running the script"
			expect $orig_enable_prompt
		} $enable_prompt {
		} $orig_enable_prompt {
		}
	}
}

if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}
set timeout $standard_timeout