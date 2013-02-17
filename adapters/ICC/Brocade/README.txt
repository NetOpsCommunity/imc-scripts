Initial adapter written by Lindsay Hill (lindsay.k.hill@gmail.com)

This was tested with FabricOS 6.2 and 6.4 systems. Backups only. No pushing configs. It uses SSH or Telnet to connect to a device and run configshow -all.

You'll notice that the backup_startup_config just calls the backup_running_config scripts - so the startup and running configs are exactly the same. 

Someone could write a function to do backup_running_config_ftp if they feel like it, as Brocade supports "configupload", to push a config to remote FTP/SCP server.

Absolutely no guarantees with this, but it would be nice if a few other people could test it out, and give me some feedback/make improvements. The testing so far is very, very basic. Test it thoroughly yourself.

Where the Brocade switches are in HP Blade Enclosures, they may show up as "HP Generic Fibre Channel Switches", or similar. In that case, IMC will use the default HP adapter of HPProcurve2500. Seems that you can't change a system-defined sysOID, so those switches will always have a vendor of HP. If you have these switches, you will need to edit the adapter-index.xml in C:\Program Files\IMC\server\conf\adapters\ICC\Hewlett Packard\, and add a stanza for your sysOIDs. Copy the FabricOS directory from the Brocade adapter directory to the HP directory. 

I noticed that if I change the adapter that a device should use, it doesn't seem to take effect, even with an iMC restart. I ended up deleting and re-adding the devices. There may be some way of forcing a refresh of the device/adapter association, but I don't know what it is.

Original netopscommunity post here: http://www.netopscommunity.net/en_GB/forums/-/message_boards/message/38231
