#!/bin/bash
for db in `ps -ef | grep pmon | grep -v grep | awk '{ print $8 }' | cut -d '_' -f3 | grep -v "^+" | grep -v "^-"`
do
 echo -e "\n database is $db"
export ORAENV_ASK=NO
export PATH=$ORACLE_HOME/bin:.:$PATH
export ORACLE_SID=$db
. oraenv 2>/dev/null 1>/dev/null
 

sqlplus -s / as sysdba <<!
--@ashtop sql_id 1=1 sysdate+(1/1440*-60) sysdate
--@ashtoph TO_CHAR(sample_time,'YYYY-MM-DD') 1=1 sysdate-60 sysdate
--@ashtoph wait_class 1=1 trunc(sysdate) sysdate
--@ashtoph sql_id "wait_class='User I/O'" trunc(sysdate) sysdate
show parameter cpu_count
show parameter resource

col Mbytes for 9999999999
col value for a20 truncate
set lines 400
select name as Parameter, value from v\$parameter
where name in ('use_large_pages')
order by name;

select con_id, name as Parameter, value/1024/1024 as Mbytes from v\$parameter
where name in ('memory_target','memory_max_target','sga_max_size','sga_target','pga_aggregate_target','pga_aggregate_limit')
order by name;

--show parameter sga_max_size
--show parameter sga_target
--show parameter use_large_pages
--show parameter memory_target
--show parameter pga
--show parameter sga_max_size
--SELECT NAME, PHYSICAL_READS, DB_BLOCK_GETS, CONSISTENT_GETS,
--      1 - (PHYSICAL_READS / (DB_BLOCK_GETS + CONSISTENT_GETS)) "Hit Ratio"
--  FROM V\$BUFFER_POOL_STATISTICS;
--@dba_hist_sysmetric_summary_cpu_io.sql
!
done




#!/bin/bash
for db in `ps -ef | grep pmon | grep -v grep | awk '{ print $8 }' | cut -d '_' -f3 | grep -v "^+" | grep -v "^-"`
do
 echo -e "\n database is $db"
export ORAENV_ASK=NO
export PATH=$ORACLE_HOME/bin:.:$PATH
export ORACLE_SID=$db
. oraenv 2>/dev/null 1>/dev/null
 

sqlplus -s / as sysdba <<!
alter profile default limit PASSWORD_LIFE_TIME unlimited;
alter profile default limit PASSWORD_REUSE_MAX unlimited;
alter user dbsnmp profile default;
alter user dbsnmp identified by Pepito2013#;
alter user dbsnmp identified by l_ellison2014;
alter user dbsnmp account unlock;
!
done


#!/bin/bash
for db in `ps -ef | grep pmon | grep -v grep | awk '{ print $8 }' | cut -d '_' -f3 | grep -v "^+" | grep -v "^-"`
do
 echo -e "\n database is $db"
export ORAENV_ASK=NO
export PATH=$ORACLE_HOME/bin:.:$PATH
export ORACLE_SID=$db
. oraenv 2>/dev/null 1>/dev/null
 

sqlplus -s / as sysdba <<!
set lines 200
select CON_ID,ACTION_TIME, patch_Id,status from cdb_registry_sqlpatch where ACTION_TIME > sysdate-10 order by ACTION_TIME; 
--where ACTION_TIME > sysdate-10 and STATUS <> 'SUCCESS';
exit
!
done

por oratab:
for db in `cat /etc/oratab| grep -v "^#"| grep "/oracle/rdbms/11.2.0.4:N"|cut -d":" -f 1|grep -v ASM`
for db in `cat /etc/oratab|cut -d":" -f 1`
do
 echo -e "\n database is $db"
export ORAENV_ASK=NO
#export PATH=$ORACLE_HOME/bin:.:$PATH
export ORACLE_SID=$db
. oraenv 2>/dev/null 1>/dev/null
#srvctl stop database -d $db
#srvctl start database -d $db
sqlplus / as sysdba <<EOF
startup
exit;
EOF
#srvctl stop database -d $db
done


set pagesize 100
set linesize 900
set verify off
set lines 900


clear col
col machine  for a30
col spid for a7
col program for a20 truncate
col username for a30
col sid for 9999
col last_act for 99999
col logon_time  for a25
col service_name for a20 truncate
--col spid heading 'OsPid'
--col pq_status heading 'Parallel|Query'
--col min_inac heading 'Min|Inact'
col sql_id for a13
--col pdml_status heading 'Parallel|dml'
--col pddl_status heading 'Parallel|ddl'
col client_identifier for a30
col kill_sess for a100
col osuser for a10 truncate

select s.username,sid,s.serial#, spid,s.inst_id, machine, s.program, osuser, sql_id,to_char(LOGON_TIME,'DD-MM-YY HH24:MI:SS') as LOGON_TIME,
ROUND((SYSDATE-LOGON_TIME)*(24*60),1) as Min_Logged_On
  , floor(last_call_et / 60) Min_Current_Status, decode(background,1,'Y','N') as back_process,
  p.spid
  --, 'alter system kill session '''||sid||','||s.serial#||',@'||s.inst_id||''' immediate;' kill
  from gv\$session s ,gv\$process p
  where s.paddr = p.addr
 and s.username = 'SYS' and module <> 'GoldenGate' and module like 'rman%' and logon_time < sysdate+(1/1440*-60)
order by LOGON_TIME;
