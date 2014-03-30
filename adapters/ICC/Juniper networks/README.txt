This adapter is very closely based upon the version published with IMC 7.0 (E0202)

You should install this version of IMC before installing these files. Only changed files are
distributed - all others are left as original.

Changes are:

* sysoid for SRX-110VA and SRX-650 added to adapter-index.xml - uses JuniperGeneric adapter

If you are having problems with your Juniper devices, install this adapter, over-writing the existing files. Restart IMC.

Re-synchronize any SRX-110 or SRX-650 devices, then try running a backup again.

TODO:
* Maybe we should return the current configuration as running_config, and the previous config as the startup_configuration ?

* Enable/test/fix the SCP adapter - it was commented out by HP, so clearly needs some testing/work.

* Remove the TFTP adapter? Or test it to ensure it works?
