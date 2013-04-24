
#**************************************************************************
# Identification:exit_admincli
# Purpose:       quit the "admincli" mode on the device
#**************************************************************************

# save config if changes made
send "\r"
expect {
	"(*)" {
		expect -re $prompt
		send "write\r"
		expect -re $prompt
	} -re $prompt {
	}
}
send "exit\r"