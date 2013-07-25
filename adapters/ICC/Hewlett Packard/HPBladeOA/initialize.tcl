
#**************************************************************************
# Identification:initialize
# Purpose:       initialize variables
#**************************************************************************

set env(TERM) vt100
set standard_timeout 20
set long_timeout 120
set very_long_timeout 1800
set very_very_long_timeout 2400

set tftpDelay 10
set imageDelay 60
set username_prompt ogin:
set password_prompt assword:
set more_prompt "--More--"
set prompt "> "
set enforce_save true
set timeout $standard_timeout


set skip_ctrl_u "true"
set forceDisable "false"
set useTruePrompt "false"
set ERROR_RESULT "false"
set resetMorePrompting "true"

