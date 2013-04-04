
#**************************************************************************
# Identification:initialize
# Purpose:       initialize variables
#**************************************************************************

set standard_timeout 20
set long_timeout 120
set very_long_timeout 1800
set very_very_long_timeout 2400

set username_prompt "ogin as:"
set password_prompt assword:
set exec_prompt #
set sftp_exec_prompt sftp>
set tmsh_prompt "\\)#"
set sent_password false
set timeout $standard_timeout
set more_prompt {---(less}
set error_pattern {((Error:|error:|command not found|unknown|not a shell builtin|argument required|too many arguments|syntax error).*)}