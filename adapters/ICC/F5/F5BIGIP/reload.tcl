
#**************************************************************************
# Identification:reload
# Purpose:       reload device
#**************************************************************************

set timeout $standard_timeout

send "reboot -f\r"

sleep 5
