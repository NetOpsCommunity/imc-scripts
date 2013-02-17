
#**************************************************************************
# Identification:backup_running_config_tftp
# Purpose:       backup running configuration by tftp
#**************************************************************************

set timeout $standard_timeout
send "execute backup config tftp $TFTPFile $TFTPServer\r"
expect $prompt
set timeout $standard_timeout