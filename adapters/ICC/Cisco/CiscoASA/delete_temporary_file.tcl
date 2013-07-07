
set index1 [string last / $TFTPFile]
set len [string length $TFTPFile]
incr index1
set FileName [string range $TFTPFile $index1 $len]

send "delete /noconfirm flash:/$FileName\r"

set loop true
while {$loop == "true"} {
    expect {
       "\\?" {
           send "\r"
       } "confirm" {
           send "\r"
       } "bytes copied" {
           set loop false
       } "File not found" {
           set ERROR_RESULT true
           set ERROR_MESSAGE "File not found."
           set loop false
       } "No such file or directory" {
           set ERROR_RESULT true
           set ERROR_MESSAGE "No such file or directory."
           set loop false
       } "Error opening" {
           set ERROR_RESULT true
           set ERROR_MESSAGE "Error opening."
           set loop false
       } "Error copying" {
           set ERROR_RESULT true
           set ERROR_MESSAGE "Error copying."
           set loop false
       } "Error " {
           set ERROR_RESULT true
           set ERROR_MESSAGE "Error ."
           set loop false
       } $enable_prompt {
	  set loop false
       }
    }
}
