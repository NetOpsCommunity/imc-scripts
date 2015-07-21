
#**************************************************************************
# Identification:backup_startup_config_tftp
# Purpose:       backup startup configuration by tftp
#**************************************************************************


	set timeout $very_long_timeout
	send "copy startup-config ftp://$FTPUser:$FTPPassword@$TFTPServer/$TFTPFile\r"
    expect {
		-re "Error - (.*)" {
			set -f plugin1 expect_out(1,string)
			set ERROR_MESSAGE "Could not copy configuration to TFTP Server: $plugin1"
			set ERROR_RESULT true
		} "Invalid input ->" {
			set ERROR_MESSAGE "User does not have the privilege to copy the configuration."
			set ERROR_RESULT true
		} -re "Upload startup-config(.*)failed" {
			set ERROR_MESSAGE "TFTP upload failed: server is down or unreachable"
			set ERROR_RESULT true
		} -re "Upload startup-config(.*)done" {
		}
	}
	expect $enable_prompt
	set timeout $standard_timeout
	
