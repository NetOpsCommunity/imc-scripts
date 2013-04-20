
#**************************************************************************
# Identification:save_running_config
# Purpose:       save running configuration by cli
#**************************************************************************


set timeout $long_timeout
set WARNING_RESULT true

# Prevent possible future "overwrite" messages by deleting first
set _filename iccrunning.cfg
delete_file			
sleep 1
set _filename iccrunning.zip
delete_file

expect "*"
set ERROR_MESSAGE ""
sleep 5

# Save running config to a file
send "save iccrunning.cfg\r"
sleep 1
expect {
	"Y/N" {
		send "y\r"
                send "\r"
                sleep 1
		expect -re $exec_prompt
	} -re $error_pattern {
		set error_message $expect_out(1,string)
		expect -re $exec_prompt
		set ERROR_RESULT  true
		set ERROR_MESSAGE "Device error: $error_message"
		return
	} "Too many parameters found at" {
		expect -re $exec_prompt
		set ERROR_RESULT  true
		set ERROR_MESSAGE "Too many parameters found."
		return
	} "Invalid file name or Invalid extension" {
		# Device only wants to use ZIPped configurations
		send "save iccrunning.zip\r"
		expect "Y/N"
		send "y\r"
		expect -re $exec_prompt
		
		# Try to unzip the config file
		send "unzip iccrunning.zip iccrunning.cfg\r"
		expect {
			"Y/N" {
				send "y\r"
				expect -re $exec_prompt
			} "Unrecognized" {
				# Failed... bug out, now
				set ERROR_RESULT  true
				set ERROR_MESSAGE "Device does not support text configurations."
				#exit
				return
			}
		}
	} "please try it later" {
	   sleep 5
	} -re $exec_prompt {
	}
}
set timeout $standard_timeout

