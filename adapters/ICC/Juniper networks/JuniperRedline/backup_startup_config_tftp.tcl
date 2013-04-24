
#**************************************************************************
# Identification:backup_startup_config_tftp
# Purpose:       backup startup configuration by tftp
#**************************************************************************

set timeout $long_timeout
send "export config tftp://$TFTPServer/$TFTPFile\r"
expect {
	"Unknown keyword" {
		set ERROR_MESSAGE "Error attempting operation.  Bad command or invalid permissions."
		set ERROR_RESULT true
    } "Failed" {
        set ERROR_MESSAGE "TFTP transfer failed."
        set ERROR_RESULT true
	} -re $prompt {
	}
}
set timeout $standard_timeout