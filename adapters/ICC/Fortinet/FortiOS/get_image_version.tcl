#**************************************************************************
# Identification:get_software_version.tcl
# Purpose:       get device software version
#**************************************************************************

sleep 1


send "display boot-loader\r"
set loop true
set redo "false"

while {$loop == "true"} {
	expect {
		-re $more_prompt {
			send " "
		} -re "\n.+$error_pattern" {		  
    		set error_message $expect_out(1,string)
			expect -re $exec_prompt
			#set ERROR_RESULT  true
			#set ERROR_MESSAGE "Device error: $error_message"
			set redo "true"
			set loop false
		} -re $exec_prompt {
			# Done
			set loop false
		} 
	}		
}

if {$redo == "false"} {
	return
}

expect "*"
sleep 2

send "display boot\r"
set loop true

while {$loop == "true"} {
	expect {
		-re $more_prompt {
			send " "
		} -re "\n.+$error_pattern" {
    		set error_message $expect_out(1,string)
			expect -re $exec_prompt
			set ERROR_RESULT  true
			set ERROR_MESSAGE "Device error: $error_message"
			set loop false
		} -re $exec_prompt {
			# Done
			set loop false
		} 
	}		
}