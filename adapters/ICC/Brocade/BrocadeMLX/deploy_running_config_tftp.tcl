
#**************************************************************************
# Identification:deploy_running_config_tftp
# Purpose:       deploy running configuration by tftp
#**************************************************************************

	set WARNING_RESULT true
	set timeout $very_long_timeout
	send "copy tftp running-config $TFTPServer $TFTPFile\r"
	expect {
		-re "Download (to )*running-config .* done" {
			expect {
				-re "([eE]rror|Invalid|failed)" {
					set ERROR_MESSAGE "TFTP configuration deployment failed; invalid commands."
					set ERROR_RESULT true
					expect $enable_prompt
				} $enable_prompt {
					# Success
				}
			}
		} -re "Error - (.*)" {
			set -f plugin1 expect_out(1,string)
			set ERROR_MESSAGE "Could not copy file from TFTP server: $plugin1"
			set ERROR_RESULT true
			sleep 2
			send "\r"
		} -re "(.*failed)" {
			set -f plugin1 expect_out(1,string)
			set ERROR_MESSAGE "Could not copy file from TFTP server: $plugin1"
			set ERROR_RESULT true
			sleep 2
			send "\r"
		} "Invalid" {
			set ERROR_RESULT true
			set ERROR_MESSAGE "Invalid commands in configuration."
			send "\r"
		}
	}
	if { $ERROR_RESULT != "true" } {
		set WARNING_RESULT false
	}
	set timeout $standard_timeout