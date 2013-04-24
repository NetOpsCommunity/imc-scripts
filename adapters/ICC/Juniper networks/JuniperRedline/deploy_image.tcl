
#**************************************************************************
# Identification:deploy_image_cli.tcl
# Purpose:       deploy image to device by cli
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true

send "show boot\r"
expect {
    -re "Boot (\\d) \(cur,act\): .*" {
        set part $expect_out(1,string)
        if {$part == "1"} {
            set newpart 2
        } else {
            set newpart 1
        }
    }
}
expect -re $prompt

send "set admin tftp server $TFTPServer\r"
expect {
    -re "Error: (.*)" {
        set error $expect_out(1,string)
        set ERROR_RESULT true
        set ERROR_MESSAGE "Error: $error"
    } -re $prompt {
    }
}

send "set admin upgrade filename $TFTPFile\r"
expect {
    -re "Error: (.*)" {
        set error $expect_out(1,string)
        set ERROR_RESULT true
        set ERROR_MESSAGE "Error: $error"
    } -re $prompt {
    }
}

send "write\r"
expect -re $prompt

send "install\r"
expect {
    -re "(This command may only .*)" {
        set error $expect_out(1,string)
        set ERROR_RESULT true
        set ERROR_MESSAGE "Error: $error"
    } "like to continue" {
        send "y\r"
        expect {
            -re "Error: (.*)" {
                set error $expect_out(1,string)
                set ERROR_RESULT true
                set ERROR_MESSAGE "Error: $error"
            } -re $prompt {
            }
        }
    } -re $prompt {
    }
}

set timeout $standard_timeout
if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}			