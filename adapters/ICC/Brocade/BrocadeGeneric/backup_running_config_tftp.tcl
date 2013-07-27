
#**************************************************************************
# Identification:backup_running_config_tftp
# Purpose:       backup running configuration by tftp
#**************************************************************************


set timeout $standard_timeout
set WARNING_RESULT true
send "copy $runningConfig tftp $TFTPServer $TFTPFile\r"
expect -re $enable_prompt
