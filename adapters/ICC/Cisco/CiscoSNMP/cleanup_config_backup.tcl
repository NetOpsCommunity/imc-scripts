
#**************************************************************************
#Identification:cleanup_config_backup
#Purpose:        Remove unnecessary lines from config backed up via SNMP
#**************************************************************************

set TFTPFileLocal [pwd]
append TFTPFileLocal "/../tmp/"
append TFTPFileLocal $TFTPFile
append TFTPFileLocal "working"

set TFTPFileFullPath [pwd]
append TFTPFileFullPath "/../tmp/"
append TFTPFileFullPath $TFTPFile

file copy -force $TFTPFileFullPath $TFTPFileLocal

set infile [open $TFTPFileLocal r]
set outfile [open $TFTPFileFullPath w]

while {[gets $infile line] >= 0} {

	if {[regexp "^ntp clock-period .*" $line]} {
       		# Strip out clock-period line, as it changes on each backup
        } else {
        	puts $outfile $line
        }
}

close $infile
close $outfile

file delete -force $TFTPFileLocal
