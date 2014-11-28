

class IMCTestDeviceData(object):

    DEVICELIST = """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<list>
  <device>
    <id>6</id>
    <label>device1</label>
    <ip>192.168.16.7</ip>
    <mask>255.255.255.255</mask>
    <status>0</status>
    <statusDesc>Unknown</statusDesc>
    <sysName>device1</sysName>
    <contact>Administrator;</contact>
    <location>US-TN-Franklin-Peak10</location>
    <sysOid>1.3.6.1.4.1.2.6.11</sysOid>
    <sysDescription></sysDescription>
    <devCategoryImgSrc>server</devCategoryImgSrc>
    <topoIconName>iconserver</topoIconName>
    <categoryId>2</categoryId>
    <symbolId>1010</symbolId>
    <symbolName>device1</symbolName>
    <symbolType>3</symbolType>
    <symbolDesc></symbolDesc>
    <symbolLevel>3</symbolLevel>
    <parentId>1009</parentId>
    <typeName>IBM OS/400</typeName>
    <mac>00:14:5e:52:7b:11</mac>
    <link op="GET" rel="self" href="http://test_imc:8080/imcrs/plat/res/device/6"/>
  </device>
  <device>
    <id>562</id>
    <label>switch1</label>
    <ip>192.168.16.1</ip>
    <mask>255.255.255.0</mask>
    <status>4</status>
    <statusDesc>Major</statusDesc>
    <sysName>switch1</sysName>
    <contact>Administrator</contact>
    <location>Peak10 Franklin, TN</location>
    <sysOid>1.3.6.1.4.1.2636.1.1.1.2.31</sysOid>
    <sysDescription></sysDescription>
    <devCategoryImgSrc>switch</devCategoryImgSrc>
    <topoIconName>iconswitch</topoIconName>
    <categoryId>1</categoryId>
    <symbolId>2172</symbolId>
    <symbolName>switch1</symbolName>
    <symbolType>3</symbolType>
    <symbolDesc></symbolDesc>
    <symbolLevel>2</symbolLevel>
    <parentId>1</parentId>
    <typeName>Juniper EX4200</typeName>
    <mac>b0:c6:9a:d5:9c:00</mac>
    <link op="GET" rel="self" href="http://test_imc:8080/imcrs/plat/res/device/562"/>
  </device>
  <device>
    <id>722</id>
    <label>server2</label>
    <ip>192.168.16.101</ip>
    <mask>255.255.255.0</mask>
    <status>1</status>
    <statusDesc>Normal</statusDesc>
    <sysName>server2</sysName>
    <contact></contact>
    <location></location>
    <sysOid>1.3.6.1.4.1.311.1.1.3.1.2</sysOid>
    <sysDescription></sysDescription>
    <devCategoryImgSrc>virtualdev</devCategoryImgSrc>
    <topoIconName>vnmvm</topoIconName>
    <categoryId>14</categoryId>
    <symbolId>2526</symbolId>
    <symbolName>server2</symbolName>
    <symbolType>3</symbolType>
    <symbolDesc></symbolDesc>
    <symbolLevel>3</symbolLevel>
    <parentId>2135</parentId>
    <typeName>Microsoft Windows Server</typeName>
    <mac>00:50:56:b4:1f:f4</mac>
    <link op="GET" rel="self" href="http://test_imc:8080/imcrs/plat/res/device/722"/>
  </device>
  <device>
    <id>731</id>
    <label>server3</label>
    <ip>192.168.16.100</ip>
    <mask>255.255.255.0</mask>
    <status>1</status>
    <statusDesc>Normal</statusDesc>
    <sysName>server3</sysName>
    <contact></contact>
    <location></location>
    <sysOid>1.3.6.1.4.1.311.1.1.3.1.2</sysOid>
    <sysDescription></sysDescription>
    <devCategoryImgSrc>virtualdev</devCategoryImgSrc>
    <topoIconName>vnmvm</topoIconName>
    <categoryId>14</categoryId>
    <symbolId>2556</symbolId>
    <symbolName>server3</symbolName>
    <symbolType>3</symbolType>
    <symbolDesc></symbolDesc>
    <symbolLevel>3</symbolLevel>
    <parentId>2135</parentId>
    <typeName>Microsoft Windows Server</typeName>
    <mac>00:50:56:b4:1f:f3</mac>
    <link op="GET" rel="self" href="http://test_imc:8080/imcrs/plat/res/device/731"/>
  </device>
  <device>
    <id>1013</id>
    <label>NetScaler</label>
    <ip>192.168.16.106</ip>
    <mask>255.255.255.0</mask>
    <status>1</status>
    <statusDesc>Normal</statusDesc>
    <sysName>NetScaler</sysName>
    <contact>WebMaster (default)</contact>
    <location>POP (default)</location>
    <sysOid>1.3.6.1.4.1.5951.1</sysOid>
    <sysDescription></sysDescription>
    <devCategoryImgSrc>netscalerdev</devCategoryImgSrc>
    <topoIconName>iconnetscalerdev</topoIconName>
    <categoryId>15</categoryId>
    <symbolId>13639</symbolId>
    <symbolName>NetScaler</symbolName>
    <symbolType>3</symbolType>
    <symbolDesc></symbolDesc>
    <symbolLevel>3</symbolLevel>
    <parentId>2135</parentId>
    <typeName>Citrix Netscaler Product</typeName>
    <mac>02:e0:ed:20:3b:a4</mac>
    <link op="GET" rel="self" href="http://test_imc:8080/imcrs/plat/res/device/1013"/>
  </device>
  <device>
    <id>1014</id>
    <label>192.168.16.12</label>
    <ip>192.168.16.12</ip>
    <mask>255.255.255.0</mask>
    <status>1</status>
    <statusDesc>Normal</statusDesc>
    <sysName></sysName>
    <contact></contact>
    <location></location>
    <sysOid></sysOid>
    <sysDescription></sysDescription>
    <devCategoryImgSrc>desktop</devCategoryImgSrc>
    <topoIconName>iconpc</topoIconName>
    <categoryId>9</categoryId>
    <symbolId>13643</symbolId>
    <symbolName>192.168.16.12</symbolName>
    <symbolType>3</symbolType>
    <symbolDesc></symbolDesc>
    <symbolLevel>3</symbolLevel>
    <parentId>2135</parentId>
    <typeName>ICMP</typeName>
    <mac>02:e0:ed:20:3b:a4</mac>
    <link op="GET" rel="self" href="http://test_imc:8080/imcrs/plat/res/device/1014"/>
  </device>
</list>
"""
    
    deviceManaged = """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<device>
  <id>562</id>
  <label>switch1</label>
  <ip>10.8.13.1</ip>
  <mask>255.255.255.0</mask>
  <status>4</status>
  <statusDesc>Major</statusDesc>
  <sysName>switch1</sysName>
  <contact>Administrator</contact>
  <location>Peak10 Franklin, TN</location>
  <sysOid>1.3.6.1.4.1.2636.1.1.1.2.31</sysOid>
  <runTime>380 day(s) 1 hour(s) 33 minute(s) 53 second(s) 750 millisecond(s)</runTime>
  <lastPoll>2014-11-25 17:29:20</lastPoll>
  <loginType>2</loginType>
  <sysDescription>Server Switch</sysDescription>
  <categoryId>1</categoryId>
  <supportPing>true</supportPing>
  <snmpTmplId>312</snmpTmplId>
  <telnetTmplId>311</telnetTmplId>
  <sshTmplId>311</sshTmplId>
  <configPollTime>120</configPollTime>
  <statePollTime>60</statePollTime>
  <symbolId>2172</symbolId>
  <symbolName>switch1</symbolName>
  <symbolType>3</symbolType>
  <symbolDesc></symbolDesc>
  <symbolLevel>2</symbolLevel>
  <parentId>1</parentId>
  <typeName>Juniper EX4200</typeName>
  <viewType>1</viewType>
  <positionX>776</positionX>
  <positionY>339</positionY>
  <visibleFlag>0</visibleFlag>
  <statusImg>common/icon_status_major_16x16.png</statusImg>
  <version></version>
  <mac>b0:c6:9a:d5:9c:00</mac>
  <categoryImg>switch</categoryImg>
  <vendorImg>common/icon_os_juniper-logo_16x16.png</vendorImg>
  <childrenNum>1</childrenNum>
  <vergeNet>1</vergeNet>
  <phyName></phyName>
  <phyCreateTime>2012-07-16 15:39:08</phyCreateTime>
  <phyCreator></phyCreator>
  <appendUnicode></appendUnicode>
  <snmpTmpl>http://imc_test:8080/imcrs/plat/res/snmp/312</snmpTmpl>
  <telnetTmpl>http://imc_test:8080/imcrs/plat/res/telnet/311</telnetTmpl>
  <sshTmpl>http://imc_test:8080/imcrs/plat/res/ssh/311</sshTmpl>
  <series>http://imc_test:8080/imcrs/plat/res/series/1006</series>
  <category>http://imc_test:8080/imcrs/plat/res/category/1</category>
  <model>http://imc_test:8080/imcrs/plat/res/model/1881</model>
  <interfaces>http://imc_test:8080/imcrs/plat/res/device/562/interface</interfaces>
</device>
"""
    deviceUnManagedList = """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<list>
  <device>
    <id>12</id>
    <label>router1</label>
    <ip>10.12.3.1</ip>
    <mask>255.255.255.0</mask>
    <status>-1</status>
    <statusDesc>Unmanaged</statusDesc>
    <sysName>router1</sysName>
    <contact>Admin</contact>
    <location>Location</location>
    <sysOid>1.3.6.1.4.1.9.1.566</sysOid>
    <sysDescription></sysDescription>
    <devCategoryImgSrc>router</devCategoryImgSrc>
    <topoIconName>iconroute</topoIconName>
    <categoryId>0</categoryId>
    <symbolId>1023</symbolId>
    <symbolName>router1</symbolName>
    <symbolType>3</symbolType>
    <symbolDesc></symbolDesc>
    <symbolLevel>2</symbolLevel>
    <parentId>1</parentId>
    <typeName>Cisco 851</typeName>
    <mac>00:24:14:a9:c2:20</mac>
    <link op="GET" rel="self" href="http://imc_test:8080/imcrs/plat/res/device/12"/>
  </device>
</list>
    """

    deviceUnManaged = """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<device>
  <id>12</id>
  <label>router1</label>
  <ip>10.12.3.1</ip>
  <mask>255.255.255.0</mask>
  <status>-1</status>
  <statusDesc>Unmanaged</statusDesc>
  <sysName>router1</sysName>
  <contact>Admin</contact>
  <location>Location</location>
  <sysOid>1.3.6.1.4.1.9.1.566</sysOid>
  <runTime>3 day(s) 7 hour(s) 7 minute(s) 9 second(s) 0 millisecond(s)</runTime>
  <lastPoll>2012-10-18 04:18:34</lastPoll>
  <loginType>2</loginType>
  <sysDescription>
    Cisco IOS Software, C850 Software (C850-ADVSECURITYK9-M), Version 12.4(15)T5, RELEASE SOFTWARE (fc4)&#xD;
    Technical Support: http://www.cisco.com/techsupport&#xD;
    Copyright (c) 1986-2008 by Cisco Systems, Inc.&#xD;
  Compiled Thu 01-May-08 02:07 by prod_rel_team</sysDescription>
  <categoryId>0</categoryId>
  <supportPing>true</supportPing>
  <snmpTmplId>108</snmpTmplId>
  <telnetTmplId>106</telnetTmplId>
  <sshTmplId>106</sshTmplId>
  <configPollTime>120</configPollTime>
  <statePollTime>60</statePollTime>
  <symbolId>1023</symbolId>
  <symbolName>router1</symbolName>
  <symbolType>3</symbolType>
  <symbolDesc></symbolDesc>
  <symbolLevel>2</symbolLevel>
  <parentId>1</parentId>
  <typeName>Cisco 851</typeName>
  <viewType>1</viewType>
  <positionX>0</positionX>
  <positionY>0</positionY>
  <visibleFlag>0</visibleFlag>
  <statusImg>common/icon_status_unmanaged_16x16.png</statusImg>
  <version>c850-advsecurityk9-mz.124-15.T5.bin</version>
  <mac>00:24:14:a9:c2:20</mac>
  <categoryImg>router</categoryImg>
  <vendorImg>common/icon_os_defaultVerdor_16x16.png</vendorImg>
  <childrenNum>1</childrenNum>
  <vergeNet>1</vergeNet>
  <phyName>router1</phyName>
  <phyCreateTime>2012-07-11 17:03:17</phyCreateTime>
  <phyCreator></phyCreator>
  <appendUnicode></appendUnicode>
  <snmpTmpl>http://test_imc:8080/imcrs/plat/res/snmp/108</snmpTmpl>
  <telnetTmpl>http://test_imc:8080/imcrs/plat/res/telnet/106</telnetTmpl>
  <sshTmpl>http://test_imc:8080/imcrs/plat/res/ssh/106</sshTmpl>
  <series>http://test_imc:8080/imcrs/plat/res/series/691</series>
  <category>http://test_imc:8080/imcrs/plat/res/category/0</category>
  <model>http://test_imc:8080/imcrs/plat/res/model/30538</model>
  <interfaces>http://test_imc:8080/imcrs/plat/res/device/12/interface</interfaces>
</device>
    """