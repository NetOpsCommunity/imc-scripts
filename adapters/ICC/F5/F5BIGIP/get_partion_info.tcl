
#**************************************************************************
# Identification:deploy_image_ftp
# Purpose:       deploy image via ftp
#**************************************************************************

set timeout $standard_timeout

send "df -k\r"
expect {
    -re "$error_pattern" {		   
		expect -re $exec_prompt
		set ERROR_RESULT  true
		set ERROR_MESSAGE "Fail to df -k."
    } -re $exec_prompt {
        # OK
    }
}


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

send "show sys software\r"
expect {
    -re "$error_pattern" {
		set ERROR_RESULT  true
		set ERROR_MESSAGE "show sys software error."
		send "quit\r"
        expect $exec_prompt
		return
	} -re $tmsh_prompt {
        # OK
    }
}

send "quit\r"
expect $exec_prompt

