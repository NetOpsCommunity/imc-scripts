Second version of adapter for Citrix Netscaler systems.

It has been tested against a VPX running NS10.0, build 71.6

Currently it seems to be working for CLI backups.

SFTP backups _should_ work for startup configuration, however we observed that running configuration backup may then fail if the device is switched to SFTP mode.

We need to figure out a way to log into the device, and save the running configuration as a file somewhere, so that it can be retrieved via SCP/SFTP. Not sure how to achieve this. The 
saved configuration is stored as a file, but we haven't found a way to do the equivalent of "show ns runningConfig > /tmp/icc_running.cfg"

Adapters could also be written to use FTP and TFTP fot the saved configuration. You would need to first go into "shell" mode, then you can run tftp/ftp commands from the shell.
There is low demand for unencrypted file transfer, so this is not a priority.

Changes in this version:
* Citrix_Cleanup_Parser_Script.pl has been improved to better tidy up the output. It also strips out the "Last modified by" line from the configuration.
  This line changes every time show ns runningConfig is run, which makes it useless for config difference reporting.
  Currently we are using one function (cleanupConfiguration) for parsing both startup and running Configs.
  TODO: Implement separate cleanup function for both startup and running configurations. Leave the "Last modified by" line in the startup config
	This will make it work consistently should we switch to pulling configuration via SCP/SFTP
