These files should be applied on top of the F5 adapter that shipped with IMC 5.2 Patch 5 (E0401P05)

Changes made:

adapter-index.xml - configuration backups have been tested with the 1600, so its sysOID has been added. Probably others will work too.

save_sys_ucs.tcl did not match the file save output on 1600s using 10.2.4. This has been updated to also match that pattern - other systems
should be unaffected

ftp_trans_file.tcl did not properly check for successful exit message from some FTP servers - we now match more patterns, and look for the "226" FTP code
This should work for most FTP servers, as 226 means "Closing data connection. Requested file action successful"

Note that the adapter shipped with 5.2-base had references to TFTP backup files that did not exist. These now ship with 5.2 Patch 05. This patch also
fixed the problem with exit_tmsh.tcl being empty. You should install that patch before adding these files
