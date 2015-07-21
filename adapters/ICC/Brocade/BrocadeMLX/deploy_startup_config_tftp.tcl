
#**************************************************************************
# Identification:deploy_startup_config_tftp
# Purpose:       deploy startup configuration by tftp
#**************************************************************************

	set timeout $very_long_timeout
	set WARNING_RESULT true
	send "copy tftp startup-config $TFTPServer $TFTPFile\r"
	expect {
		-re "Download (to )*startup-config .* done" {
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
			send "\r"
		} -re "(.*failed)" {
			set -f plugin1 expect_out(1,string)
			set ERROR_MESSAGE "Could not copy file from TFTP server: $plugin1"
			set ERROR_RESULT true
			send "\r"
		} $enable_prompt {
		}
	}
	expect { 
		"Invalid" {
			set ERROR_RESULT true
			set ERROR_MESSAGE "Invalid commands within the configuration."
			expect $enable_prompt
		} $enable_prompt {
			# Done when we reach a prompt
		}
	}
	if { $ERROR_RESULT != "true" } {
		set WARNING_RESULT false
	}

	set timeout $standard_timeout