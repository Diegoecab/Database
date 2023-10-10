--Diego Cabrera

--top_sql_byelaptime.sql to_date('28-08-20:00:00','DD-MM-YY:HH24:MI') to_date('28-08-20:23:00','DD-MM-YY:HH24:MI')
--@top_sql_byelaptime.sql module "parsing_schema_name='BUSINESSDATA_ARGENTINA'" trunc(sysdate) sysdate
--@top_sql_byelaptime.sql module "module like '%1454%'" to_date('10-11-20:01:00','DD-MM-YY:HH24:MI') to_date('10-11-20:10:00','DD-MM-YY:HH24:MI')
--@top_sql_byelaptime.sql module "module like '%1454%'" to_date('11-11-20:01:00','DD-MM-YY:HH24:MI') to_date('11-11-20:10:00','DD-MM-YY:HH24:MI')
---@top_sql_byelaptime.sql module parsing_schema_name='S_AR_PRD_SAS' to_date('15-12-20:01:00','DD-MM-YY:HH24:MI') to_date('15-12-20:05:00','DD-MM-YY:HH24:MI')

prompt
prompt

set verify off
set lines 340
set pages 1000
set feed on
set head on
undefine all
clear col

col end_interval_time for a25
col first_time_seen for a25
col last_time_seen for a25
col sql_profile for a20 truncate
col sql_text for a80 truncate
col instance_number heading 'INST#' for 9
col avg_elap_time_mins heading 'avg|elap|time|mins' for 9999
col module for a30 truncate
col parsing_schema_name for a15 truncate

prompt ******************************************************************************************************************
prompt
prompt Top sql by elapsed time in last &1 days
prompt
prompt ******************************************************************************************************************

select * from (
select   end_interval_time, stat.sql_id,stat.instance_number,
           plan_hash_value,
		   executions_delta execs_delta,
		   executions_total execs_total,
		   TRUNC(elapsed_time_total/1e6/(case when executions_total = 0 then 1 else executions_total end)/60) avg_elap_time_mins,
		   TRUNC(elapsed_time_total/1e6/(case when executions_total = 0 then 1 else executions_total end)) avg_elap_time_secs,
			ROUND(disk_reads_delta      /DECODE(executions_delta,0,1, executions_delta),1) avg_pio ,
			TRUNC(cpu_time_delta/1e6/DECODE(executions_delta,0,1, executions_delta)/60) avg_cpu_mins,
			ROUND(rows_processed_delta/DECODE(executions_delta,0, 1, executions_delta), 1) avg_rows,
			cast(substr(sql_text,1,80) as varchar(100 byte)) sql_text
		  -- round((elapsed_time_total/executions_total)/1000000) avg_secs,
		--   round(elapsed_time_total/1000000) elapsed_time_total_sec,
		   --ss.end_interval_time,
		  --sql_patch--, --sql_plan_baseline--, 	
		   ,&1
           ,parsing_schema_name
--           stat.snap_id--,
--		   module
    from   dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   where       stat.sql_id = txt.sql_id
           and stat.dbid = txt.dbid
           and ss.dbid = stat.dbid
		   and &2
		   and ss.end_interval_time BETWEEN &3 AND &4
           and ss.instance_number = stat.instance_number
           and stat.snap_id = ss.snap_id
		   and executions_delta > 0
order by  avg_elap_time_secs desc nulls last
) where rownum <= 40; 



select * from (
select   stat.sql_id,
           plan_hash_value,
		   sum(executions_delta) execs_delta_sum,
		   sum(executions_total) execs_total_sum,
		   TRUNC(sum(elapsed_time_total/1e6/(case when executions_total = 0 then 1 else executions_total end)/60)) avg_elap_time_mins_sum,
		   TRUNC(sum(elapsed_time_total/1e6/(case when executions_total = 0 then 1 else executions_total end))) avg_elap_time_secs_sum
		  -- round((elapsed_time_total/executions_total)/1000000) avg_secs,
		--   round(elapsed_time_total/1000000) elapsed_time_total_sec,
		   --ss.end_interval_time,
		  --sql_patch--, --sql_plan_baseline--, 	
		   --,&1
           ,parsing_schema_name
--           stat.snap_id--,
--		   module
    from   dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   where       stat.sql_id = txt.sql_id
           and stat.dbid = txt.dbid
           and ss.dbid = stat.dbid
		   and &2
		   and ss.end_interval_time BETWEEN &3 AND &4
           and ss.instance_number = stat.instance_number
           and stat.snap_id = ss.snap_id
		   and executions_delta > 0
	group by stat.sql_id,plan_hash_value,parsing_schema_name
order by  execs_total_sum desc nulls last
) where rownum <= 400; 

--and upper(sql_text) like upper('%select%');

Prompt group by plan_hash_value,parsing_schema_name 

select * from (
select  
           plan_hash_value,
		   sum(executions_delta) execs_delta_sum,
		   sum(executions_total) execs_total_sum,
		   TRUNC(sum(elapsed_time_total/1e6/(case when executions_total = 0 then 1 else executions_total end)/60)) avg_elap_time_mins_sum,
		   TRUNC(sum(elapsed_time_total/1e6/(case when executions_total = 0 then 1 else executions_total end))) avg_elap_time_secs_sum
		  -- round((elapsed_time_total/executions_total)/1000000) avg_secs,
		--   round(elapsed_time_total/1000000) elapsed_time_total_sec,
		   --ss.end_interval_time,
		  --sql_patch--, --sql_plan_baseline--, 	
		   --,&1
           ,parsing_schema_name
--           stat.snap_id--,
--		   module
    from   dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   where       stat.sql_id = txt.sql_id
           and stat.dbid = txt.dbid
           and ss.dbid = stat.dbid
		   and &2
		   and ss.end_interval_time BETWEEN &3 AND &4
           and ss.instance_number = stat.instance_number
           and stat.snap_id = ss.snap_id
		   and executions_delta > 0
	group by plan_hash_value,parsing_schema_name
order by  execs_total_sum desc nulls last
) where rownum <= 40;

