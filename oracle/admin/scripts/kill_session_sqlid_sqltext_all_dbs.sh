#!/bin/bash
for db in `ps -ef | grep pmon | grep -v grep | awk '{ print $8 }' | cut -d '_' -f3 | grep -v "^+" | grep -v "^-"`
do
 echo "database is $db"
export ORAENV_ASK=NO
#export ORACLE_HOME=/u01/app/oracle/product/12.1.0.2/dbhome_1
export PATH=$ORACLE_HOME/bin:.:$PATH
export ORACLE_SID=$db
. oraenv


sqlplus -s / as sysdba <<!
spool /tmp/kill_oem_active_sessions.log append
set serveroutput on
set head off
set feed off
set echo off
select to_char(sysdate,'dd-mm-yy hh24:mi:ss') from dual;
select name from v\$database;
begin
for r in (select  b.sql_id, seconds_in_wait, last_call_et, logon_time, username, sid, serial#, inst_id, status
               from gv_\$session, v\$sql b
                           where address = decode (rawtohex (sql_address),
                            '00', prev_sql_addr,
                            sql_address
                           ) and (b.sql_id='9wu3m7hd28nq6' or upper(sql_fulltext) like '%SYS.DBA_COMON_AUDIT_TRAIL%' or upper(sql_fulltext) like '%SYS.DBA_COMMON_AUDIT_TRAIL%')
                                                   and last_call_et > 60)
                                                   loop

dbms_output.put_line('session '''||r.sid||','||r.serial#|| ',@'||r.inst_id||''' with status '||r.status||', last_call_et '||r.last_call_et||', logon_time '||to_char(r.logon_time,'dd-mm-yy hh24:mi:ss')||', sqlid '||r.sql_id||' will killed');
begin
dbms_output.put_line('alter system kill session '''||r.sid||','||r.serial#|| ',@'||r.inst_id||''' immediate');

execute immediate('alter system kill session '''||r.sid||','||r.serial#|| ',@'||r.inst_id||''' immediate');
exception when others then
null;
end;
end loop;
end;
/
select to_char(sysdate,'dd-mm-yy hh24:mi:ss') from dual;
spool off
exit;
!

done
