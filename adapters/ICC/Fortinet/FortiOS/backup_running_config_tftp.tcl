
#**************************************************************************
# Identification:backup_running_config_tftp
# Purpose:       backup running configuration by tftp
#**************************************************************************

set timeout $standard_timeout
send "config global\r"
expect $exec_prompt
send "execute backup config tftp $TFTPFile $TFTPServer\r"
expect $exec_prompt
set timeout $standard_timeout
