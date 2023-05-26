 lsblk
sdf                       8:80   0   50G  0 disk



 asmcmd afd_label ORA_DATA_03 /dev/sdf
No devices to be labeled.
ASMCMD-9513: ASM disk label set operation failed.


[root@orastechdbdev99 ~]# cat /etc/oracleafd.conf
afd_diskstring='/dev/sd*1'
[root@orastechdbdev99 ~]#


[root@orastechdbdev99 ~]# asmcmd afd_lsdsk
--------------------------------------------------------------------------------
Label                     Filtering   Path
================================================================================
ORA_DATA_01                 ENABLED   /dev/sdc1
ORA_DATA_02                 ENABLED   /dev/sdd1
ORA_FRA_01                  ENABLED   /dev/sde1
[root@orastechdbdev99 ~]#


asmcmd afd_label ORA_DATA_03 /dev/sdf


[root@orastechdbdev99 ~]# asmcmd afd_lsdsk
--------------------------------------------------------------------------------
Label                     Filtering   Path
================================================================================
ORA_DATA_01                 ENABLED   /dev/sdc1
ORA_DATA_02                 ENABLED   /dev/sdd1
ORA_DATA_03                 ENABLED   /dev/sdf
ORA_FRA_01                  ENABLED   /dev/sde1
[root@orastechdbdev99 ~]#



[grid@orastechdbdev99 ~]$ kfod disks=all
--------------------------------------------------------------------------------
 Disk          Size Path                                     User     Group
================================================================================
   1:      51199 MB AFD:ORA_DATA_01
   2:      51199 MB AFD:ORA_DATA_02
   3:      51200 MB AFD:ORA_DATA_03
   4:      51199 MB AFD:ORA_FRA_01
--------------------------------------------------------------------------------
ORACLE_SID ORACLE_HOME
================================================================================
      +ASM /oracle/app/grid/product/grid
[grid@orastechdbdev99 ~]$




[grid@orastechdbdev99 ~]$ kfod disks=all
--------------------------------------------------------------------------------
 Disk          Size Path                                     User     Group
================================================================================
   1:      51199 MB AFD:ORA_DATA_01
   2:      51199 MB AFD:ORA_DATA_02
   3:      51200 MB AFD:ORA_DATA_03
   4:      51199 MB AFD:ORA_FRA_01
--------------------------------------------------------------------------------
ORACLE_SID ORACLE_HOME
================================================================================
      +ASM /oracle/app/grid/product/grid
[grid@orastechdbdev99 ~]$


sudo echo 1 > /sys/block/sdf/device/rescan


[root@orastechdbdev99 ~]# lsblk| grep sdf
sdf                       8:80   0  100G  0 disk
[root@orastechdbdev99 ~]#




[root@orastechdbdev99 ~]# asmcmd afd_refresh --all



[root@orastechdbdev99 ~]#
[root@orastechdbdev99 ~]#
[root@orastechdbdev99 ~]#
[root@orastechdbdev99 ~]# kfod disks=all
--------------------------------------------------------------------------------
 Disk          Size Path                                     User     Group
================================================================================
   1:      51199 MB AFD:ORA_DATA_01
   2:      51199 MB AFD:ORA_DATA_02
   3:      51200 MB AFD:ORA_DATA_03
   4:      51199 MB AFD:ORA_FRA_01
--------------------------------------------------------------------------------
ORACLE_SID ORACLE_HOME
================================================================================
      +ASM /oracle/app/grid/product/grid
[root@orastechdbdev99 ~]#
[root@orastechdbdev99 ~]#
[root@orastechdbdev99 ~]# asmcmd afd_refresh
[root@orastechdbdev99 ~]# asmcmd afd_scan
[root@orastechdbdev99 ~]# asmcmd afd_lsdsk
--------------------------------------------------------------------------------
Label                     Filtering   Path
================================================================================
ORA_DATA_01                 ENABLED   /dev/sdc1
ORA_DATA_02                 ENABLED   /dev/sdd1
ORA_DATA_03                 ENABLED   /dev/sdf
ORA_FRA_01                  ENABLED   /dev/sde1
[root@orastechdbdev99 ~]# kfod disks=all
--------------------------------------------------------------------------------
 Disk          Size Path                                     User     Group
================================================================================
   1:      51199 MB AFD:ORA_DATA_01
   2:      51199 MB AFD:ORA_DATA_02
   3:     102400 MB AFD:ORA_DATA_03
   4:      51199 MB AFD:ORA_FRA_01
--------------------------------------------------------------------------------
ORACLE_SID ORACLE_HOME
================================================================================
      +ASM /oracle/app/grid/product/grid
[root@orastechdbdev99 ~]#


SQL> alter diskgroup DIEGODB_DATA resize all;

Diskgroup altered.

SQL>


