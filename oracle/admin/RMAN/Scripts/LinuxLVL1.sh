#!/bin/sh
###########################################################################

ORACLE_BASE=/home/oracle/app                           ; export ORACLE_BASE
ORACLE_HOME=$ORACLE_BASE/product/10.2.0/db_1   ; export ORACLE_HOME
TNS_ADMIN=$ORACLE_HOME/network/admin            ; export TNS_ADMIN
NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1          ; export NLS_LANG
NLS_DATE_FORMAT=YYYY-MM-DD:hh24:mi:ss           ; export NLS_DATE_FORMAT
LD_LIBRARY_PATH=/home/oracle/app/product/10.2.0/db_1/lib:/lib:/usr/lib       ; export LD_LIBRARY_PATH
PATH=$PATH:$ORACLE_HOME/bin                     ; export PATH
ORACLE_SID=VTRPROD                              ; export ORACLE_SID
EDITOR=vi                                       ; export EDITOR
RMAN_LOG=/home/oracle/logs/rman                 ; export RMAN_LOG
FECHA=`date +%y%m%d`                            ; export FECHA


###########################################################################

rman catalog rman/oracle@rman target / log=$RMAN_LOG/rmanVTRPROD_inc_1_$FECHA.log<<EOF
run {
     sql 'alter system archive log current';
     change archivelog all validate;
     backup as compressed backupset incremental level=1 database include current controlfile format  '/u01/rman/VTRPROD/backup/bk0_%d_%s_%t_%U.bak' tag=Diario_Level1 archivelog all format '/u01/rman/VTRPROD/backup/arc_%d_%s_%T.bak';
     crosscheck backupset;
     crosscheck backup;
     crosscheck backup of controlfile;
     crosscheck archivelog all;
     crosscheck copy;
     crosscheck copy of database;
     crosscheck backup of archivelog all spfile;
     delete noprompt expired backup;
     delete noprompt obsolete;
    }
list backup summary;
EOF

date >> $RMAN_LOG/rmanVTRPROD_inc_1_$FECHA.log

#cat $RMAN_LOG/rmanVTRPROD_inc_0_$FECHA.log | mailx -s "Backup" dcabrera@ryaco.com