
#**************************************************************************
# Identification:enter_exec
# Purpose:       enter the "exec" mode on the device
#**************************************************************************

    set IGNORE_DELAY true
    if {$skip_ctrl_u != "true"} {
        send "\x15" 
    }
    set loop true
    while {$loop == "true"} {
        expect {
            -re $password_prompt {                
                send "$password\r"
                set sent_password "true"

            } "Last login:" {
                # Nothing... deliberately ignore so the username_prompt
                # doesn't pick this one up
                expect "*"
            } -re $username_prompt {
                        send "$username\r"
                        set sent_password "false"
            } $prompt {
                send "\r"
                expect $prompt
                set loop false
            } "Please change passwords for switch default accounts now." {
                set ERROR_MESSAGE "Switch default passwords need to be changed. Please do this manually."
                set ERROR_RESULT true
                return
            } "Access Denied" { 
                set ERROR_MESSAGE "Access denied by the device"
                set ERROR_RESULT true
                return
            } "Authentication failed" {
                set ERROR_MESSAGE "Authentication failed"
                set ERROR_RESULT true
                return
            } "Login incorrect" {
                set ERROR_MESSAGE "Login invalid"
                set ERROR_RESULT true
                return
            } "Bad password" {
                set ERROR_MESSAGE "Bad password"
                set ERROR_RESULT true
                return
    		} "Passphrase for key" {
    			send "$passphrase\r"
    		} -re "y/n" {
    			send "y\r"
    		} -re "Store key in cache|Update cached key" {
    			send "y\r"
    		} "Unable to use key file" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Unable to use key file."
                return
    		} "Network error" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Network error."
                return
    		} "Access denied" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Access denied."
                return
    		} "Authentication refused" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Authentication refused."
                return
    		} "FATAL ERROR:" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "FATAL ERROR."
                return
    		} "Fatal:" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "FATAL."
                return
    		} "Unable to load private key" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Unable to load private key."
                return
    		} "Server refused" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Server refused."
                return
    		} "Enter passphrase for key" {
    			send "$passphrase\r"
    		} "Are you sure you want to continue connecting" {
    			send "yes\r"
    		} "Permission denied" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Permission denied."
                return
    		} "Received disconnect" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Received disconnect."
                return
    		} "bad permissions" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "bad permissions."
                return
    		} "Identity file * not accessible:" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Identity file not accessible."
                return
    		} "Connection refused" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Connection refused."
                return
    		} "Connection timed out" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Connection timed out."
                return
    		} "connection is closed" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "connection is closed."
                return
    		} "Connection closed" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Connection closed."
                return
    		} "Write failed:" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Write failed: Broken pipe."
                return
    		} "Missing argument" {
    			set ERROR_RESULT  true
    			set ERROR_MESSAGE "Missing argument."
                return
            } "% A decimal" {
                set ERROR_MESSAGE "A menu was detected but the exit command was incorrect."
                set ERROR_RESULT true
                return
            }
        }
    }
    set IGNORE_DELAY false

