
#**************************************************************************
# Identification:backup_running_config_tftp
# Purpose:       backup running configuration by tftp
#**************************************************************************

set timeout $standard_timeout
send "upload config tftp://$TFTPServer/$TFTPFile\r"
expect $prompt
set timeout $standard_timeout
