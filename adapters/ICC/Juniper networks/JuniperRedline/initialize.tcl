
#**************************************************************************
# Identification:initialize
# Purpose:       initialize variables
#**************************************************************************

set standard_timeout 12
set long_timeout 120
set very_long_timeout 1800
set squeeze_timeout 1500

set username_prompt ogin:
set password_prompt assword:
set orig_prompt %
set prompt ".*"
set minimum_role "administrator"
set enforce_save true
set timeout $standard_timeout
set more_prompt "[=More ("
set pause $more_prompt
set sent_password "false"
set banner_skip_repeat 0
set use_undeterministic_prompt "undeterministic prompt is not in use"
set tc_undeterministic_prompt ".*"
set banner_skip {($password_prompt)|($username_prompt)|($prompt)){$banner_skip_repeat}}
set useTruePrompt "false"

set ERROR_RESULT false
set ERROR_MESSAGE ""
