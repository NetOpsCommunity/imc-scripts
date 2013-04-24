
#**************************************************************************
# Identification:deploy_running_config_tftp
# Purpose:       deploy running configuration by tftp
#**************************************************************************

set timeout $very_long_timeout
set WARNING_RESULT true

send "show admin telnet\r"
expect {
    -re "Telnet: ((up|down))" {
        set telnetstate $expect_out(1,string)
    } -re $prompt {
    }
}

expect -re $prompt

send "show admin snmp\r"
expect {
    -re "SNMP: ((up|down))" {
        set snmpstate $expect_out(1,string)
    } -re $prompt {
    }
}

expect -re $prompt

send "import config tftp://$TFTPServer/$TFTPFile\r"
expect {
	-re "Failed: (.*)" {
        set error $expect_out(1,string)
		set ERROR_MESSAGE "Failed: $error"
		set ERROR_RESULT true
		expect -re $prompt
	} "Invalid Scheme" {
        set ERROR_MESSAGE "Invalid scheme"
        set ERROR_RESULT true
        expect -re $prompt
	} -re "load_log_config: (.*)" {
        set error $expect_out(1,string)
        set ERROR_MESSAGE "Failed: $error"
        set ERROR_RESULT true
        expect -re $prompt
    } -re $prompt {
    }
}

send "set admin telnet $telnetstate\r"
expect -re $prompt

send "set admin snmp $snmpstate\r"
expect -re $prompt

if { $ERROR_RESULT != "true" && $ERROR_NONFATAL != "true" } {
	set WARNING_RESULT false
}
set timeout $standard_timeout