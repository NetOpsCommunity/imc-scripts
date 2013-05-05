This adapter was contributed by Tomas Kubica.

It should work with any FortiOS 4. It has been tested with 100A and 310B FortiGate devices.

If you are using SCP for backups, you may need to run these commands on the Fortinets:
	config system global
	set admin-scp enable
	end

If you use SCP, it will get all configuration for all VDOMS. The TFTP and FTP scripts send "config global" first, so they should also retrieve config for all VDOMs.

Original Netops post here: http://www.netopscommunity.net/en_GB/forums/-/message_boards/message/36468


TODO:
 * Test FTP backups - adapter has not been fully tested
 * Write a CLI adapter. Needs to send "config global" followed by "show full-configuration". Also needs Parser script sorted out
 * Test deployment scripts, with all methods. 
 * Image deployment - this exists, but has not been tested at all. Needs testing. Low priority.
