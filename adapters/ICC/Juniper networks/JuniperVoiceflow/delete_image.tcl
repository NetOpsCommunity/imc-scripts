
#**************************************************************************
# Identification:delete_image.tcl
# Purpose:       delete image file
#**************************************************************************

set WARNING_RESULT true	
send "software-version\r"
expect $config_prompt

send "delete $TFTPFile\r"
expect {
	"Cannot delete currently active" {
		set ERROR_MESSAGE "Cannot delete file $TFTPFile.  It is currently active version"
		set ERROR_RESULT true
		send "\r"						
	} $config_prompt {
		send "\r"
	}
}
expect $config_prompt

send "exit\r"
expect $enable_prompt


if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}