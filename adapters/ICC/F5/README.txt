These files should be applied on top of the F5 adapter that shipped with IMC 7.0 E0202

Changes made:

ftp_trans_file.tcl did not properly check for successful exit message from some FTP servers - we now match more patterns, and look for the "226" FTP code
This should work for most FTP servers, as 226 means "Closing data connection. Requested file action successful"

Note that the adapter shipped with 5.2-base had references to TFTP backup files that did not exist. These now ship with 5.2 Patch 05. This patch also
fixed the problem with exit_tmsh.tcl being empty. You should install that patch before adding these files
