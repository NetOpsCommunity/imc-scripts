#**************************************************************************
# Identification:enter_enable
# Purpose:       enter the "enable" mode on the device
#**************************************************************************

send "\r"
expect {
	-re $exec_prompt {
		send "enable\r"
		set loop true
						
		while { $loop == "true" } {
			expect {
				-re $username_prompt {
					if { $username == "\x24username" || $username == "" } {
						set ERROR_MESSAGE "Missing username"
						set ERROR_RESULT true
						set loop false
					} else {
						set asked_for_username true
						send "$username\r"
					}
				} -re $password_prompt {
					if { $enable_password == "\x24enable_password" || $enable_password == "" } {
						set ERROR_MESSAGE "Missing user password"
						set ERROR_RESULT true
						set loop false
					} else {
						# SSH requires user+pass; telnet uses password+enable_password
						if {$asked_for_username == "true"} {
							send  "$password\r"
						} else {
							send "$enable_password\r"
						}
					}
				} -re "Error" {
					set plugin1 expect_out(1,string)
					set ERROR_MESSAGE "Could not execute the enable command: $plugin1"
					set ERROR_RESULT true
					set loop false
				} -re $enable_prompt {
					set loop false
				}
			}
		}
	} -re $enable_prompt {
	
	}
}
