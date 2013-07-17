
send "delete filename flashbackup.tar.gz\r"

set loop true
while {$loop == "true"} {
    expect {
       -re $enable_prompt {
           set loop false
       } timeout {
           set ERROR_RESULT true
           set ERROR_MESSAGE "Something went wrong deleting backup file."
           set loop false
       }
    }
}
