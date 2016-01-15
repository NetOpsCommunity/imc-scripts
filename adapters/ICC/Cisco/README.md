These adapters are based upon the adapters written by HP, and shipped with 7.2 E0403

Only these files included here have been changed. All others are left at default.

You should install IMC 7.2 E0403 before making these modifications

adapter-index.xml has been updated to support CiscoACE devices

The CiscoIOSGeneric adapter has been modified to strip out "ntp clock-period" from the stored backup files.

This is so that IMC doesn't alarm on every configuration change, as the "ntp clock-period" line 
frequently changes by itself.

These have been tested out against a Cisco IOS switch, and appear to work for TFTP, FTP, CLI, SCP 
backup methods. It does NOT currently work for backups done using SNMP read/write.

The CiscoIOSGeneric adapter uses a centralised "cleanup\_config\_backup" script, which is 
automatically called by the Cisco\_Config\Backup\Builder.xml script. By doing it this way,
we leave the default \*.tcl files alone. The only changes are to add an extra step to the 
Config\_Backup\_Builder.xml file, and to add the new script file.

The CiscoSNMP adapter should call a cleanup script after running the backup. Currently this is 
not working. The logs indicate it can't find the cleanup\_config\_backup.tcl script, although all
paths appear correct. Further investigation is needed - it may be that the SNMP adapters can't
use TCL scripts. There doesn't seem to be any documentation for SNMP adapters.

For more info, see this thread:
http://www.netopscommunity.net/en\_GB/forums/-/message\_boards/message/54616

We previously included modifications to the CiscoASA adapter to ensure that temporary files were deleted.
HP has now resolved this in IMC v7. You should update to an HP-supported version of this adapter.

TODO
 * Figure out a way to run post-processing scripts with SNMP-based adapters
