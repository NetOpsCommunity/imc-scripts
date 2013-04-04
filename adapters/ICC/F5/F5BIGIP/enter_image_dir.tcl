
#**************************************************************************
# Identification:enter_image_dir
# Purpose:       enter the image dir
#**************************************************************************

set timeout $standard_timeout

send "cd /shared/images\r"
expect {
    -re "$error_pattern" {		   
		expect -re $exec_prompt
		set ERROR_RESULT  true
		set ERROR_MESSAGE "Fail to enter image dir."
    } -re $exec_prompt {
        # OK
    }
}
