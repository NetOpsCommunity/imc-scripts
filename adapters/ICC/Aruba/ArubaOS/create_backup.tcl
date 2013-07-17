
send "backup flash\r"

set loop true
while {$loop == "true"} {
    expect {
       -re $enable_prompt {
           set loop false
       } timeout {
           set ERROR_RESULT true
           set ERROR_MESSAGE "Backup command timed out."
           set loop false
       }
    }
}
