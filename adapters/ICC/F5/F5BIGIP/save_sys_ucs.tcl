
#**************************************************************************
# Identification:save_sys_ucs
# Purpose:       save current configuration to ucs file
#**************************************************************************

set timeout $long_timeout
send "save sys ucs /var/local/ucs/imc_icc_f5_cfg.ucs\r"

set loop true
while {$loop == "true"} {
    expect {
        "y/n" {
            send "y\r"
        } "No such file or directory" {
            set loop false
            expect -re $tmsh_prompt
            set ERROR_RESULT  true
            set ERROR_MESSAGE "No such file or directory."    
        } -re "$error_pattern" {
            set loop false
            expect -re $tmsh_prompt
            set ERROR_RESULT  true
            set ERROR_MESSAGE "Fail to save current configuration to ucs file."
        } "is saved" {
            #OK
            set loop false
            expect $tmsh_prompt
        } "Saving active configuration..." {
            #OK
            set loop false
            expect $tmsh_prompt
        }
    }
}

set timeout $standard_timeout
