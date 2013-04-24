
#**************************************************************************
# Identification:enter_exec
# Purpose:       enter the "exec" mode on the device
#**************************************************************************

set IGNORE_DELAY true
if { $use_undeterministic_prompt == "true" } {
	set undeterministic_prompt $tc_undeterministic_prompt
}
if {$banner_skip_repeat != "0"} {
	expect -re "$banner_skip"
	expect "*"
}
set loop true
while {$loop == "true"} {
	expect {
		$password_prompt {
			if {$password == "\x24password" || $password == ""} {
				set ERROR_MESSAGE "Missing password"
				set ERROR_RESULT true
				return
			} else {
				send "$password\r"
				set sent_password "true"
			}
		} $exec_prompt {
			send "\r"
			expect $exec_prompt
			set loop false
		} $enable_prompt {
			if { $forceDisable == "true" } {
				send "disable\r"
				expect $exec_prompt
			}
	
			if { $forceDisable != "true" } {
				set exec_prompt $enable_prompt
			}
			set loop false
		} -re "$undeterministic_prompt" {
			if { $sent_password == "true" } {
				set suspect_prompt expect_out(1,string)
				send "\r"
				expect $suspect_prompt
				set exec_prompt $suspect_prompt
				set loop false
			}
			if { $sent_password != "true" } {
				expect "*"
				sleep 1
			}
		}
	}
}
if {$useTruePrompt != "false" } {
	send "\r"
	expect -re "(.*?$exec_prompt)"
	set exec_prompt expect_out(1,string)
}
if {$resetMorePrompting != "false"} {
	send "no page-break-prompt\r"
	expect $exec_prompt
}
set IGNORE_DELAY false