
#**************************************************************************
# Identification:reload.tcl
# Purpose:       reload device
#**************************************************************************

set timeout $very_long_timeout
			
send "reboot\r"
expect {
    "Are you sure you want to continue" {
        send "y\r"
    }
}

set timeout $standard_timeout