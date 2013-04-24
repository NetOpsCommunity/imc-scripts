
#**************************************************************************
# Identification:backup_startup_config_tftp
# Purpose:       backup startup configuration by tftp
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true
send "copy startup-config tftp://$TFTPServer/$TFTPFile\r"
expect { 
	-re "Error:" {
		set ERROR_RESULT true
		expect $enable_prompt
	} $enable_prompt {
	}
}

if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}
set timeout $standard_timeout