#!/usr/bin/python
# -*- coding: utf-8 -*-

# (c) 2014, Aaron Paxson <aj@thepaxson5.org>
#
# This module is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this software.  If not, see <http://www.gnu.org/licenses/>.

import urllib2
from ansible.module_utils.basic import *
import urllib
import xml.etree.ElementTree as ET

DOCUMENTATION = '''
---
module: hp_imc
short_description: Performs monitoring, provisioning, and configuration functions inside HP IMC for the device
description:
  - The M(hp_imc_monitoring) module currently has two basic functions: Unmanage/Manage a device to prevent notifications/polling during scheduled maintenance.
  - This module can also auto-provision a new device into IMC.
  - All actions require either I(hostname) parameter, the I(dev_id) parameter, or the I(ip_addr) parameter of the device.
  - In playbooks you can use the C({{inventory_hostname}}) or the C({{ansible_default_ipv4.address}}) variables in a playbook.
  - When using the M(hp_imc_monitoring) module you will need to specify your IMC Master server using the I(imc_host) parameter.
  - The I(imc_user) and I(imc_pass) refer to a user account that has permissions for the action being performed.
version_added: "0.1"
options:
  action:
    description:
      - Action to take.
    required: true
    default: null
    choices: [ "unmanage", "manage", "provision" ]
  hostname:
    description:
      - Name of the host in IMC
    required: false
    default: null
  dev_id:
    description:
      - Device ID of the host in IMC
    required: false
    default: null
  ip_addr:
    description:
      - IP Address of the host in IMC
    required: false
    default: null
  imc_host:
    description:
      - IMC Master server managing the device.  IP Addresses or fully-qualifed name accepted.
    required: true
    default: null
  imc_user:
    description:
      - Username with permissions for action on IMC Master server.
    required: true
    default: admin
  imc_pass:
    description:
      - Password for IMC Username
    required: true
    default: null
  imc_port:
    description:
      - Web port of the IMC Master Server
    required: true
    default: 8080


author: Aaron Paxson <aj@thepaxson5.org>
requirements: [ "HP Intelligent Management Center eAPI" ]
'''

EXAMPLES = '''
# Unmanage a device to prevent notices
- hp_imc_monitoring: action=unmanage hostname={{ inventory_hostname }} imc_host=1.2.3.4 imc_user=admin imc_pass=pass

# Unmanage a device using IMC Device ID
- hp_imc_monitoring: action=unmanage dev_id=516 imc_host=1.2.3.4 imc_user=admin imc_pass=pass

# Manage a device that is previously unmanaged
- hp_imc_monitoring: action=manage hostname={{ inventory_hostname }} imc_host=1.2.3.4 imc_user=admin imc_pass=pass

# Manage a device that is previously unmanaged using the fact: Default IPv4 Address variable
- hp_imc_monitoring: action=manage hostname={{ansible_default_ipv4.address}} imc_host=1.2.3.4 imc_user=admin imc_pass=pass

'''

def main():
    ACTION_CHOICES = [
        'manage',
        'unmanage',
        'provision',
        ]

    module = AnsibleModule(
        argument_spec=dict(
            action=dict(required=True, default=None, choices=ACTION_CHOICES),
            imc_user=dict(required=True, default='admin'),
            imc_host=dict(required=True, default=None),
            imc_pass=dict(required=True, default='admin'),
            hostname=dict(required=False, default=None),
            dev_id=dict(required=False, default=None),
            imc_port=dict(required=True, default=8080)
            )
        )

    action = module.params['action']
    imc_user = module.params['imc_user']
    imc_host = module.params['imc_host']
    imc_pass = module.params['imc_pass']
    hostname = module.params['hostname']
    dev_id = module.params['dev_id']
    imc_port = module.params['imc_port']

    imc_ansible_mod = IMCServer(module,**module.params)
    imc_ansible_mod.run()

class IMCServer(object):
    def __init__(self, module, **kwargs):
        self.module = module
        self.action = kwargs['action']
        self.imc_user = kwargs['imc_user']
        self.imc_host = kwargs['imc_host']
        self.imc_pass = kwargs['imc_pass']
        self.hostname = kwargs['hostname']
        self.dev_id = kwargs['dev_id']
        self.imc_port = kwargs['imc_port']

        self.imc_master = IMCConnection(self.imc_host,self.imc_port,self.imc_user.self,self.imc_pass)

    def run(self):
        # Used to run the module.  Identify what we need to do
        if self.action == 'manage':
            return
        elif self.action == 'unmanage':
            return
        elif self.action == 'provision':
            return
        return

class IMCDevice(object):

    def __init__(self):
        self.dev_id = None
        self.ip_addr = None
        self.hostname = None
        self.imc_conn = IMCConnection()

    def isManaged(self):
        # Check if system is currently managed or not
        # Always use deviceID if specified.  Build the URL
        if self.dev_id is not None:
            urlpath = "/imcrs/plat/res/device/" + self.dev_id
        elif self.ip_addr is not None:
            urlpath = "/imcrs/plat/res/device?ip=" + self.ip_addr
        else:
            urlpath = "/imcrs/plat/res/device?label=" + self.hostname



    def isProvisioned(self):
    # Check if the system is currently provisioned or not
        return

    def getDevId(self):
        # Get the DeviceID in IMC from the IP Address or system name
        return


class IMCConnection(object):

    def __init__(self, host, port, user, passwd):
        self.host = host
        self.port = port
        self.username = user
        self.passwd = passwd

        imcWebURI = "http://" + self.host + ":" + self.port
        auth_handler = urllib2.HTTPDigestAuthHandler()
        auth_handler.add_password(
            realm='iMC RESTful Web Services',
            uri = imcWebURI,
            user = self.username,
            passwd=self.passwd
        )
        opener = urllib2.build_opener(auth_handler)
        urllib2.install_opener(opener)

    def get(self,url):
        return urllib2.urlopen(url)

    def put(self,url,data):
        data_encoded = urllib.urlencode(data)
        return urllib2.urlopen(url,data_encoded).read()





