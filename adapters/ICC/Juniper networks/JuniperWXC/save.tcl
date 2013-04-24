
#**************************************************************************
# Identification: save.tcl
# Purpose:        save device configuration
#**************************************************************************
proc save {} {
    global exec_prompt 
    global standard_timeout 
    global long_timeout 
	set timeout $long_timeout
	
	send "save\r"
	expect "Are you sure"
	
	send "y\r"
	set loop true
	
	while {$loop == "true"} {
		expect {
			"input the file name" {
				# Device may ask to confim the filename [enter to use default]
				send "\r"
			} "overwrite" {
				# Tell device to overwrite existing config
				send "y\r"
			} "successfully" {
				# Success, obviously
				set loop false
			}
		}
	}
	expect -re $exec_prompt
	
	set timeout $standard_timeout
}