#!/bin/sh

#####Variables############################################################

FECHA=`date +%y%m%d` ; export FECHA
NOMBRE_BASE=prod01 ; export NOMBRE_BASE
USUARIO=system; export USUARIO
PASSW=ryacovtr; export PASSW

VISTA_DATAFILES='v$datafile' ; export VISTA_DATAFILES
VISTA_TMP_DATAFILES='v$tempfile' ; export VISTA_TMP_DATAFILES
VISTA_CONTROLFILES='v$controlfile' ; export VISTA_CONTROLFILES
PTHTMP=/opt/oracledb/backup/prod01/scripts ; export PTHTMP
ORACLE_SID=prod01; export ORACLE_SID
ORACLE_HOME=/home/users/sambausers/oracle/OraHome_DB; export ORACLE_HOME
PATH=$PATH:$ORACLE_HOME/bin; export  PATH
rm -f /opt/oracledb/backup/prod01/*.*

#######Cold Backup ########################################################

echo    "       set serveroutput on     " >>$PTHTMP/cptemp.sql
echo    "       set feedback off        " >>$PTHTMP/cptemp.sql
echo    "       set heading off " >>$PTHTMP/cptemp.sql
echo    "       spool $PTHTMP/copia_dats.sh " >>$PTHTMP/cptemp.sql
echo    "       DECLARE " >>$PTHTMP/cptemp.sql
echo    "       CURSOR loc_cursor IS    " >>$PTHTMP/cptemp.sql
echo    "       select NAME     " >>$PTHTMP/cptemp.sql
echo    "       from $VISTA_DATAFILES   " >>$PTHTMP/cptemp.sql
echo    "       union   " >>$PTHTMP/cptemp.sql
echo    "       select NAME from $VISTA_CONTROLFILES   " >>$PTHTMP/cptemp.sql
echo    "       union   " >>$PTHTMP/cptemp.sql
echo    "       select NAME from $VISTA_TMP_DATAFILES;  " >>$PTHTMP/cptemp.sql
echo    "       BEGIN   " >>$PTHTMP/cptemp.sql
echo    "       FOR loc_record IN loc_cursor LOOP       " >>$PTHTMP/cptemp.sql
echo    "       dbms_output.put_line ('cp -rf '||loc_record.NAME||' /opt/oracled                                                                             b/backup/prod01/.');  " >>$PTHTMP/cptemp.sql
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
echo    "       host gzip -f /opt/oracledb/backup/prod01/* " >>$PTHTMP/cptemp.sq                                                                             l
echo    "       host date       " >>$PTHTMP/cptemp.sql
echo    "       Prompt Fin de Backup " >>$PTHTMP/cptemp.sql
echo    "       quit    " >>$PTHTMP/cptemp.sql

$ORACLE_HOME/bin/sqlplus / as sysdba @$PTHTMP/cptemp.sql >> $PTHTMP"/log_backup_                                                                             full_"$FECHA"_"$NOMBRE_BASE".log"


rm $PTHTMP/cptemp.sql $PTHTMP/copia_dats.sh