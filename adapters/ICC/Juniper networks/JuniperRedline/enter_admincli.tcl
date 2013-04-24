
#**************************************************************************
# Identification:enter_admincli
# Purpose:       enter the "admincli" mode on the device
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
		} $username_prompt {
			if {$username == "\x24username" || $username == ""} {
				set ERROR_MESSAGE "Missing username"
				set ERROR_RESULT true
				return
			} else {
				send "$username\r"
				set sent_password "false"
			}
		} -re $prompt {
			send "\r"
			expect -re $prompt
			set loop false
		} "Login incorrect" {
			set ERROR_MESSAGE "Login invalid"
			set ERROR_RESULT true
			return
		} -re "$tc_undeterministic_prompt" {
			if { $sent_password == "true" } {
				set suspect_prompt $expect_out(1,string)
				send "\r"
				expect $suspect_prompt
				set prompt $suspect_prompt
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
    expect -re "($prompt)"
    set newprompt $expect_out(1,string)
    set prompt ".+|$newprompt"
}

set IGNORE_DELAY false
# now ensure we have necessary privileges
send "whoami\r"
expect {
	": $minimum_role" {
		expect -re $prompt
	} -re $prompt {
		set ERROR_MESSAGE "User does not have necessary permissions."
		set ERROR_RESULT true
	}
}