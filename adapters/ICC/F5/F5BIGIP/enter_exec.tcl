
#**************************************************************************
# Identification:enter_exec
# Purpose:       enter the "exec" mode on the device
#**************************************************************************

set timeout $standard_timeout
set loop true

while {$loop == "true"} {
	expect {
		-re $password_prompt {
			if {$password == "\x24password" || $password == ""} {
				sleep 1
				send "\r"
				set sent_password "true"
			} else {			    
			    send "$password"
			    sleep 1
				send "\r"
				set sent_password "true"
			}
		} -re $username_prompt {
			if {$username == "\x24username" || $username == ""} {
				set ERROR_MESSAGE "Missing username"
				set ERROR_RESULT true
				set loop false
			} else {
				send "$username\r"
				set sent_password "false"
			}
		} "Press Y or ENTER to continue, N to exit" {
			send "Y"			
		} "Wrong password" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Wrong password."
			set loop false
		} "Please press ENTER" {
			send "\r"
			set loop false
		} "Login failed" {
			# Failure ... get out
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Device rejected the username or password."
			set loop false
		} "Passphrase for key" {
			send "$passphrase\r"
		} -re "y/n" {
			send "y\r"
		} -re "Store key in cache|Update cached key" {
			send "y\r"
		} "Unable to use key file" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Unable to use key file."
			set loop false
		} "Network error" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Network error."
			set loop false
		} "Access denied" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Access denied."
			set loop false
		} "Authentication refused" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Authentication refused."
			set loop false
		} "FATAL ERROR:" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "FATAL ERROR."
			set loop false
		} "Fatal:" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "FATAL."
			set loop false
		} "Unable to load private key" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Unable to load private key."
			set loop false
		} "Server refused" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Server refused."
			set loop false
		} "Enter passphrase for key" {
			send "$passphrase\r"
		} "Are you sure you want to continue connecting" {
			send "yes\r"
		} "Permission denied" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Permission denied."
			set loop false
		} "Received disconnect" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Received disconnect."
			set loop false
		} "bad permissions" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "bad permissions."
			set loop false
		} "Identity file * not accessible:" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Identity file not accessible."
			set loop false
		} "Connection refused" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Connection refused."
			set loop false
		} "Connection timed out" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Connection timed out."
			set loop false
		} "connection is closed" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "connection is closed."
			set loop false
		} "Connection closed" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Connection closed."
			set loop false
		} "Write failed:" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Write failed: Broken pipe."
			set loop false
		} "Missing argument" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Missing argument."
			set loop false
		} -re $exec_prompt {
			set loop false
		} "Login password has not been set" {
			# Failure ... get out
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Cannot login. Message from device: Login password has not been set!"
			set loop false
		} timeout {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Timeout to login. No message recive from device!"
			set loop false
		}
	}
}
