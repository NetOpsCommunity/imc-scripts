Two adapters here, for HP-Branded Brocade Fibre Channel SAN switches, and C7000 Onboard Administrators

The HPFabricOS adapter is a direct copy of the files used for the Brocade/FabricOS adapter.

The HPBladeOA adapter can backup Blade Enclosure Onboard Administrators via FTP, TFTP or CLI.
Only the FTP and TFTP adapters have been tested. The CLI adapter HAS NOT BEEN TESTED!
It may work, but it needs checking. Don't just blindly run it.

More error checking also needs to be added to the HPBladeOA adapters - currently they 
just assume that the TFTP or FTP upload has completed. Needs to be tested to find out
what sort of error messages you might see when a TFTP/FTP upload fails.

This package also includes an updated adapter-index.xml file, which contains sysOID references 
pointing to the new adapters. This was based on IMC 7.0 E0102L03.
