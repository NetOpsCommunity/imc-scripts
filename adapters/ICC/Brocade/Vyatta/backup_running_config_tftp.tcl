
#**************************************************************************
# Identification:backup_running_config_tftp
# Purpose:       backup running configuration by tftp
#**************************************************************************


	set timeout $long_timeout
	set WARNING_RESULT true
	send "save tftp://$TFTPServer/$TFTPFile\r"
        expect {
		"bytes copied" {
			expect $enable_prompt
		} "Error opening" {
			set ERROR_MESSAGE "An error occurred with the TFTP server at address $TFTPServer"
			set ERROR_RESULT true
			expect $config_prompt
		} "Error writing" {
			set ERROR_MESSAGE "An error occurred writing the TFTP file to the TFTP server at address $TFTPServer"
			set ERROR_RESULT true
			expect $config_prompt
		} "\\?" {
			send "\r"
			expect "bytes copied"
			expect $config_prompt
		} "Done" {
		}
		} -re $config_prompt
		}
	}
	if { $ERROR_RESULT != "true" } {
		set WARNING_RESULT false
	}
	set timeout $standard_timeout
