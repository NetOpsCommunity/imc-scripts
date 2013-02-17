
#**************************************************************************
# Identification:deploy_image.tcl
# Purpose:       deploy image to device by cli
#**************************************************************************

set timeout $very_long_timeout
set right_arrow "\x1b[C"
set WARNING_RESULT true

# Download OS
send "7" 
expect {
	"Current Firmware revision" {
	} "Actions" {
	}
}

# The cursor should be on "Method [TYPE] : " Try to get a TFTP menu 
send "T"

# menu could already be on TFTP
sleep 1

# down arrow
send "\x1b\x5b\x42"  
expect "network address"
send "$TFTPServer"
send "\x1b\x5b\x42"  
expect {
		"name of the download image" {
	  } "elect the VLAN" {
		send "\x1b\x5b\x42"  
		expect "name of the download image"
	  }
	}
send "$TFTPFile"

send "\r"
#send "X"
send $right_arrow
send "\r"

expect {
	-re "error:.*msg: (.*)" {
		set error $expect_out(1,string)
		set ERROR_MESSAGE "Could not copy image to device: $error"
		set ERROR_RESULT true
	    send "\r"
	} -re "Aborted, wrong file" {
		set ERROR_MESSAGE "Could not upload image to device: Incorrect OS image file"
		set ERROR_RESULT true
	    send "\r"
	} -re "Aborted. (.*)" {
		set error $expect_out(1,string)
		set ERROR_MESSAGE "Could not upload image to device: $error"
		set ERROR_RESULT true
	    send "\r"
	} "Press any key to" {
		set ERROR_MESSAGE "An error occurred and the image was not accepted."
		set ERROR_RESULT true
		return
	} "Validating and Writing System Software" {	
	    # Device will reload now	
		sleep 120
	}
}

set timeout $standard_timeout
if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}			