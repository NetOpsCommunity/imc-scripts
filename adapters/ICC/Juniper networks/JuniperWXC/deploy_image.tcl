
#**************************************************************************
# Identification:deploy_image_cli.tcl
# Purpose:       deploy image to device by cli
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true

send "upgrade tftp://$TFTPServer/$TFTPFile\r"
expect "Are you sure? yes/no"
send "yes\r"

    expect {
	"Upgrade failed: (.*)" {
		set ERROR_RESULT true
		set ERROR_MESSAGE "Could not copy image from TFTP server. Image did not exist or content was invalid."
		expect $enable_prompt
	} "Invalid URL" {
		set ERROR_RESULT true
		set ERROR_MESSAGE "Could not copy image from TFTP server. File did not exist on server."
		expect $enable_prompt
	} "Do you wish to proceed? yes/no" {
		# Message pops up when you revert to an old version
		send "yes\r"

		# At this point... the upgrade is assured barring network failure
		expect "Upgrade successful"
		} "Upgrade successful" {
		# Successful; ignore the ###'s in the download when we look for the prompt later
	}			
}

# Enable prompt will follow the above error messages			
expect "*"
expect $enable_prompt

set timeout $standard_timeout
if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}			