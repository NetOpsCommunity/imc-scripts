Custom Scripts and adapters for HP's Intelligent Management Center (IMC)

These scripts have been contributed by members of www.netopscommunity.net. They are provided free of charge, but with NO GUARANTEE WHATSOEVER. These are not officially supported by HP.

These scripts are intended to extend the capabilities of IMC, supporting devices that HP does not support out of the box. Core functions we hope to provide are for Configuration Backup and Restore. Anything else - software image management, VLAN management, etc - is a bonus.

In some cases, the scripts enhance functionality provided by HP - e.g. the Cisco adapter will strip out "ntp clock-period" from backups, to prevent false "config changed" alarms.

In other cases, the scripts fix something that was broken in the release code - e.g. the F5 scripts did not work out of the box. These scripts here have been tested with F5 3900 and 6900 models.

If you have any problems with any scripts, post it at www.netopscommunity.net, and we'll try to help.

To use the scripts, copy the desired vendor folder from adapters/ICC to your IMC server. Install it at /server/conf/adapters/ICC.

Note that the first time you install a new adapter, you will need to restart IMC. After that, you can make minor changes to the scripts, without restarting IMC.

If the sysObjectID is not currently known by IMC, you will also need to add the device model/series/vendor to IMC. Do this in the IMC GUI, at System -> Resource Management -> Device Model





You can also email lindsay.k.hill@gmail.com if you're having any problems.

====== eAPI Scripts =========

Scripts for the eAPI are located in the folder eAPI/ folder.  Each folder should have it's own README.TXT on how to use it, and what it is for.
