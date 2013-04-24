
#**************************************************************************
# Identification:enter_enable
# Purpose:       enter the "enable" mode on the device
#**************************************************************************

# Device does not support Telnet, only SSH
# Nas has already logged us in; expect the prompt

expect $enable_prompt