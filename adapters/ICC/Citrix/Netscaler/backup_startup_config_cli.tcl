
#**************************************************************************
# Identification:backup_startup_config_cli
# Purpose:       backup startup configuration by cli
#**************************************************************************


# Display the startup configuration
send "show ns savedConfig\r"
set loop true

while {$loop == "true"} {
	expect {
		-re "$more_prompt" {
			send " "
		} "Unable to open file" {
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Device reports that startup configuration file does not exist."
		} -re "Done" {
			# Done
			set loop false
		}
	}
}
