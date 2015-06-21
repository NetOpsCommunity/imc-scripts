# Vyatta Adapter

This is v2.0 of the Vyatta adapter for IMC.

IT HAS ONLY HAD VERY LIMITED TESTING!!!!

It supports TFTP, FTP and CLI backups for running & startup.

It only supports SCP for startup backups (so far as I know, it's not possible
to pull the running config from Vyatta via SCP)

To use, copy the adapter-index.xml and Vyatta directory to (IMC)/server/conf/adapters/Brocade
