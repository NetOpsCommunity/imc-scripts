# Updated Brocade adapter - support for Vyatta, MLX & NOS (VDX)

This is v3.0 of the Brocade Vyatta, MLX + NOS adapter for IMC.

IT HAS ONLY HAD LIMITED TESTING!!!!

To use this updated adapter, copy adapter-index.xml and the Vyatta, BrocadeMLX & BrocadeNOS 
directories to (IMC)/server/conf/adapters/Brocade

You must also update the IMC Device Model definitions for the MLX devices.
Go to Settings -> Device Series, and add "Brocade MLX", under vendor Brocade.
Then go to Settings -> Device Model, and add the MLX-4 & MLX-8.
MLX-4 sysoid: 1.3.6.1.4.1.1991.1.3.44.3.2
MLX-8 sysoid: 1.3.6.1.4.1.1991.1.3.44.2.2

If you do not add these under "Brocade", they will be listed as Foundry Generic,
and IMC will not find the right adapter.

## Vyatta

It supports TFTP, FTP and CLI backups for running & startup.

It only supports SCP for startup backups (so far as I know, it's not possible
to pull the running config from Vyatta via SCP)

## NOS/VDX

This adapter supports TFTP, FTP & CLI backups for running & startup config.
It does not support SCP/SFTP backups.

CLI backups have been tested. TFTP & FTP backups should work, but this has
not been fully tested.

Code is in place for configuration deployment, but has not been tested.

## MLX

This adapter supports SCP, TFTP & CLI backup & deployment.
Only SCP & CLI backups have been tested so far.

Deployment should work via SCP, but needs testing.

Image deployment has not yet been tested.
