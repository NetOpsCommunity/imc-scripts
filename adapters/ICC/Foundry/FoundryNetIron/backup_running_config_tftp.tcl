
#**************************************************************************
# Identification:backup_running_config_tftp
# Purpose:       backup running configuration by tftp
#**************************************************************************

	set timeout $very_long_timeout
	set WARNING_RESULT true
	send "copy running-config tftp $TFTPServer $TFTPFile\r"
    expect {
		-re "Error - (.*)" {
			set -f plugin1 expect_out(1,string)
			set ERROR_MESSAGE "Could not copy configuration to TFTP Server: $plugin1"
			set ERROR_RESULT true
		} "Invalid input ->" {
			set ERROR_MESSAGE "User does not have the privilege to copy the configuration."
			set ERROR_RESULT true
		} -re "Upload running-config(.*)failed" {
			set ERROR_MESSAGE "TFTP upload failed: server is down or unreachable"
			set ERROR_RESULT true
		} -re "Upload running-config(.*)done" {
		}
	}
	expect $enable_prompt
	if { $ERROR_RESULT != "true" } { 
		set WARNING_RESULT false
	}
	set timeout $standard_timeout