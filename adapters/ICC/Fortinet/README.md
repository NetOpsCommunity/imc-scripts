## Fortinet Adapter

*Note* HP now ships a "Fortigate" adapter, which does *not* include Config Backups.
That version should be combined with this adapter.

This adapter was contributed by Tomas Kubica.

It should work with any FortiOS 4. It has been tested with 100A and 310B FortiGate devices.

If you are using SCP for backups, you may need to run these commands on the Fortinets:
	config system global
	set admin-scp enable
	end

If you use SCP, it will get all configuration for all VDOMS. The TFTP and FTP scripts send "config global" first, so they should also retrieve config for all VDOMs.

Original Netops post here: http://www.netopscommunity.net/en\_GB/forums/-/message\_boards/message/36468


TODO:
 * Write a CLI adapter. Problem is that only command available seems to be "show full-configuration", which includes all default configs
	This makes it different to the other backup methods. Need to find way of showing config via CLI that only includes changes.
 * Test deployment scripts, with all methods. 
 * Image deployment - this exists, but has not been tested at all. Needs testing. Low priority.
