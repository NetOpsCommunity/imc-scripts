
#**************************************************************************
# Identification:deploy_startup_config_tftp
# Purpose:       deploy startup configuration by tftp
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true
	
send "copy tftp://$TFTPServer/$TFTPFile startup-config\r"
expect {
	-re "Error: (.*)" {
		set error $expect_out(1,string)
		set ERROR_MESSAGE "$error."
		set ERROR_RESULT true
		expect $enable_prompt
	} $enable_prompt {
	}
}

if { $ERROR_RESULT != "true" && $ERROR_NONFATAL != "true" } {
	set WARNING_RESULT false
}
set timeout $standard_timeout