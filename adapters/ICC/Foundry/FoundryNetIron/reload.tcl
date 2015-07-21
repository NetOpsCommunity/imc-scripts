#**************************************************************************
# Identification:reload
# Purpose:       reload
#**************************************************************************

send "reload\r"
expect "?" 
send "y\r"
expect {
	-re "?" {
		send "y\r"
	} -re "Halt and reboot" {
		# We're already done
	}
}