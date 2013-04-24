
#**************************************************************************
# Identification:backup_running_config_tftp
# Purpose:       backup running configuration by tftp
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true

send "save-config CONFIG\r"
expect {
	"Do you wish to proceed?" {
		# Device may complain if there are uncommitted changes... full steam ahead
		send "yes\r\n"
		expect "Configuration saved successfully"
	} "Configuration saved successfully" {
	}
}

expect $enable_prompt
send "copy cfg/CONFIG.cfg tftp://$TFTPServer/$TFTPFile\r"

    expect { 
	"Invalid URL" {
		set ERROR_MESSAGE "Invalid TFTP server address or TFTP filename."
		set ERROR_RESULT true
		expect $enable_prompt
	} $enable_prompt {
		# Success
	}
}
if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}
set timeout $standard_timeout