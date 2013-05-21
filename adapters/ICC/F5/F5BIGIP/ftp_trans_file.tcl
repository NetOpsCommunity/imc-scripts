
#**************************************************************************
# Identification:ftp_trans_file
# Purpose:       transfer file via ftp
#**************************************************************************

proc ftp_trans_file {putFlag sourceFile destFile} {
    global ERROR_MESSAGE
    global ERROR_RESULT
    global exec_prompt
    global VpnName
    global TFTPServer
    global FTPUser
    global FTPPassword
    
    #clear old prompt
    sleep 1
    send "\r"
    sleep 1
    expect -re ".+"
    
    #ftp login
    set my_cmd "ftp $TFTPServer"
    if { $VpnName != "" } {
       append my_cmd " vpn-instance $VpnName"
    }
    send "$my_cmd\r"
    
    expect {
    	"unknown host" {
    		expect -re $exec_prompt
    		set ERROR_RESULT true
    		set ERROR_MESSAGE "unknown host."
    		return
    	} "Connection refused" {
    		expect -re $exec_prompt
    		set ERROR_RESULT true
    		set ERROR_MESSAGE "Connection refused."
    		return
    	} "Connection timed out" {
    		expect -re $exec_prompt
    		set ERROR_RESULT true
    		set ERROR_MESSAGE "Connection timed out."
    		return
    	} "bad port number" {
    		expect -re $exec_prompt
    		set ERROR_RESULT true
    		set ERROR_MESSAGE "bad port number."
    		return
    	} "usage:" {
    		expect -re $exec_prompt
    		set ERROR_RESULT true
    		set ERROR_MESSAGE "Error command."
    		return
    	} "connect:" {
    		expect -re $exec_prompt
    		set ERROR_RESULT true
    		set ERROR_MESSAGE "Error."
    		return
    	} "):" {
    	}
    }
    
    send "$FTPUser\r"
    expect "Password:"
    send "$FTPPassword\r"
    expect {
    	"Login failed" {
    		expect -re $exec_prompt
    		set ERROR_RESULT true
    		set ERROR_MESSAGE "Login failed."
    		return
    	} "ftp>" {
    	}
    }
    send "bin\r"
    expect "ftp>"
    
    if {$putFlag == true} {
        send "put $sourceFile $destFile\r"
    } else {
        send "get $sourceFile $destFile\r"
    }
    set loop true
    while {$loop == true} {
        expect {
        	"not a plain file" {
        		expect "ftp>"
        		send "quit\r"
        		set ERROR_RESULT true
        		set ERROR_MESSAGE "not a plain file."
        		return
        	} "File unavailable" {
        		expect "ftp>"
        		send "quit\r"
        		set ERROR_RESULT true
        		set ERROR_MESSAGE "File unavailable."
        		return
        	} "Invalid command" {
        		expect "ftp>"
        		send "quit\r"
        		set ERROR_RESULT true
        		set ERROR_MESSAGE "Invalid command."
        		return
        	} "No such file or directory" {
        		expect "ftp>"
        		send "quit\r"
        		set ERROR_RESULT true
        		set ERROR_MESSAGE "No such file or directory."
        		return
        	} "remote server has closed connection" {
        		expect "ftp>"
        		send "quit\r"
        		set ERROR_RESULT true
        		set ERROR_MESSAGE "remote server has closed connection."
        		return
        	} "Not connected" {
        		expect "ftp>"
        		send "quit\r"
        		set ERROR_RESULT true
        		set ERROR_MESSAGE "Not connected."
        		return
		}  "\n226 " {
        		set loop false
        		expect "ftp>"
        		send "quit\r"
        	} "File transfer successful." {
        		set loop false
        		expect "ftp>"
        		send "quit\r"
		} "Transfer OK" {
			set loop false
			expect "ftp>"
			send "quit\r"
        	} "ftp>" {
        		set loop false
        		send "quit\r"
        		set ERROR_RESULT true
        		set ERROR_MESSAGE "Unknown error."
        	}
        }
    }

    sleep 1

}
