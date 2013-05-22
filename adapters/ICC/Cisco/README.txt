These adapters is based upon the adapters written by HP.

The CiscoIOSGeneric adapter has been modified to strip out "ntp clock-period" from the stored backup files.

This is so that IMC doesn't alarm on every configuration change, as the "ntp clock-period" line 
frequently changes by itself.

These have been tested out against a Cisco IOS switch, and appear to work for TFTP, FTP, CLI, SCP 
backup methods. It does NOT currently work for backups done using SNMP read/write.

The CiscoIOSGeneric adapter uses a centralised "cleanup_config_backup" script, which is 
automatically called by the Cisco_Config_Backup_Builder.xml script. By doing it this way,
we leave the default *.tcl files alone. The only changes are to add an extra step to the 
Config_Backup_Builder.xml file, and to add the new script file.

The CiscoSNMP adapter should call a cleanup script after running the backup. Currently this is 
not working. The logs indicate it can't find the cleanup_config_backup_.tcl script, although all
paths appear correct. Further investigation is needed - it may be that the SNMP adapters can't
use TCL scripts. There doesn't seem to be any documentation for SNMP adapters.

For more info, see this thread:
http://www.netopscommunity.net/en_GB/forums/-/message_boards/message/54616

The CiscoASA adapter has been modified to properly strip out the "<--- More --->" prompts seen when 
doing a backup via CLI. There was also a bug with the parsing of the startup configuration, where it 
would be truncated at the last extended ACL entry. This is because if you do a "show run", the last line
is ": end", but if you do a "show startup", the last line is the Crypto checksum.
All other files are left at default for the ASA adapter - you only need to copy CiscoASA/CiscoASA_Cleanup_Parser_Script.pl
to your CiscoASA adapter directory.

TODO: 
 * Change the ASA startup/running CLI adapters to display the snmp community-strings. This can be done with 
"more system:running-config". If you use "show running-config" - as these scripts do - then community strings
are masked.
 * There is also some further tidy-up worked required to cleanup the files backed up via SCP, to ensure that the backups
look identical, regardless of if they are backed up via CLI or SCP. This should also help eliminate false positives
with config change detection
