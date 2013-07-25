
#**************************************************************************
# Identification:backup_running_config_ftp
# Purpose:       backup running configuration by ftp
#**************************************************************************

set timeout $standard_timeout
send "upload config ftp://$FTPUser:$FTPPassword@$TFTPServer//$TFTPFile\r"
expect $prompt
set timeout $standard_timeout
