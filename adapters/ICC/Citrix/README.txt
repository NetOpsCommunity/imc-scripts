This is a first draft at getting a working adapter for Citrix Netscalers.

It has been tested against a VPX running NS10.0, build 71.6

Currently it is "mostly" working for CLI backups.

SFTP backups _should_ work for startup configuration, however we observed that running configuration backup may then fail if the device is switched to SFTP mode.

We need to figure out a way to log into the device, and save the running configuration as a file somewhere, so that it can be retrieved via SCP/SFTP. Not sure how to achieve this. The 
saved configuration is stored as a file, but we haven't found a way to do the equivalent of "show ns runningConfig > /tmp/icc_running.cfg"

Adapters could also be written to use FTP and TFTP fot the saved configuration. You would need to first go into "shell" mode, then you can run tftp/ftp commands from the shell.

Again, we're not sure how to do this for the running config.

One bug seen for backups with IMC 5.1 is that it seems to only keep the first, and then the last copy of the startup configuration - we seem to be losing other startup configuration references.
This has not yet been tested with IMC 5.2. 
