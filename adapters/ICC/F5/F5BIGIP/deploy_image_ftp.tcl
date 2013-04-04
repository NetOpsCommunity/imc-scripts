
#**************************************************************************
# Identification:deploy_image_ftp
# Purpose:       deploy image via ftp
#**************************************************************************

set timeout $standard_timeout
send "dir /shared/images\r"
expect {
    "No such file or directory" {
        send "mkdir -p /shared/images\r"
        expect $exec_prompt
    } $exec_prompt {
        #exist
    }
}

set timeout $very_very_long_timeout
set DestFile "/shared/images/$DestTFTPFile"

ftp_trans_file false $TFTPFile $DestFile

set timeout $standard_timeout
