
#**************************************************************************
# Identification:backup_startup_config_cli
# Purpose:       backup startup configuration by cli
#**************************************************************************
			
set loop true
send "cat cfg/startup.cfg\r"

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