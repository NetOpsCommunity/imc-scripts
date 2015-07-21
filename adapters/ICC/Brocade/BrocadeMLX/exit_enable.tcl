#**************************************************************************
# Identification:exit_enable
# Purpose:       exit the "enable" mode on the device
#**************************************************************************

send "exit\r"
expect {
	-re $exec_prompt {
	} -re $orig_exec_prompt {
		if {$useTruePrompt != "false"} {
			send "\r"
			expect -re "[\r\n]+([\S ]*?$orig_exec_prompt)"
			set exec_prompt expect_out(1,string)
		}
	}
}