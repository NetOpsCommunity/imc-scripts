
#**************************************************************************
# Identification:deploy_startup_config_tftp
# Purpose:       deploy startup configuration by tftp
#**************************************************************************

set timeout $very_long_timeout
send " execute restore config tftp $TFTPServer $TFTPFile\r"
expect {
	"?" {
		send "y"
		set timeout $standard_timeout
		sleep $tftpDelay
	} $prompt {
		set ERROR_RESULT true
		set ERROR_MESSAGE "An error occurred. The TFTP file may not have been accepted by the device."
	}
}
set timeout $standard_timeout