These scripts are based upon the original F5 adapter scripts shipped with IMC 5.2

Changes made:

exit_tmsh.tcl was empty - it now contains "send 'quit\r'"

ftp_trans_file.tcl did not properly check for successful exit message from some FTP servers - we now exit successfully with "Transfer OK" message from FTP server.

Config_Backup XML files had references to TFTP files, but these did not exist - have removed references. Now only supports FTP as a file transfer mechanism.
