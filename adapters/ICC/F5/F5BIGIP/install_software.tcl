
#**************************************************************************
# Identification:install software
# Purpose:       install software via cli
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

send "install sys software image $TFTPFile volume $new_slot\r"
expect {
    -re "$error_pattern" {		   
		set ERROR_RESULT  true
		set ERROR_MESSAGE "Fail to enter tmsh mode."
		return
	} -re $tmsh_prompt {
        # OK
    }
}

sleep 5
#check result

while {true} {
    send "show sys software\r"
    expect $tmsh_prompt {
        set resp $expect_out(buffer)
        set posErr [string first "Error:" $resp]
        if {$posErr > 0} {
    		set ERROR_RESULT  true
    		set ERROR_MESSAGE "Fail to install software.Resp: $resp"
    		return
        }
        set pos [string first "installing" $resp]
        if {$pos > 0} {
            sleep 10
        } else {
            break
        }
    }
}

set timeout $standard_timeout
