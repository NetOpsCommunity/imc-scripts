
#**************************************************************************
# Identification:backup_running_config_sftp
# Purpose:       backup running configuration by sftp
#**************************************************************************

set timeout $long_timeout
set WARNING_RESULT true


set loop true
send "get iccrunning.cfg \"$TFTPFile\"\r"
while { $loop == "true" } {
	expect {
	    #PUTTY error info
		"Network error" {
			expect -re $exec_prompt
			set ERROR_RESULT true
			set ERROR_MESSAGE "Failed to contact sftp server; network may be down."
			set loop false
		} "FATAL ERROR:" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "FATAL ERROR."
			set loop false
		} "Fatal:" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "FATAL ERROR."
			set loop false
		} -re $error_pattern {
			set error_message $expect_out(1,string)
			expect -re $exec_prompt
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Device error: $error_message"
			set loop false
		} "Unable to transfer file completely" {
			expect -re $exec_prompt
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Device aborted the file transfer."
			set loop false
		} "unable to open" {
		   set ERROR_RESULT  true
		   set ERROR_MESSAGE "Unable to open local file."
		   set loop false
		} "open for read: failure" {
		   set ERROR_RESULT  true
		   set ERROR_MESSAGE "open for read: failure."
		   set loop false
		} "open for write: failure" {
		   set ERROR_RESULT  true
		   set ERROR_MESSAGE "open for write: failure."
		   set loop false
		} "unknown command" {
		   set ERROR_RESULT  true
		   set ERROR_MESSAGE "unknown command."
		   set loop false
		} "connection is closed" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "connection is closed."
			set loop false
		} "Invalid command" {
            #linux ssh error info
		   set ERROR_RESULT  true
		   set ERROR_MESSAGE "Invalid command."
		   set loop false
		} "File * not found" {
		   set ERROR_RESULT  true
		   set ERROR_MESSAGE "File not found."
		   set loop false
		} "Connection closed" {
		   set ERROR_RESULT  true
		   set ERROR_MESSAGE "Connection closed."
		   set loop false
		} "No such file or directory" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "No such file or directory."
			set loop false
		} "Received disconnect" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Received disconnect."
			set loop false
		} "Missing argument" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Missing argument."
			set loop false
		} "Opening remote file failed" {
		#Bitverse
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Opening remote file failed."
			set loop false
		} "Opening local file failed" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Opening local file failed."
			set loop false
		} "file failed" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "file failed."
			set loop false
		} "Creating local directory failed" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Creating local directory failed."
			set loop false
		} "Invalid command option" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Invalid command option."
			set loop false
		} -re $sftp_exec_prompt {
			set loop false
		}
	}
}
set timeout $standard_timeout

