
#**************************************************************************
#Identification: backup_running_config_cli
#Purpose:        backup running configuration by cli.
#**************************************************************************

set timeout $standard_timeout
send "show ns runningConfig\r"
set loop true

while {$loop == "true"} {
	expect {
		-re "$more_prompt" {
			send " "
		} -re $error_pattern {
			set error_message $expect_out(1,string)
			expect -re $exec_prompt
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Device error: $error_message"
			set loop false
		} -re "Done" {
			# Done
			set loop false
		}
	}
}

set timeout $standard_timeout
	
