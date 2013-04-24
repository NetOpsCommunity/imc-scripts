
#**************************************************************************
# Identification:initialize
# Purpose:       initialize variables
#**************************************************************************

set standard_timeout 12
set long_timeout 120
set very_long_timeout 1800
set very_very_long_timeout 2400
set password_prompt assword:
set orig_exec_prompt >
set orig_enable_prompt #
set exec_prompt >
set enable_prompt #
set config_prompt )#
set enforce_save true
set timeout $standard_timeout
set more_prompt "Press any key to continue (Q to quit)"
set pause $more_prompt
set sent_password "false"
set banner_skip_repeat 0
set use_undeterministic_prompt "undeterministic prompt is not in use"
set tc_undeterministic_prompt ""
set banner_skip "(($password_prompt)|($username_prompt)|($exec_prompt)|($enable_prompt)){$banner_skip_repeat}"
set forceDisable "false"
set useTruePrompt "false"
set resetMorePrompting "true"

set ERROR_RESULT false
set ERROR_MESSAGE ""
