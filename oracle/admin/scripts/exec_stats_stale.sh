#!/bin/bash

export me=$(basename $0)

##Parametros
#$1 >> DB = nombre de la base
export DB=$1

if [ -z ${DB} ]
then
     echo -e "\nUso: $me <nombre_bd>"
     exit
fi

#Configuracion ambiente oracle:
export ORACLE_HOME=/u01/app/oracle/product/12.1.0.2/dbhome_1
export PATH=${ORACLE_HOME}/bin:${PATH}
export ORACLE_SID=${DB}
export ORAENV_ASK=NO

. oraenv /dev/null

#Se configura ORACLE_SID = instancia en ejecucion en el nodo:
export ORACLE_SID=$(srvctl status instance -d ${DB} -n $(hostname) | awk '{print $2}')

sqlplus -s / as sysdba <<+

exec DBMS_STATS.FLUSH_DATABASE_MONITORING_INFO;

set linesize 120
set pagesize 0
set linesize 250
set head off
set verify off
set timi on
set echo off
set feedback off
set TERMOUT OFF

spoo run_stats_stale_tables.sql

set linesize 120
set pagesize 0
set linesize 250
set head off
set verify off
set timi off
set echo off
set feedback off
set TERMOUT OFF

-- select 'exec  dbms_stats.gather_table_stats( ownname => ''' || t.owner || ''', tabname=> '''|| t.table_name || ''', estimate_percent => dbms_stats.auto_sample_size, method_opt=>'|| '''for all columns size auto''' || ', cascade=>true,degree =>2);'
--from dba_tab_statistics t
--where STALE_STATS='YES'
--  and owner not in ('SYS','SQLTXPLAIN','SYSTEM','DVSYS','SYSMAN')
--  and table_name not like 'MLOG$_%'
--order by  t.owner, t.table_name;


select 'exec  dbms_stats.gather_table_stats( ownname => ''' || t.owner || ''', tabname=> '''|| t.table_name || ''', estimate_percent => dbms_stats.auto_sample_size, method_opt=>'|| '''for all columns size auto''' || ', cascade=>true,degree =>2);'
from dba_tab_statistics t
where STALE_STATS='YES'
  and owner not in ('SYS','SQLTXPLAIN','SYSTEM','DVSYS','SYSMAN')
  and table_name not like 'MLOG$_%'
  and (
  not exists (select 1 from dba_tab_statistics z where z.owner=t.owner and z.table_name=t.table_name and z.partition_name is not null) --Es tabla sin particiones
  or
  exists (select 1 from dba_tab_statistics z where z.owner=t.owner and z.table_name=t.table_name and z.partition_name is not null and last_analyzed is null) --Es tabla con particion recien creada
  )
order by  t.owner, t.table_name;

select 'exec  dbms_stats.gather_table_stats( ownname => ''' || t.owner || ''', tabname=> '''|| t.table_name || ''', partname=> ''' || t.partition_name ||''', estimate_percent => dbms_stats.auto_sample_size, method_opt=>'|| '''for all columns size auto''' || ', cascade=>true,degree =>2);'
from dba_tab_statistics t
where STALE_STATS='YES'
  and owner not in ('SYS','SQLTXPLAIN','SYSTEM','DVSYS','SYSMAN')
  and table_name not like 'MLOG$_%'
  and partition_name is not null
order by  t.owner, t.table_name;

spoo off
+


sqlplus / as sysdba <<+

spoo run_stats_stale_tables.log

set timi on
set echo on
set feed on

@run_stats_stale_tables.sql

spool off
+