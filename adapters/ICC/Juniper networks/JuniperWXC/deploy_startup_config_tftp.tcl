
#**************************************************************************
# Identification:deploy_startup_config_tftp
# Purpose:       deploy startup configuration by tftp
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true

send "copy tftp://$TFTPServer/$TFTPFile cfg/CONFIG.cfg\r"
    expect {
	"Invalid URL" {
		set ERROR_MESSAGE "The TFTP server or filename is invalid or can't be found"
		set ERROR_RESULT true
		expect $enable_prompt
	} "Do you wish to overwrite it? yes/no" {
		# If you've done this before, then "CONFIG" will already exist; device
		# will ask if you want to overwrite it.... yes
		send "yes\r"
		expect $enable_prompt
	} $enable_prompt {
		# Success
	}
}

send "load-config CONFIG\r"

# Device asks if you're sure
expect "Are you sure? yes/no"
send "yes\r"

expect {
	"Cannot" {
		# Failure
		set ERROR_MESSAGE "The configuration file could not be loaded"
		set ERROR_RESULT true
		expect $enable_prompt
	} "Configuration loaded successfully" {
		# Success
	}
}

expect $enable_prompt

send "commit\r"
    expect $enable_prompt

if { $ERROR_RESULT != "true" && $ERROR_NONFATAL != "true" } {
	set WARNING_RESULT false
}
set timeout $standard_timeout