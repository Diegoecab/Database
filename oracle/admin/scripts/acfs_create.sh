login as: root
root@172.20.0.11's password:
Last login: Mon Sep 23 08:02:27 -03 2019 from ntb-lchapuis.local on pts/0
Last login: Mon Sep 23 09:26:41 2019 from ntb-lchapuis.local
[root@csjn1dbadm01 ~]#
[root@csjn1dbadm01 ~]#
[root@csjn1dbadm01 ~]# su - grid
Last login: Mon Sep 23 04:58:25 -03 2019
[grid@csjn1dbadm01 ~]$
[grid@csjn1dbadm01 ~]$ export ORACLE_HOME=/u01/app/18.0.0.0/grid
[grid@csjn1dbadm01 ~]$ export ORACLE_SID=+ASM1
[grid@csjn1dbadm01 ~]$ export PATH=$ORACLE_HOME/bin:$PATH
[grid@csjn1dbadm01 ~]$ asmcmd lsdg
State    Type  Rebal  Sector  Logical_Sector  Block       AU  Total_MB   Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
MOUNTED  HIGH  N         512             512   4096  4194304  94372096  85399932         10485760        24971334              0             Y  DATAC1/
MOUNTED  HIGH  N         512             512   4096  4194304  62908672  47502844          6989824        13504262              0             N  RECOC1/
[grid@csjn1dbadm01 ~]$ asmcmd volcreate -G RECOC1 -s 8T backup
[grid@csjn1dbadm01 ~]$ asmcmd volinfo -G RECOC1 backup
Diskgroup Name: RECOC1

         Volume Name: BACKUP
         Volume Device: /dev/asm/backup-185
         State: ENABLED
         Size (MB): 8388608
         Resize Unit (MB): 64
         Redundancy: HIGH
         Stripe Columns: 8
         Stripe Width (K): 1024
         Usage:
         Mountpath:

[grid@csjn1dbadm01 ~]$ asmcmd lsdg
State    Type  Rebal  Sector  Logical_Sector  Block       AU  Total_MB   Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
MOUNTED  HIGH  N         512             512   4096  4194304  94372096  85399932         10485760        24971334              0             Y  DATAC1/
MOUNTED  HIGH  N         512             512   4096  4194304  62908672  22336876          6989824         5115606              0             N  RECOC1/
[grid@csjn1dbadm01 ~]$ mkfs -t acfs /dev/asm/backup-185
mkfs.acfs: version                   = 18.0.0.0.0
mkfs.acfs: on-disk version           = 46.0
mkfs.acfs: volume                    = /dev/asm/backup-185
mkfs.acfs: volume size               = 8796093022208  (   8.00 TB )
mkfs.acfs: Format complete.
[grid@csjn1dbadm01 ~]$ logout
[root@csjn1dbadm01 ~]# mkdir /backup
[root@csjn1dbadm01 ~]# chown oracle.oinstall /backup
[root@csjn1dbadm01 ~]# /sbin/acfsutil registry -a /dev/asm/backup-185 /backup
acfsutil registry: mount point /backup successfully added to Oracle Registry
[root@csjn1dbadm01 ~]# mount -t acfs /dev/asm/backup-185 /backup
[root@csjn1dbadm01 ~]# df -h
Filesystem                    Size  Used Avail Use% Mounted on
devtmpfs                      756G     0  756G   0% /dev
tmpfs                         1.5T  4.0G  1.5T   1% /dev/shm
tmpfs                         756G  6.2M  756G   1% /run
tmpfs                         756G     0  756G   0% /sys/fs/cgroup
/dev/mapper/VGExaDb-LVDbSys1   30G   16G   13G  56% /
/dev/mapper/VGExaDb-LVDbOra1   99G   55G   39G  59% /u01
/dev/sda1                     488M   65M  388M  15% /boot
/dev/sda2                     254M   28M  227M  11% /boot/efi
/dev/asm/u02-185              4.0T  1.1T  3.0T  26% /u02
tmpfs                         152G     0  152G   0% /run/user/0
/dev/asm/backup-185           8.0T   17G  8.0T   1% /backup
[root@csjn1dbadm01 ~]#
