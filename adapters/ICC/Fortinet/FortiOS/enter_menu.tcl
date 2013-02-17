
#**************************************************************************
# Identification:enter_menu
# Purpose:       enter the "menu" mode on the device
#**************************************************************************

set IGNORE_DELAY true

expect {
	$username_prompt {		
		if {$username == "\x24username" || $username == ""} {
			set username " "
		}
		send "$username\r"
		expect $password_prompt
		if {$password == "\x24password" || $password == ""} {
			set ERROR_RESULT true
			set ERROR_MESSAGE "Missing password"
			return
		}
		send "$password\r"
	} $password_prompt {
		if {$password == "\x24password" || $password == ""} {
			set ERROR_RESULT true
			set ERROR_MESSAGE "Missing password"
			return
		}
		send "$password\r"
	} "Sorry, the maximum number of telnet sessions" {
		set ERROR_MESSAGE "The device refused to allow another telnet session to connect after maximum number of telnet sessions reached."
		set ERROR_RESULT true
		return
	}
}
expect {
	"Invalid password" {
		set ERROR_RESULT true
		set ERROR_MESSAGE "Incorrect password"
		return
	} "TELNET - OPERATOR" {
		expect {
			"4." { 
				send "4"
			}"0." {
				send "0"
				expect "disconnect"
				send "\r"
			}
		}									
		expect {
			$username_prompt {
				send "$username\r"
				expect $password_prompt
			} $password_prompt {
			}
		}
		send "$enable_password\r"
		expect { 
			"Invalid password" {
				set ERROR_RESULT true
				set ERROR_MESSAGE "Incorrect password for Manager mode"
				return
			} "TELNET - MANAGER" {
			}
		}
	} "TELNET - MANAGER" {
	}
}
set IGNORE_DELAY false