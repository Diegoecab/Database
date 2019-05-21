#!/bin/sh

#######ExpDataPump ###############################################
#####Variables############################################################

ORACLE_HOME=/u01/app/oracle/product/10.2.0/db_1 ; export ORACLE_HOME
ORACLE_BASE=/u01/app/oracle ; export ORACLE_BASE
PATH_LOGS=/u04/backups/logs ; export PATH_LOGS
FECHA=`date +%y%m%d` ; export FECHA
PATH=$PATH$ORACLE_HOME/bin:$HOME/bin ; export PATH
DIRECT_BACKUP=/u04/backups/export

##########################################################################
##########################################################################

ORACLE_SID=VTRTEST ; export ORACLE_SID
NOMBRE_BASE=VTRTEST ; export NOMBRE_BASE
USUARIO=system; export USUARIO
PASSW=ryacovtr; export PASSW

VISTA_DATAFILES='v$datafile' ; export VISTA_DATAFILES
VISTA_CONTROLFILES='v$controlfile' ; export VISTA_CONTROLFILES
PTHTMP=/u04/backups/logs ; export PTHTMP

$ORACLE_HOME/bin/expdp $USUARIO/$PASSW full=yes dumpfile="export_full_"$FECHA"_"$NOMBRE_BASE".dmp" directory=export logfile=informes:"log_backup_full_"$FECHA"_"$NOMBRE_BASE".log"

#######Backup en frio ###############################################

echo    "       set serveroutput on     " >>$PTHTMP/cptemp.sql
echo    "       set feedback off        " >>$PTHTMP/cptemp.sql
echo    "       set heading off " >>$PTHTMP/cptemp.sql
echo    "       spool $PTHTMP/copia_dats.sh " >>$PTHTMP/cptemp.sql
echo    "       DECLARE " >>$PTHTMP/cptemp.sql
echo    "       CURSOR loc_cursor IS    " >>$PTHTMP/cptemp.sql
echo    "       select NAME     " >>$PTHTMP/cptemp.sql
echo    "       from $VISTA_DATAFILES   " >>$PTHTMP/cptemp.sql
echo    "       union   " >>$PTHTMP/cptemp.sql
echo    "       select NAME from $VISTA_CONTROLFILES;   " >>$PTHTMP/cptemp.sql
echo    "       BEGIN   " >>$PTHTMP/cptemp.sql
echo    "       FOR loc_record IN loc_cursor LOOP       " >>$PTHTMP/cptemp.sql
echo    "       dbms_output.put_line ('cp '||loc_record.NAME||' /u04/backups/cold/.');  " >>$PTHTMP/cptemp.sql
echo    "       END LOOP;       " >>$PTHTMP/cptemp.sql
echo    "       END;    " >>$PTHTMP/cptemp.sql
echo    "       /       " >>$PTHTMP/cptemp.sql
echo    "       spool off;      " >>$PTHTMP/cptemp.sql
echo    "       host date       " >>$PTHTMP/cptemp.sql
echo    "       prompt Comienzo de Cold Backup  " >>$PTHTMP/cptemp.sql
echo    "       prompt Bajando Base de datos ... " >>$PTHTMP/cptemp.sql
echo    "       shutdown immediate      " >>$PTHTMP/cptemp.sql
echo    "       host chmod 770 $PTHTMP/copia_dats.sh " >>$PTHTMP/cptemp.sql
echo    "       host date       " >>$PTHTMP/cptemp.sql
echo    "       prompt Copiando Archivos ... "  >>$PTHTMP/cptemp.sql
echo    "       host $PTHTMP/copia_dats.sh " >>$PTHTMP/cptemp.sql
echo    "       host date       " >>$PTHTMP/cptemp.sql
echo    "       prompt Fin de Copia de archivos ... " >>$PTHTMP/cptemp.sql
echo    "       prompt Levantando Base ... " >>$PTHTMP/cptemp.sql
echo    "       startup " >>$PTHTMP/cptemp.sql
echo    "       prompt Comprimiendo archivos ..." >>$PTHTMP/cptemp.sql
echo    "       host gzip -f /u04/backups/cold/* " >>$PTHTMP/cptemp.sql
echo    "       host gzip -f /u04/backups/export/export_full_$FECHA_$NOMBRE_BASE.dmp " >>$PTHTMP/cptemp.sql
echo    "       host date       " >>$PTHTMP/cptemp.sql
echo    "       Prompt Fin de Backup " >>$PTHTMP/cptemp.sql
echo    "       quit    " >>$PTHTMP/cptemp.sql

gzip -f /u04/backups/export/*.dmp

sqlplus / as sysdba @$PTHTMP/cptemp.sql >> $PTHTMP"/log_backup_full_"$FECHA"_"$NOMBRE_BASE".log"



rm $PTHTMP/cptemp.sql $PTHTMP/copia_dats.sh