
#**************************************************************************
# Identification:exit_exec
# Purpose:       quit the "exec" mode on the device
#**************************************************************************

send "exit\r"
expect {
	"TELNET - MANAGER" {
	} $prompt {
		send "exit\r"
		expect "TELNET - MANAGER"
	}
}