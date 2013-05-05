
#**************************************************************************
# Identification:deploy_startup_config_ftp
# Purpose:       deploy startup configuration by ftp
#**************************************************************************

set timeout $very_long_timeout
send " execute restore config ftp $TFTPServer $TFTPFile $FTPUser $FTPPassword\r"
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
