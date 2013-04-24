
#**************************************************************************
#Identification: backup_running_config_cli
#Purpose:        backup running configuration by cli.
#**************************************************************************

set timeout $long_timeout
send "save-config CONFIG\r"
expect {
	"Do you wish to proceed?" {
		# Device may complain if there are uncommitted changes... full steam ahead
		send "yes\r"
		expect "Configuration saved successfully"
	} "Configuration saved successfully" {
	}
}

expect $enable_prompt

set loop true
send "cat cfg/CONFIG.cfg\r"

while {$loop == "true"} {
	expect {
		$more_prompt {
			send " "
		} -re "(\\S+)$enable_prompt" {
			# Need to use a more specific enable prompt, since the
			# "#" character is present in the configuration file
			set loop false
		}
	}
}

set timeout $standard_timeout