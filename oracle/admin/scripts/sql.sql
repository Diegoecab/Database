set lines 900
set pages 1000
set head on
set feed on
set verify off
col parsing_schema_name for a15 truncate heading 'Parsing|Schema'
col sql_profile for a10 truncate
col elapsed_time_sec for 999999.99 word_wrap heading 'Elap|Time|Secs'
col elapsed_per_exec for 99999999.9999 word_wrap heading 'Elap|Time|Secs|Per|Exec'
col time_per_exec_min for 9999 word_wrap heading 'Elap|Time|Min'
col elapsed_time_min for 9999 word_wrap heading 'Curr|Elap|Time'
col executions for 99999999 word_wrap heading 'Execs'
col invalidations for 999999 word_wrap heading 'Invs'
col parse_calls for 9999 word_wrap heading 'Pars|Calls'
col rows_processed for 999999999 word_wrap heading 'Rows|Proc'
col avg_rows_processed for 999999 word_wrap heading 'avg|Rows|Proc'
col users_executing  for 99 word_wrap heading 'Curr|Exec'
col loaded_versions for 99 word_wrap heading 'Ver|sio|ns'
col fetches for 999999 word_wrap heading 'Fetchs'
col end_of_fetch_count for 999999 word_wrap heading 'End|Of|Fetchs|Cnt'
col last_active_time for a11 truncate
col sql_plan_baseline for a10 truncate heading 'Sql|Plan|Base|Line'
col avg_time_min for 9999 word_wrap heading 'Avg|Mins'
col disk_reads for 99999999 word_wrap heading 'Disk|Reads'
col plan_hash_value for 99999999999 word_wrap heading 'Plan|Hash|Value'
col avg_rows_processed_x_ex for 99999999999 word_wrap heading 'Avg|Rows|Proc|Per|Exec'
col avg_rows_processed_x_sec for 99999999999 word_wrap heading 'Avg|Rows|Proc|Per|Sec'
col px_servers_executions for 999 heading 'px|srv|exec'
col is_shareable for a2 heading 'Is|Sh|ar'
col users_opening for 9999 heading 'Usr|Open|ing'
col Offload for a2 heading 'Off|Load'
col "IO_SAVED_%" for 9999 heading 'IO|SAVED|%'
col child_number for 999 heading 'Chi|ld#'
col inst_id for 99 heading 'Inst|#'
col sql_patch  for a10 truncate
set recsep wrapped
set recsepchar "-"
col signature for 99999999999999999999


prompt ******************************************************************************************************************
prompt
prompt SQL execution of SQLID &1 in memory (gv$sql)
prompt
prompt ******************************************************************************************************************


define sql_id=&1

--v$sql.sql
select --sql_id, 
inst_id,
parsing_schema_name, plan_hash_value, 
round(elapsed_time/1000000,2) elapsed_time_sec, 
round((elapsed_time/1000000)/(case when end_of_fetch_count = 0 then (case when users_executing = 0 then 1 else users_executing end) else end_of_fetch_count end),2) elapsed_per_exec,
round((elapsed_time/1000000/(case when end_of_fetch_count = 0 then (case when users_executing = 0 then 1 else users_executing end) else end_of_fetch_count end))/60) avg_time_min ,
round((elapsed_time/1000000)/60) elapsed_time_min,
CPU_TIME,
round(CPU_TIME/(case when end_of_fetch_count = 0 then (case when users_executing = 0 then 1 else users_executing end) else end_of_fetch_count end)) avg_cpu_time,
 executions,
end_of_fetch_count, fetches,USERS_OPENING,users_executing,disk_reads,sql_profile,sql_patch, sql_plan_baseline, EXACT_MATCHING_SIGNATURE signature,to_char(last_active_time,'dd-mm hh24:mi') last_active_time,
rows_processed,
(rows_processed/(case when end_of_fetch_count = 0 then (case when users_executing = 0 then 1 else users_executing end) else end_of_fetch_count end)) avg_rows_processed_x_ex,
(decode(IO_CELL_OFFLOAD_ELIGIBLE_BYTES,0,'No','Yes')) as Offload,
(round(decode(IO_CELL_OFFLOAD_ELIGIBLE_BYTES,0,0,100*(IO_CELL_OFFLOAD_ELIGIBLE_BYTES-IO_INTERCONNECT_BYTES)/decode(IO_CELL_OFFLOAD_ELIGIBLE_BYTES,0,1,IO_CELL_OFFLOAD_ELIGIBLE_BYTES)))) "IO_SAVED_%"
 from gv$sql
where sql_id like '%&sql_id%' -- and sql_text like '%sql_text%' --and parsing_schema_name like upper('%parsing_schema_name%')
order by last_active_time
/


select --sql_id,
inst_id,
parsing_schema_name, plan_hash_value,
round((elapsed_time/1000000)/(case when end_of_fetch_count = 0 then (case when users_executing = 0 then 1 else users_executing end) else end_of_fetch_count end),2) elapsed_per_exec,
 executions,
end_of_fetch_count, fetches,USERS_OPENING,users_executing,disk_reads,
CPU_TIME,
 to_char(last_active_time,'dd-mm hh24:mi') last_active_time,
rows_processed,
(rows_processed/(case when end_of_fetch_count = 0 then (case when users_executing = 0 then 1 else users_executing end) else end_of_fetch_count end)) avg_rows_processed_x_ex,
(rows_processed/(elapsed_time/1000000)) avg_rows_processed_x_sec,
loaded_versions,loads,invalidations,parse_calls,
px_servers_executions,CHILD_NUMBER, is_shareable
 from gv$sql
where sql_id like '%&sql_id%' -- and sql_text like '%sql_text%' --and parsing_schema_name like upper('%parsing_schema_name%')
order by last_active_time
/


prompt ******************************************************************************************************************
prompt
prompt SQL TEXT:
prompt
prompt ******************************************************************************************************************


prompt @sql_sqltext.sql &sql_id

