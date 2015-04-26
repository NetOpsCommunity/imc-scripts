Second cut at an adapter for Config Backups for Mikrotik devices.

* Uses CLI backups only, as file-based backups use binary format

* RouterOS\_Cleanup\_Parser\_Script.pl has been overhauled in this release to remove unwanted lines, and to re-join lines that
  get split by RouterOS. This looks like it is working well, but it needs testing in more environments

* When adding the device to IMC, set the username as "<your_username>+cx" - by adding the "+cx", it tells the Mikrotik to NOT use colours in its output.
 I haven't tested it using colours - I don't know how it will behave. You have been warned.
