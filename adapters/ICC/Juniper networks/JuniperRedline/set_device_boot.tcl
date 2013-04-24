
#**************************************************************************
# Identification:set_device_boot.tcl
# Purpose:       set the device next startup image by cli
#**************************************************************************

set WARNING_RESULT true

# send "set boot $newpart\r"

send "set boot $TFTPFile\r"
expect {
    "set boot" {
        set ERROR_RESULT true
        set ERROR_MESSAGE "Invalid syntax"
    } "Invalid partition number" {
        set ERROR_RESULT true
        set ERROR_MESSAGE "Invalid partition number"
    } -re $prompt {
    }
}

if { $ERROR_RESULT != "true" } {
	set WARNING_RESULT false
}