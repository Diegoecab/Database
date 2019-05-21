#!/sbin/sh
################################################################################
# AUTHOR : Diego Cabrera                                                       #
# CREATED: 07/04/2010                                                          #
# PROGRAM:                                                                     #
# PURPOSE:                                                                     #
# USAGE  : gardw_eul_purge.sh                                                  #
#                                                                              #
################################################################################
FECHA=`date +%Y%m%d_%H%M%S`
export LOGFILE=/home/oracle/logs/gardw_eul_purge$FECHA.log
export ORACLE_SID=gardw
sqlplus "/ as sysdba" << EOF
alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
spool $LOGFILE
set heading off
select sysdate from dual;
WHENEVER SQLERROR EXIT SQL.SQLCODE
prompt insertando datos en Tabla historica ...
insert into garba_eul.eul5_qpp_stats_h
select * from
garba_eul.eul5_qpp_stats
where QS_CREATED_DATE <
(select to_date('01'||to_char(trunc(add_months(sysdate,-1)),'mmyyyy'),'ddmmyyyy') from dual);
commit;
select sysdate from dual;
prompt eliminando registros de Tabla original ...
delete from
garba_eul.eul5_qpp_stats
where QS_CREATED_DATE <
(select to_date('01'||to_char(trunc(add_months(sysdate,-1)),'mmyyyy'),'ddmmyyyy') from dual);
commit;
prompt Fin de proceso
select sysdate from dual;
spool off
quit
EOF
RC=$?
if [ $RC -ne 0 ]; then
echo "`cat $LOGFILE`" |mailx -s "PROD - GARDW - depuracion log DISCOVERER - ERROR " dba@gsahp.garba.com.ar
else
echo "`cat $LOGFILE`" |mailx -s "PROD - GARDW - depuracion log DISCOVERER - NOTIFICATION " dba@gsahp.garba.com.ar
fi