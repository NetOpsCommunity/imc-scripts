This adapter was contributed by Tomas Kubica.

It should work with any FortiOS 4. It has been tested with 100A and 310B FortiGate devices.

If you are using SCP for backups, you may need to run these commands on the Fortinets:
	config system global
	set admin-scp enable
	end

If you use SCP, it will get all configuration for all VDOMS. If you are not using SCP, it may not retrieve all configuration. The file backup_running_config_tftp.tcl may need to be extended, to send "sconfig global" before running the backup.

Original Netops post here: http://www.netopscommunity.net/en_GB/forums/-/message_boards/message/36468
