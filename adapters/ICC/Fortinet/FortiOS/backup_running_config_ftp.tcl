
#**************************************************************************
# Identification:backup_running_config_ftp
# Purpose:       backup running configuration by ftp
#**************************************************************************

set timeout $standard_timeout
send "config global\r"
expect $exec_prompt
send "execute backup config ftp $TFTPFile $TFTPServer $FTPUser $FTPPassword\r"
expect $exec_prompt
set timeout $standard_timeout
