
#**************************************************************************
# Identification:backup_startup_config_tftp
# Purpose:       backup startup configuration by tftp
#**************************************************************************


	set timeout $long_timeout
	set WARNING_RESULT true
	send "copy file running://config/config.boot to ftp://$FTPUser:$FTPPassword@$TFTPServer/$TFTPFile\r"
    	expect { 
		 -re "connect to host" {
			set ERROR_MESSAGE "Could not copy the startup config to an ftp server."
			set ERROR_RESULT true
			expect $enable_prompt
		} $exec_prompt {
		}
	}
	if { $ERROR_RESULT != "true" } {
		set WARNING_RESULT false
	}
	set timeout $standard_timeout
