
"""
HP Intelligent Management Center External Ansible Inventory Script

Used to build an inventory of devices and groups for Ansible actions/playbooks dynamically
generated at run-time from Intelligent Management Center

To use, configure the hp_imc.ini file with the appropriate configurations
"""

import ConfigParser
import os,sys

try:
    import json
except:
    import simplejson as json


class IMCInventory(object):

    def __init__(self):
        self.username = None
        self.password = None
        self.serverUrl = None

        # Load Configuration File
        self.loadConfig()

        # Check for valid configuration
        if self.username and self.password and self.serverUrl:
            pass
        else:
        # Could not load required variables
            print >> sys.stderr, "Error: Configuration not valid in hp_imc.ini"


    def loadConfig(self):
        config = ConfigParser.SafeConfigParser
        config.read(os.path.dirname(os.path.realpath(__file__)) + '/hp_imc.ini')

        self.username = config.get('hp_imc','username')
        self.password = config.get('hp_imc','password')
        self.serverUrl = config.get('hp_imc','master_imc')

    def getInventory(self):


if __name__ == '__main__':
    imc_inventory = IMCInventory()