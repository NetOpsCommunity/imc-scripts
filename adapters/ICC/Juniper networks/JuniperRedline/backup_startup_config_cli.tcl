
#**************************************************************************
# Identification:backup_startup_config_cli
# Purpose:       backup startup configuration by cli
#**************************************************************************

send "display config\r"
expect {
	"Unknown keyword" {
		set ERROR_MESSAGE "Error attempting operation.  Bad command or invalid permissions."
		set ERROR_RESULT true
	} -re $prompt {
	}
}