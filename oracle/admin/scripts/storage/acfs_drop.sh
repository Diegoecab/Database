# ------------------------------------------------------------------------------
# File       : acfs_drop.sh
# Purpose    : Oracle storage, ASM, ACFS or tablespace helper: acfs drop.
# Category   : storage
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./acfs_drop.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : REVIEW
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
/REMOTE_BKPS
    ACFS Version: 12.1.0.2.0
    on-disk version:       42.0
    flags:        MountPoint,Available
    mount time:   Mon Jan 27 16:57:44 2020
    allocation unit:       4096
    volumes:      1
    total size:   10995116277760  (  10.00 TB )
    total free:   6864124346368  (   6.24 TB )
    file entry table allocation: 24166400
    primary volume: /dev/asm/acfs_bkp-232
        label:
        state:                 Available
        major, minor:          248, 118785
        size:                  10995116277760  (  10.00 TB )
        free:                  6864124346368  (   6.24 TB )
        metadata read I/O count:         17060298
        metadata write I/O count:        1704280
        total metadata bytes read:       9386685440  (   8.74 GB )
        total metadata bytes written:    3012279296  (   2.80 GB )
        ADVM diskgroup         ACFS_VMS_DATA
        ADVM resize increment: 536870912
        ADVM redundancy:       mirror
        ADVM stripe columns:   8
        ADVM stripe width:     1048576
    number of snapshots:  0
    snapshot space usage: 0  ( 0.00 )
    replication status: DISABLED


srvctl stop filesystem -d /dev/asm/acfs_bkp-232


[root@rdp6adm01vm03 ~]# /sbin/acfsutil registry -d /REMOTE_BKPS
acfsutil registry: successfully removed ACFS mount point /REMOTE_BKPS from Oracle Registry
[root@rdp6adm01vm03 ~]#


/sbin/acfsutil rmfs /dev/asm/acfs_bkp-232




ASMCMD> volinfo --all
Diskgroup Name: DATA_HC3

         Volume Name: ACFS_UY
         Volume Device: /dev/asm/acfs_uy-117
         State: ENABLED
         Size (MB): 921600
         Resize Unit (MB): 512
         Redundancy: MIRROR
         Stripe Columns: 8
         Stripe Width (K): 1024
         Usage: ACFS
         Mountpath: /u01/acfs_uy

         Volume Name: BIN_PATCH
         Volume Device: /dev/asm/bin_patch-117
         State: ENABLED
         Size (MB): 51200
         Resize Unit (MB): 512
         Redundancy: MIRROR
         Stripe Columns: 8
         Stripe Width (K): 1024
         Usage: ACFS
         Mountpath: /patch

Diskgroup Name: ACFS_VMS_DATA

         Volume Name: ACFS_BKP
         Volume Device: /dev/asm/acfs_bkp-232
         State: ENABLED
         Size (MB): 10485760
         Resize Unit (MB): 512
         Redundancy: MIRROR
         Stripe Columns: 8
         Stripe Width (K): 1024
         Usage:
         Mountpath:

ASMCMD>


ASMCMD> voldisable -G ACFS_VMS_DATA ACFS_BKP

ASMCMD> voldelete -G ACFS_VMS_DATA ACFS_BKP