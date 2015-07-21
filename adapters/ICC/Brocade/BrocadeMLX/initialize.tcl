#**************************************************************************
# Identification:initialize
# Purpose:       initialize variables
#**************************************************************************

set standard_timeout 10
set long_timeout 30
set very_long_timeout 100
set timeout $standard_timeout
set username_prompt {(User ?[Nn]ame:|Please Enter Login Name)}
set password_prompt "Password:"
set orig_exec_prompt ">"
set orig_enable_prompt "#"
set exec_prompt ">"
set enable_prompt "#"
set config_prompt "\)#"
set pause_prompt "--More--"
set pause $pause_prompt
set asked_for_username false
set enforce_save true
set banner_skip_repeat 0
set useTruePrompt false
set banner_skip {([\s\S]*?($exec_prompt)|($enable_prompt)){$banner_skip_repeat}}