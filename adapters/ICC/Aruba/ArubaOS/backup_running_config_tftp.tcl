
#**************************************************************************
# Identification:backup_running_config_tftp
# Purpose:       backup running configuration by tftp
#**************************************************************************


set timeout $short_timeout
set WARNING_RESULT true
send "copy flash: flashbackup.tar.gz tftp: $TFTPServer $TFTPFile\r"
set loop true
while {$loop == "true"} {
    	expect {
       		-re $enable_prompt {
       		set loop false
       		} timeout {
           		set ERROR_RESULT true
           		set ERROR_MESSAGE "Failed to copy backup file to TFTP server."
           		set loop false
       		}
    	}
}
