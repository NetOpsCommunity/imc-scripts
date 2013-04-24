
#**************************************************************************
# Identification:set_device_boot.tcl
# Purpose:       set the device next startup image by cli
#**************************************************************************

set WARNING_RESULT true

send "software-version\r"
expect {
	"Error" {
		set ERROR_MESSAGE "An error occured while getting to the software-version prompt"
		set ERROR_RESULT true
		expect $config_prompt
	} $config_prompt {
	}
}

send "set $TFTPFile\r"
expect {
	"not found" {
		set ERROR_MESSAGE "An error occured while setting the boot file to $TFTPFile"
		set ERROR_RESULT true
		expect $config_prompt
	} $config_prompt {
	}
}


if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}