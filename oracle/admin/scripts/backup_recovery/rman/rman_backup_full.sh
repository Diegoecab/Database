# ------------------------------------------------------------------------------
# File       : rman_backup_full.sh
# Purpose    : Oracle RMAN backup, restore or recovery helper: rman backup full.
# Category   : backup_recovery/rman
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./rman_backup_full.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
# Oracle Ver.: Review compatibility before production use.
# Risk       : REVIEW
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
run {
CONFIGURE CHANNEL DEVICE TYPE DISK MAXPIECESIZE 2G;
allocate channel d1 type disk;
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
allocate channel d5 type disk;
allocate channel d6 type disk;
allocate channel d7 type disk;
allocate channel d8 type disk;
allocate channel d9 type disk;
allocate channel d10 type disk;
BACKUP 
TAG = 'PRE_UPGRADE'
FORMAT '/backup/db/emrep_dbf_%d_%T_s%sp%p.%t'
DATABASE
CURRENT CONTROLFILE
  FORMAT '/backup/db/emrep_control_%d_C_%T_%u'
  SPFILE
  FORMAT '/backup/db/emrep_spfile_%d_S_%T_%u';
}



export ORAENV_ASK=NO
export ORACLE_SID=ibscn2
. oraenv
rman target / cmdfile=/home/oracle/scripts/ibscn/rman_full.rman log=/home/oracle/scripts/ibscn/rman_full.log



/home/oracle/scripts/ibscn/rman_full.sh