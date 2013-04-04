
#**************************************************************************
# Identification:deploy_image_ftp
# Purpose:       deploy image via ftp
#**************************************************************************

set timeout $long_timeout

set new_slot $slot
set len [string length $slot]
set last_ [string last "/" $slot]
incr last_
if {$last_ == $len} {    
	  incr last_ -2
    set new_slot [string range $slot 0 $last_]
} 

send "switchboot -b $new_slot\r"
expect {
    -re "$error_pattern" {		   
		set ERROR_RESULT  true
		set ERROR_MESSAGE "Fail to switchboot to $new_slot."
		return
	} "not a valid" {
		set ERROR_RESULT  true
		set ERROR_MESSAGE "$new_slot is not a valid boot location."
		return
	} -re $exec_prompt {
        # OK
    }
}

set timeout $standard_timeout
