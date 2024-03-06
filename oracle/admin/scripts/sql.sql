set lines 400
col sql_text for a100
--v$sql.sql

select sql_id, child_number, parsing_schema_name,round(elapsed_time/1000000) elapsed_time_sec, 
round((elapsed_time/1000000)/60) elapsed_time_min, plan_hash_value, hash_value,sql_text,executions,
fetches,users_executing,disk_reads,sql_profile,last_active_time,
round(rows_processed/((elapsed_time/decode(nvl(executions,0),0,1,executions))/1000000)) rows_per_sec
 from v$sql
where sql_id like '%&sql_id%' and sql_text like '%&sql_text%' and parsing_schema_name like upper('%&parsing_schema_name%')
order by last_active_time
/