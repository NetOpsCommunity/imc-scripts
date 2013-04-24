
#**************************************************************************
# Identification:reload
# Purpose:       reload
#**************************************************************************

if {$enforce_save == "true"} {
	save
}

send "reboot\r"
expect {
	"save?" {
		send "no\r"
		expect "Continue with reboot?"
		send "yes\r"
	} "Error" {
		set ERROR_MESSAGE "An error occured while attempting to reboot the device"
		set ERROR_RESULT true
		expect $enable_prompt
	} "Continue with reboot?" {
		send "yes\r"
	}
}
return
