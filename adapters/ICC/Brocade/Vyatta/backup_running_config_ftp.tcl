
#**************************************************************************
# Identification:backup_running_config_tftp
# Purpose:       backup running configuration by tftp
#**************************************************************************


	set timeout $long_timeout
	set WARNING_RESULT true
	send "save ftp://$FTPUser:$FTPPassword@$TFTPServer/$TFTPFile\r"
    	expect { 
		 -re "connect to host" {
			set ERROR_MESSAGE "Could not copy the $runningConfig to an ftp server."
			set ERROR_RESULT true
			expect $config_prompt
		} -re $config_prompt {
		} "Done" {
		}
	}
	if { $ERROR_RESULT != "true" } {
		set WARNING_RESULT false
	}
	set timeout $standard_timeout
