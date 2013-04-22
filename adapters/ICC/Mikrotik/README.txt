First, very rough cut at an adapter for Config Backups for Mikrotik devices.

* Uses CLI backups only, as file-based backups use binary format

* RouterOS_Cleanup_Parser_Script.pl needs overhaul, to cleanup the "extra" output that appears in the configs.
  Currently not doing any real parsing of the output. At a minimum, we should strip out lines starting with "#", and
 strip out the prompts + 'export' command that are visibile in the output.

* When adding the device to IMC, set the username as "<your_username>+cx" - by adding the "+cx", it tells the Mikrotik to NOT use colours in its output.
 I haven't tested it using colours - I don't know how it will behave. You have been warned.
