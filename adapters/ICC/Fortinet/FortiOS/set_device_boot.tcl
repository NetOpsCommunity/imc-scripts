
#**************************************************************************
# Identification:set_device_boot.tcl
# Purpose:       set the device next startup image by cli
#                don't support
#**************************************************************************

set timeout 10

#cmd: boot set-default flash primary/secondary
if { $slot != "" && $slot != "\x24slot" && $slot != "Default" } {
    if { [string first primary $slot] >= 0 } {
	    send "boot set-default flash primary\r"
	} else {
	   send "boot set-default flash secondary\r"
	}
	expect {
	   "y/n" {
	     send "y"
	     expect {
	         $enable_prompt {
		         return
		     }
		 }
	   }
	}
} else {
    return
}

expect {
	-re "(.*) error." {
		set error $expect_out(1,string)
		set ERROR_MESSAGE "Could not upload image: $error error."
		set ERROR_RESULT true
		expect $enable_prompt
		return
	} "Corrupted download file" {
		set ERROR_MESSAGE "Corrupt image could not be uploaded to the device."
		set ERROR_RESULT true
		expect $enable_prompt
		return
	} "Invalid input" {
		#set ERROR_MESSAGE "Incorrect command. Could not set device next boot image."
		#set ERROR_RESULT true
		expect $enable_prompt
    } "eer unreachable" {
		set ERROR_MESSAGE "Could not download image to the device. Peer unreachable."
        set ERROR_RESULT true
        expect $enable_prompt
        return
	} "already in progress" {
		set ERROR_MESSAGE "Could not download image to the device. File transfer already in progress."
        set ERROR_RESULT true
        expect $enable_prompt
        return
	} "Wrong file" {
		set ERROR_MESSAGE "Device error: Wrong file."
        set ERROR_RESULT true
        expect $enable_prompt			
        return
	} -re "y/n|you want to continue|Device will be|be rebooted" {
		# device will reload now 
	    send "y\r"
	    expect {
	        "y/n" {
	            send "y\r"
	        }
	    }
	    sleep 2
		#wait for reboot
	    close 
        return
	} $enable_prompt {
	   #use other command
	   return
	}
}
