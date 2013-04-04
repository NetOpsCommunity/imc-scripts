
#**************************************************************************
# Identification:enter_tmsh
# Purpose:       enter the "tmsh" mode on the device
#**************************************************************************

set timeout $standard_timeout

send "tmsh\r"
expect {
    -re "$error_pattern" {		   
		expect -re $exec_prompt
		set ERROR_RESULT  true
		set ERROR_MESSAGE "Fail to enter tmsh mode."
    } -re $tmsh_prompt {
        # OK
    }
}
