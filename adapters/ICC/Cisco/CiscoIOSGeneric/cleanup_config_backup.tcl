
#**************************************************************************
# Identification:cleanup_config_backup
# Purpose:       Strip unwanted lines from backed up config
#**************************************************************************


#Deal with situation where TFTPfile may be passed as just file name, or whole path
set index1 [string last / $TFTPFile]
set len [string length $TFTPFile]
incr index1
set FileName [string range $TFTPFile $index1 $len]

#Get full path of working file
set TFTPFileLocal [pwd]
append TFTPFileLocal "/../tmp/"
append TFTPFileLocal $FileName
append TFTPFileLocal "working"

#Convert $Filename to full path
set TFTPFile [pwd]
append TFTPFile "/../tmp/"
append TFTPFile $FileName

file copy -force $TFTPFile $TFTPFileLocal

set infile [open $TFTPFileLocal r]
set outfile [open $TFTPFile w]

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

