
#**************************************************************************
# Identification:enter_enable
# Purpose:       enter the "enable" mode on the device
#**************************************************************************

send "enable\r"
set loop true
while {$loop == "true"} {
	expect {
		$password_prompt {
			if {$enable_password == "\x24enable_password" || $enable_password == ""} {
				set ERROR_MESSAGE "Missing enable password"
				set ERROR_RESULT true
				set loop false
			} else {
				send "$enable_password\r"
			}
		} $enable_prompt {
			set loop false
		} -re "Sorry. Wrong password" {
			set ERROR_MESSAGE "Bad enable password"
			set ERROR_RESULT true
			set loop false
		} -re "Error: (.*)" {
			set error $expect_out(1,string)
			set ERROR_MESSAGE "$error."
			set ERROR_RESULT true
			set loop false
		} $suspect_prompt {
			set loop false
			set enable_prompt $suspect_prompt
		}
	}
}
 
if { $ERROR_RESULT == "true" } {
	cleanup
	exit
}
if {$useTruePrompt != "false"} {
	send "\r"
	expect -re "(.*?$enable_prompt)"
	set enable_prompt $expect_out(1,string)
}