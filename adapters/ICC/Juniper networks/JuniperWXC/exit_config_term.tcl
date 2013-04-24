
#**************************************************************************
# Identification:exit_config_term
# Purpose:       quit the "config_term" mode on the device
#**************************************************************************

send "\r"
expect {
	$config_prompt {
		set loop true
		while { $loop == "true" } {
			send "exit\r"
			expect {
				$config_prompt {
				} $enable_prompt {
					set loop false
				}
			}
		}
	} $enable_prompt {
	}
}

if {$enforce_save == "true"} {
	save
}