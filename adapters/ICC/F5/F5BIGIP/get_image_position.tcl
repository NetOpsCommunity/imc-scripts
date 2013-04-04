
#**************************************************************************
# Identification:deploy_image_ftp
# Purpose:       deploy image via ftp
#**************************************************************************

set timeout $standard_timeout

send "show sys software\r"
expect {
    -re "$error_pattern" {
		set ERROR_RESULT  true
		set ERROR_MESSAGE "show sys software error."
		return
	} -re $tmsh_prompt {
        # OK
    }
}

