#**************************************************************************
# Identification:deploy_image
# Purpose:       deploy image by tftp
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true
send "copy tftp flash $TFTPServer $TFTPFile $slot\r"
expect {
	-re "TFTP: re[cv]eived error request -- (.*)" {
		set error expect_out(1,string)
		set ERROR_MESSAGE "Could not copy from the TFTP server: $error"
		set ERROR_RESULT true
	} -re "File Type Check Failed" {
		set ERROR_MESSAGE "Could not copy from the TFTP server: File is not a valid image."
		set ERROR_RESULT true
	} -re "Invalid input" {
		set ERROR_MESSAGE "Could not copy from the TFTP server: Filename is malformed."
		set ERROR_RESULT true
	} -re "(TFTP.* Error .*)" {
		set error expect_out(1,string)
		set ERROR_MESSAGE "Could not copy from the TFTP server: $error"
		set ERROR_RESULT true
  } -re "(TFTP error .*)" {
		set error expect_out(1,string)
		set ERROR_MESSAGE "Could not copy from the TFTP server: $error"
		set ERROR_RESULT true
	} "TFTP to Flash Done" {
	}
}
expect $enable_prompt
			
set timeout $standard_timeout
if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}