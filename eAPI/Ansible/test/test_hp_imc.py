#!/usr/bin/python
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

import unittest
from Ansible.modules.hp_imc import *

class TestAnsibleIMCModule(unittest.TestCase):

    def setUp(self):
        unittest.TestCase.setUp(self)
        host = "10.200.0.95"
        port = "8080"
        username = "admin"
        passwd = "admin"
        self.imc_conn = IMCConnection(host,port,username,passwd)

    def test_IMCConnection(self):
        data = self.imc_conn.get("http://usnassrv53.cd.corp:8080/imcrs")
        self.assertEqual(data.getcode(),200)


    if __name__ == '__main__':
        unittest.main()