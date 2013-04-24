
#**************************************************************************
# Identification:backup_startup_config_tftp
# Purpose:       backup startup configuration by tftp
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true

send "copy cfg/startup.cfg tftp://$TFTPServer/$TFTPFile\r"
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