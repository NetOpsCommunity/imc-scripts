
#**************************************************************************
# Identification:initialize
# Purpose:       initialize variables
#**************************************************************************

set standard_timeout 12
set long_timeout 120
set very_long_timeout 1800
set very_very_long_timeout 2400
				
set username_prompt sername:
set password_prompt assword:
set enable_prompt #
set config_prompt )#
set enforce_save true
set timeout $standard_timeout
set more_prompt "Press any key to continue (Q to quit)"
set pause $more_prompt

set ERROR_RESULT false
set ERROR_MESSAGE ""
