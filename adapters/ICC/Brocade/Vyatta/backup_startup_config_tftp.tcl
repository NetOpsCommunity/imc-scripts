
#**************************************************************************
# Identification:backup_startup_config_tftp
# Purpose:       backup startup configuration by tftp
#**************************************************************************


	set timeout $long_timeout
	set WARNING_RESULT true
	send "copy file running://config/config.boot to tftp://$TFTPServer/$TFTPFile\r"
    	expect {
		"bytes copied" {
			expect $enable_prompt
		} "Error opening" {
			set ERROR_MESSAGE "An error occurred with the TFTP server at address $TFTPServer"
			set ERROR_RESULT true
			expect $enable_prompt
		} "Error writing" {
			set ERROR_MESSAGE "An error occurred writing the TFTP file to the TFTP server at address $TFTPServer"
		   	set ERROR_RESULT true
			expect $enable_prompt
		} "\\?" {
			send "\r"
			expect "bytes copied"
			expect $enable_prompt
		} $exec_prompt {
		}
	}
	if { $ERROR_RESULT != "true" } {
		set WARNING_RESULT false
	}
	set timeout $standard_timeout
	
