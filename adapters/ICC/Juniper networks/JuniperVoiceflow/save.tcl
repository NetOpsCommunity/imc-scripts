
#**************************************************************************
# Identification: save.tcl
# Purpose:        save device configuration
#**************************************************************************
proc save {} {
    global enable_prompt 
    global standard_timeout 
    global long_timeout 
	set timeout $long_timeout
	
	send "copy running-config startup-config\r"
	expect { 
		-re "Error:" {
			set ERROR_RESULT true
			expect $enable_prompt
		} $enable_prompt {
		}
	}

	set timeout $standard_timeout
}