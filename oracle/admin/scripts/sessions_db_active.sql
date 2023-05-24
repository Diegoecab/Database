REM	Script para ver las sesiones actuales en la base de datos
REM ======================================================================
REM sessions_db_active.sql		Version 1.1	29 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM	
REM Dependencias:
REM	
REM
REM Notas:
REM
REM Precauciones:
REM	
REM ======================================================================
REM
set pagesize 10000
col machine for a25 TRUNCATE
col program for a25 TRUNCATE
col sid for 9999
col inst_id heading 'Inst|Id' for 99
col osuser for a13 TRUNCATE
col module for a13 TRUNCATE
col username for a12 TRUNCATE
col kill for a70
col SPID for a10
col Min_Current_SQL heading 'Min|Curr|ent|SQL' for 999999
col Min_Current_Status heading 'Min|Active' for 999999
col Sec_Current_Status heading 'Sec|Active' for 999999
col Min_Logged_On heading 'Min|Logg|ed|On' for 999999
col elapsed_per_exec_sql_min heading 'Avg|Elap|Per|Exec|SQL(m)' for 999999.99
col BACK_PROCESS heading 'Bck|Proc' for a2
col Logon_time heading 'Log|On|Time' for a18
col sql_text for a30 truncate

set lines 280
set verify off

set termout off

col 1 new_value 1 noprint
col 2 new_value 2 noprint
select '%' "1" from dual where rownum = 0; --default value %
select -1 "2" from dual where rownum = 0; --default value %
define 1
define 2


set termout on

select * from (
select s.username,sid,s.serial#, s.inst_id, machine, s.program,  module, osuser, sql_id,to_char(LOGON_TIME,'DD-MM-YY HH24:MI:SS') as LOGON_TIME,
ROUND((SYSDATE-LOGON_TIME)*(24*60),1) as Min_Logged_On
  , floor(last_call_et / 60) Min_Current_Status, floor(last_call_et) Sec_Current_Status, decode(background,1,'Y','N') as back_process,
  p.spid,
  (select distinct (sql_text) from gv$sql a where a.sql_id=s.sql_id and a.inst_id=s.inst_id and a.child_number=s.sql_child_number and a.ADDRESS = s.SQL_ADDRESS) sql_text,
  (select prev_sql_id from gv$sql a where a.sql_id=s.sql_id and a.inst_id=s.inst_id and a.child_number=s.sql_child_number and a.ADDRESS = s.SQL_ADDRESS) prev_sql_id,
  (select (plan_hash_value) from gv$sql a where a.sql_id=s.sql_id and a.inst_id=s.inst_id and a.child_number=s.sql_child_number and a.ADDRESS = s.SQL_ADDRESS) plan_hash_value,
  (select round((elapsed_time/1000000/(case when end_of_fetch_count = 0 then (case when users_executing = 0 then 1 else users_executing end) else end_of_fetch_count end))/60) avg_time_min from gv$sql a where a.sql_id=s.sql_id and a.child_number=s.sql_child_number and a.ADDRESS = s.SQL_ADDRESS) elapsed_per_exec_sql_min
  --, 'alter system kill session '''||sid||','||s.serial#||',@'||s.inst_id||''' immediate;' kill
  from gv$session s ,gv$process p
  where s.paddr = p.addr
 and s.username is not null and status = 'ACTIVE' and s.username <> 'SYS' and module <> 'GoldenGate'
 and s.username like upper('%&1%') order by back_process nulls first, Min_Current_Status desc
) where Min_Current_Status > &2
/


undefine 1