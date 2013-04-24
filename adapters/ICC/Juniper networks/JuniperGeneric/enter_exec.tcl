
#**************************************************************************
# Identification:enter_exec
# Purpose:       enter the "exec" mode on the device
#**************************************************************************

set IGNORE_DELAY true
if {$banner_skip_repeat != "0"} {
	expect -re "$banner_skip"
	expect "*"
}

set loop true
while {$loop == "true"} {
	expect {
		"Last login:" {
			expect $exec_prompt
			send "\r"
			expect $exec_prompt
			set loop false
		} -re $password_prompt {
			if {$password == "\x24password" || $password == ""} {
				set ERROR_MESSAGE "Missing password"
				set ERROR_RESULT true
				return
			} else {
				send "$password\r"
				set sent_password "true"
			}
		} -re $next_passcode_prompt {
			if { $use_securid != "exec" && $use_securid != "enable" } {
				set ERROR_MESSAGE "Device not configured for SecurID."
				set ERROR_LOGIN true
				cleanup
				return
			}
			send "$next_passcode\r"
		} -re "Store key in cache|Update cached key" {
            send "y\r"
        } "y/n" {
            send "y\r"
		} $username_prompt {
			if { $use_securid != "\x24use_securid" && $sent_password == "true" } {				
				set ERROR_MESSAGE "SecurID authentication failed."
				set ERROR_LOGIN true
				cleanup
				return
			} else {

				if {$username == "\x24username" || $username == ""} {
					set ERROR_MESSAGE "Missing username"
					set ERROR_RESULT true
					return
				} else {
					send "$username\r"
					set sent_password "false"
				}
			}
		} "new tokencode:" {
			send "$next_passcode\r"
		} "Enter a new PIN" {
			set ERROR_MESSAGE "Could not login. A new pin needs to be created for this Secure ID user."
			set ERROR_RESULT true
			return
		} "error: Unable to authenticate" {
			set ERROR_MESSAGE "Super-user account is required for device management."
			set ERROR_RESULT true
			return
		} $exec_prompt {
			send "\r"
			expect $exec_prompt
			set loop false
		} "Authentication failed" {
			set ERROR_MESSAGE "Authentication failed"
			set ERROR_RESULT true
			return
		} "Login incorrect" {
			set ERROR_MESSAGE "Login incorrect"
			set ERROR_RESULT true
			return
		}
	}
}
if {$useTruePrompt != "false" } {
	send "\r"
	expect -re "(.*?$exec_prompt)"
	set exec_prompt $expect_out(1,string)
}
if {$resetMorePrompting != "false"} {
	send "set cli screen-length 0\r"
	expect $exec_prompt
}
set IGNORE_DELAY false