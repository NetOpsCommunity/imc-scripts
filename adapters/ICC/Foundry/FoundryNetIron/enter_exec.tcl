#**************************************************************************
# Identification:enter_exec
# Purpose:       enter the "exec" mode on the device
#**************************************************************************

set IGNORE_DELAY true
if {$banner_skip_repeat != "0"} {
	expect -re "$banner_skip"
	expect "*"
}
				
expect {
	-re "User Access Verification" {
		# Got the login banner 
	} -re "Press \S+>" {
		# Device may require us to press enter to skip MOTD
		send "\r"
		expect *
	} -re $exec_prompt {
		# Exec mode
	} -re $enable_prompt {
		# Enable mode
	} -re $username_prompt {
		# Normal user prompt
		send "$username\r"						
	}
}						
				
set loop true
while { $loop == "true" } {
	expect {
		-re "User login failure." {
			set ERROR_MESSAGE "Could not login. Incorrect password."
			set ERROR_RESULT true
			set loop false
		} -re $password_prompt {
			send "$password\r"
		} -re $username_prompt {
			send "$username\r"
		} -re $exec_prompt {
			set loop false
		} -re $enable_prompt {
			set loop false
		} 
	}
}
				
set IGNORE_DELAY false
