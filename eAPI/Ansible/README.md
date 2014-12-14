# NetOps Ansible Module

This module is meant to be used in Ansible for automation.  Using Ansible, you could be deploying new devices, or taking active devices down for work (as in upgrades or restarts).  Initially, the module will be fairly simplistic allowing only a few basic actions:

* _Provision_ - This action is meant to add the device to Intelligent Management Center.  This action would be most useful, if you are deploying devices not yet added to IMC for management.
* _UnManage_ - This action is meant to unmanage a device.  At this time, IMC does not have a "scheduled maintenance" function to allow for downtime.  By "UnManage'ing" the device, you can suppress any notifications and/or alarms associated with that device.  This action is meant to be used prior to any downtime that is expected in the Ansible playbook.
* _Manage_ - If the Ansible playbook has an action to UnManage the device for downtime, then you should put the device back to "Manage" when done, so you can continue to get notifications and/or alarms.

## The Future Tasks

In the near future, a plugin is meant to be created, to allow the import of IMC devices into the inventory of Ansible.  As of right now, the device names must be manually entered.

In the not-so-distant future, but after the inventory plugin, plans will be made to do more specific tasks that IMC does well at.  Feature requests are encouraged, and can be entered in "Issues": https://github.com/NetOpsCommunity/imc-netops/issues

## Contributing to the code

At this time, we do not have a true "code convention" to place here.  For now, just fork the project, make your changes, commit with good log documentation, then submit a pull request from your fork.