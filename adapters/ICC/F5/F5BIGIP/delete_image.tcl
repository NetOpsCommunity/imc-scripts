
#**************************************************************************
# Identification:deploy_image_ftp
# Purpose:       deploy image via ftp
#**************************************************************************

set timeout $long_timeout
send "rm -f /shared/images/$TFTPFile\r"
expect $exec_prompt
