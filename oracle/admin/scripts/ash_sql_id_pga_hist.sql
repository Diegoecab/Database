--ash_sql_id_pga_hist
alter session set nls_date_format='YYYY/MM/DD HH24:MI:SS';
alter session set nls_timestamp_format='YYYY/MM/DD HH24:MI:SS';
col END_TIME for a20 truncate

accept days prompt "Last Days [7] : " default 7;
accept top prompt "Top  Rows    [10] : " default 10;
 
select 	instance_number inst_id, sql_id,
	sql_plan_hash_value,
      starting_time,
      end_time,
 (EXTRACT(HOUR FROM run_time) * 3600
                    + EXTRACT(MINUTE FROM run_time) * 60
                    + EXTRACT(SECOND FROM run_time)) run_time_sec,
      READ_IO_BYTES,
      PGA_ALLOCATED/1024/1024/1024 PGA_ALLOCATED_GB,
      TEMP_ALLOCATED/1024/1024/1024 TEMP_ALLOCATED_GB,
	  rank
from  (
select
		instance_number,
       sql_id,
	   sql_plan_hash_value,
       max(sample_time - sql_exec_start) run_time,
       max(sample_time) end_time,
       sql_exec_start starting_time,
       sum(DELTA_READ_IO_BYTES) READ_IO_BYTES,
       sum(DELTA_PGA) PGA_ALLOCATED,
       sum(DELTA_TEMP) TEMP_ALLOCATED,
	   rank() over(order by sum(DELTA_PGA) desc) rank
       from
       (
       select 	instance_number, sql_id,
	   sql_plan_hash_value,
       sample_time,
       sql_exec_start,
       DELTA_READ_IO_BYTES,
       sql_exec_id,
       greatest(PGA_ALLOCATED - first_value(PGA_ALLOCATED) over (partition by sql_id,sql_exec_id order by sample_time rows 1 preceding),0) DELTA_PGA,
       greatest(TEMP_SPACE_ALLOCATED - first_value(TEMP_SPACE_ALLOCATED) over (partition by sql_id,sql_exec_id order by sample_time rows 1 preceding),0) DELTA_TEMP
       from
       dba_hist_active_sess_history
       where
       sample_time > sysdate-&days
       and sql_exec_start is not null
       and IS_SQLID_CURRENT='Y'
       )
group by 	instance_number, sql_id, sql_plan_hash_value, SQL_EXEC_ID,sql_exec_start
order by sql_id
)
--where sql_id = 'btvk5dzpdmadh'
where rank < (&top+1)
order by rank
;