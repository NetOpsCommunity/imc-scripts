# Updated Foundry/Brocade ICX Adapter v1.0

This adapter is an updated version of the adapter that ships with IMC 7.1E0303P13.

Changes include:

* Added support for SCP configuration deployment and backup

* Fixed CLI adapter - this had multiple issues - invalid expect syntax, missing cleanup.tcl,
  missing code in the Cleanup Parser Script, etc. 

This adapter can also be used for MLX devices, if the sysoids are added to adapter-index.xml.
Preference is for these to use the Brocade/BrocadeMLX adapter (it is the same code as here)

To use this adapter, copy the FoundryNetIron directory to (IMC)/server/conf/adapters/ICC/Foundry
