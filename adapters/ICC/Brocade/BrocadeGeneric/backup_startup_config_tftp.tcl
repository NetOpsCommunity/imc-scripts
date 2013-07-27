
#**************************************************************************
# Identification:backup_startup_config_tftp
# Purpose:       backup startup configuration by tftp
#**************************************************************************


set timeout $standard_timeout
set WARNING_RESULT true
send "copy startup-config tftp $TFTPServer $TFTPFile\r"
expect -re $enable_prompt 
