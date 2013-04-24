
#**************************************************************************
# Identification:deploy_image_cli.tcl
# Purpose:       deploy image to device by cli
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true

send "software-version\r"
expect $config_prompt

send "update tftp://$TFTPServer/$TFTPFile\r"
expect {	
	} "Error" {
		set ERROR_RESULT true
		set ERROR_MESSAGE "Could not copy image from TFTP server. An error occurred on the device."
		expect $config_prompt
    } $config_prompt {
    }
}

set timeout $standard_timeout
if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}			