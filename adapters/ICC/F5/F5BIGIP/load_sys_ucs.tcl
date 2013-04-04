
#**************************************************************************
# Identification:save_sys_ucs
# Purpose:       save current configuration to ucs file
#**************************************************************************

set timeout $very_long_timeout
send "load sys ucs /var/local/ucs/imc_icc_f5_cfg.ucs\r"

set loop true
while {$loop == "true"} {
    expect {
        "y/n" {
            send "y\r"
        } "can't be found" {
            set loop false
            expect -re $tmsh_prompt
            set ERROR_RESULT  true
            set ERROR_MESSAGE "can't be found."    
        } "loading process failed" {
            set loop false
            expect -re $tmsh_prompt
            set ERROR_RESULT  true
            set ERROR_MESSAGE "loading process failed."    
        } -re "$error_pattern" {
            set loop false
            expect -re $tmsh_prompt
            set ERROR_RESULT  true
            set ERROR_MESSAGE "Fail to save current configuration to ucs file."
        } "is loaded" {
            #OK
            set loop false
            expect $tmsh_prompt
        }
    }
}

set timeout $standard_timeout
