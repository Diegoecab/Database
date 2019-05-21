--awr_plan_change_date.sql
set lines 300
set verify off
col execs for 999999
col avg_etime for 999999
col avg_lio for 9999999999
col begin_interval_time for a30
col node for 999999
col first_exec for a28
col last_exec for a28

PROMPT
PROMPT

accept DiffPerc prompt "Enter value for diffperc: "
accept DiffSec prompt "Enter value for diffsec: "

select sql_id, username, count_hash_val, exec_total,first_exec, last_exec, 
min_time, max_time, diff_time, decode(min_time,0,100,round((diff_time*100)/max_time)) diff_perc
from (
select s.sql_id,c.username,
count(distinct plan_hash_value) count_hash_val, sum(EXECUTIONS_TOTAL) exec_total,
min (begin_interval_time) first_exec, max (begin_interval_time) last_exec,
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) min_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) max_time,
round(max(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) -
round(min(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000))) diff_time
from DBA_HIST_SNAPSHOT SS ,DBA_HIST_SQLSTAT S join dba_users c on s.parsing_schema_id=c.user_id
where begin_interval_time > sysdate -&NDays
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
--and rows_processed_total <> 0 --Excl Canceled
group by s.sql_id,c.username
having count(distinct plan_hash_value) > 1
order by diff_time)
where diff_time <> 0 
and username <> 'SYS'
and username like upper ('%&username%')
and
--((decode(min_time,0,100,round((diff_time*100)/max_time)) > &DiffPerc) --Diff time perc 
--or diff_time > &DiffSec) --Diff time sec
(
((decode(min_time,0,100,round((diff_time*100)/max_time)) > &DiffPerc) and diff_time > &DiffSec)--Diff perc
or (diff_time > 0 and exec_total > 100) --Diff time sec
) 
/