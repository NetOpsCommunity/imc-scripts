
#**************************************************************************
# Identification:reload.tcl
# Purpose:       reload device
#**************************************************************************

send "execute reboot\r"
expect {
	"(y/n)" { send "y\r" }
       }

close