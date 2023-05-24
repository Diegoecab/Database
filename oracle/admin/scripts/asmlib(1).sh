[grid@rgmadbp1751 ~]$ $ORACLE_HOME/bin/kfod asm_diskstring='ORCL:*' disks=all
KFOD-00301: Unable to contact Cluster Synchronization Services (CSS). Return code 2 from kgxgncin.
KFOD-00305: asmlib initialization error [driver/agent not installed]
[grid@rgmadbp1751 ~]$




[root@rgmadbp1751 dev]# rpm -qa --last | grep asm | sort
kmod-oracleasm-2.0.8-15.el6_9.x86_64          Fri 18 Oct 2019 07:55:05 PM -03
oracleasmlib-2.0.12-1.el6.x86_64              Thu 01 Jun 2017 07:11:37 PM -03
oracleasm-support-2.1.10-4.el6.x86_64         Fri 18 Oct 2019 07:47:46 PM -03
[root@rgmadbp1751 dev]# ssh rgmadbp1752
Last login: Tue Jan 14 17:17:34 2020 from rgmadbp1751.dtvpan.com
[root@rgmadbp1752 ~]# rpm -qa --last | grep asm | sort
kmod-oracleasm-2.0.8-15.el6_9.x86_64          Fri 18 Oct 2019 10:37:59 PM -03
oracleasmlib-2.0.12-1.el6.x86_64              Sat 19 Oct 2019 12:05:32 AM -03
oracleasm-support-2.1.11-2.el6.x86_64         Sat 19 Oct 2019 12:05:32 AM -03
[root@rgmadbp1752 ~]# rpm -qi kmod-oracleasm
Name        : kmod-oracleasm               Relocations: (not relocatable)
Version     : 2.0.8                             Vendor: Oracle America
Release     : 15.el6_9                      Build Date: Wed 22 Mar 2017 11:36:13 AM -03
Install Date: Fri 18 Oct 2019 10:37:59 PM -03      Build Host: x86-ol6-builder-04.us.oracle.com
Group       : System Environment/Kernel     Source RPM: oracleasm-2.0.8-15.el6_9.src.rpm
Size        : 119267                           License: GPLv2
Signature   : RSA/8, Wed 22 Mar 2017 11:18:01 AM -03, Key ID 72f97b74ec551f03
URL         : http://www.kernel.org/
Summary     : oracleasm kernel module(s)
Description :
This package provides the oracleasm kernel modules built for
the Linux kernel 2.6.32-696.el6.x86_64 for the x86_64
family of processors.
[root@rgmadbp1752 ~]#


[root@rgmadbp1751 dev]# rpm -qi kmod-oracleasm
Name        : kmod-oracleasm               Relocations: (not relocatable)
Version     : 2.0.8                             Vendor: Oracle America
Release     : 15.el6_9                      Build Date: Wed 22 Mar 2017 11:36:13 AM -03
Install Date: Fri 18 Oct 2019 07:55:05 PM -03      Build Host: x86-ol6-builder-04.us.oracle.com
Group       : System Environment/Kernel     Source RPM: oracleasm-2.0.8-15.el6_9.src.rpm
Size        : 119267                           License: GPLv2
Signature   : RSA/8, Wed 22 Mar 2017 11:18:01 AM -03, Key ID 72f97b74ec551f03
URL         : http://www.kernel.org/
Summary     : oracleasm kernel module(s)
Description :
This package provides the oracleasm kernel modules built for
the Linux kernel 2.6.32-696.el6.x86_64 for the x86_64
family of processors.
[root@rgmadbp1751 dev]#



oracleasm restart
oracleasm status
oracleasm enable
oracleasm init