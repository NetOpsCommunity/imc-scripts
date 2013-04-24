
#**************************************************************************
# Identification:enter_config_term
# Purpose:       enter the "config_term" mode on the device
#**************************************************************************

send "config\r"
expect {
	"Error:" {
		set ERROR_MESSAGE "The user is not authorized to enter configuration mode."
		set ERROR_RESULT true
		expect $enable_prompt
	} $config_prompt {
	}
}