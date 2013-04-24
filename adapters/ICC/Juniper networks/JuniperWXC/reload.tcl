
#**************************************************************************
# Identification:reload.tcl
# Purpose:       reload device
#**************************************************************************

if {$enforce_save == "true"} {
	save
}

send "reboot\r"
expect {
	"Are you sure? yes/no" {
		send "y\r"
	} "uthorization failed" {
		set ERROR_MESSAGE "The user is not authorized to use the command reload"
		set ERROR_RESULT true
		expect $enable_prompt
	}
}
close