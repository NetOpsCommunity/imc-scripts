This adapter has been modified to work with the Avaya ERS switches. It is a modification of the NortelERS adapter.

The key difference is that it now handles the initial Avaya connection screen - that uses "#"s to display
"AVAYA", and it was confusing the adapter.

It has also been updated to work with SSH, including storing/updating cached keys.

Note that it currently only does a "startup" configuration backup.

If the backup uses TFTP, it will transfer a binary backup file.

If the backup uses CLI, it will transfer an ASCII file.

To force IMC to use a CLI backup, set the file transfer mode for the AvayaERS switch to something other than
TFTP - then it will fall back to CLI.

To use this adapter, copy these files to <IMC>/server/conf/adapters/ICC/Nortel networks/, overwriting existing files.

Suggested enhancements:
* Create a backup_running_config_tftp.tcl that does an ASCII backup. Simple change from backup_running_startup_config_tftp.tcl - just use "copy running-config", not "copy config"

