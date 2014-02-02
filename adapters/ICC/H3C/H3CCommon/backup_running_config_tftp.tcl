
#**************************************************************************
# Identification:backup_running_config_tftp
# Purpose:       backup running configuration by tftp
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

# Save running config to a file
send "save iccrunning.cfg\r"
expect {
	-re "Y/N" {
		send "y\r"
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
		send "y\r"
                expect -re $exec_prompt
	}
}

expect "*"

set loop true

set my_cmd "tftp $TFTPServer put iccrunning.cfg $TFTPFile"
if { $VpnName != "" } {
   append my_cmd " vpn-instance $VpnName"
}
send "$my_cmd\r"

while { $loop == "true" } {
	expect {
		"Can't connect to the remote host" {
			expect -re $exec_prompt
			set ERROR_RESULT true
			set ERROR_MESSAGE "Failed to contact tftp server; server may be down."
			set loop false
		} "Failed to connect to the remote host" {
			expect -re $exec_prompt
			set ERROR_RESULT true
			set ERROR_MESSAGE "Failed to contact tftp server; server may be down."
			set loop false
		}	-re $error_pattern {
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
		} "File uploaded successfully" {
		   set loop false
			expect -re $exec_prompt
		} "Unable to open local file" {
		   set ERROR_RESULT  true
		   set ERROR_MESSAGE "Unable to open local file."
		   set loop false
		} "Synchronization failed" {
		   set ERROR_RESULT  true
		   set ERROR_MESSAGE "Tftp synchronization failed while transfer file."
		   set loop false
		} -re $exec_prompt {
		   set loop false
		}
	}
}
set timeout $standard_timeout
