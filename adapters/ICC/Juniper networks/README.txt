This adapter is very closely based upon the version published with IMC 5.2.

Changes are:

* sysoid for SRX-110VA added to adapter-index.xml - uses JuniperGeneric adapter

* enter_exec.tcl modified to store new SSH key in cache

* JuniperGeneric/Juniper_Config_Backup_Builder.xml edited to return "result name='running_configuration'" under action name backup_running_config. 
Juniper only has the one configuration to return. This change will make it return the same configuration for both running and startup, but it will avoid errors in IMC.

* This adapter only works for CLI-based backups. The TFTP backup may work, but has not been tested. It should only work for systems using Telnet.

If you are having problems with your Juniper devices, install this adapter, over-writing the existing files. Restart IMC.

You may also need to delete/re-add your device to IMC if it is not correctly picking up the new adapter.

TODO:
* Maybe we should return the current configuration as running_config, and the previous config as the startup_configuration ?

* Enable/test/fix the SCP adapter - it was commented out by HP, so clearly needs some testing/work.

* Remove the TFTP adapter? Or test it to ensure it works?
