# ------------------------------------------------------------------------------
# File       : backup.sh
# Purpose    : Oracle administration helper: backup.
# Category   : utilities
# Author     : Diego Cabrera
# Created    : Unknown
# Version    : 1.0
# Usage      : ./backup.sh
# Parameters : Review script arguments and environment variables before running.
# Requires   : Oracle client tools and a configured Oracle OS environment.
# Oracle Ver.: Review compatibility before production use.
# Risk       : READ ONLY
# Output     : Shell/command output and any script-defined log files.
# Notes      : Validate in a non-production session before operational use.
# Source     : internal
# Change Log : 
# 2026-05-11 : Diego Cabrera - Header normalization.
# ------------------------------------------------------------------------------
#
numdiasem=`date +%u`
LOGFILE=/home/cierres/log/backup.log
LOGPATH=/home/cierres/log
#LOGFILE=/home/oracle/log/backup.log
#LOGPATH=/home/oracle/log
echo "-------------------------------------" >>$LOGFILE
echo "-------------------------------------" >>$LOGFILE
echo "Comienzo de backup" >>$LOGFILE
echo "-------------------------------------" >>$LOGFILE
echo "-------------------------------------" >>$LOGFILE
date >>$LOGFILE
echo "Ejecutando export full ..." >>$LOGFILE
/home/oracle/bin/expdp_database.sh GARDBOP FULL 1 GARBEXP $1 0
#/home/oracle/bin/expdp_database.sh GARDBOP DBAS 1 GARBEXP $1 0
date >>$LOGFILE
#echo "Numero de dia: " >>$LOGFILE
#echo $numdiasem >>$LOGFILE
if [ $numdiasem -eq 7 ] ; then
echo "Ejecutando backup FULL con RMAN ..." >>$LOGFILE
nohup /home/oracle/bin/rman_backup.sh GARDBOP WEEKLY ARCH $1 >> $LOGPATH/rman_backup_w.log 2>> $LOGPATH/rman_backup_w.err &
else
echo "Ejecutando backup level 1 con RMAN ..." >>$LOGFILE
nohup /home/oracle/bin/rman_backup.sh GARDBOP DAILY ARCH $1 >> $LOGPATH/rman_backup_d.log 2>> $LOGPATH/rman_backup_d.err &
fi
date >>$LOGFILE
echo "-------------------------------------" >>$LOGFILE
echo "-------------------------------------" >>$LOGFILE
echo "Fin de Backup" >>$LOGFILE
echo "-------------------------------------" >>$LOGFILE
echo "-------------------------------------" >>$LOGFILE