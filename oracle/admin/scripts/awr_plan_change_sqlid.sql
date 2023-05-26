--awr_plan_change_sqlid.sql
set lines 900
set verify off
col execs for 999999
col avg_etime for 999999
col avg_lio for 9999999999
col begin_interval_time for a30
col node for 999999
col sql_profile for a40
col username for a30
--break on plan_hash_value on startup_time skip 1
PROMPT
PROMPT

--ACCEPT sql_id Prompt "SQL_ID :"

--PROMPT Explain Plan
--SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR('&sql_id',null,null,'ADVANCED'));
--PROMPT

select ss.snap_id, c.username,ss.instance_number node, begin_interval_time, plan_hash_value,
nvl(executions_delta,0) execs, rows_processed_total, round(rows_processed_total/((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000)) rows_per_sec,
round((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000) avg_etime,
round(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000)/60) avg_etime_min,
(buffer_gets_delta/decode(nvl(buffer_gets_delta,0),0,1,executions_delta)) avg_lio,sql_profile
from DBA_HIST_SNAPSHOT SS, DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where s.sql_id = '&sql_id'
and begin_interval_time > sysdate -&NDays
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
and c.username <> 'SYS'
order by 2,4
/