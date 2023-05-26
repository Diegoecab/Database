--dba_hist_snapshot_sqlid

--Buscar sqlid en los snapshots


--Usage: dba_hist_snapshot_sqlid sql_id sqltext parsing_schema_name days

prompt
prompt

set verify off
set lines 340
set long 5000
set pages 100
set feed on
set head on
undefine all

col end_interval_time for a25
col sql_profile for a20 truncate
col sql_text for a9000
col instance_number heading 'INST#' for 9
col parsing_schema_name for a15 truncate
col AVG_DELTA_PIO heading 'Avg|Delta|PIO' for 999999999
col AVG_DELTA_LIO heading 'Avg|Delta|LIO' for 999999999
col FETCH_COUNT_TOTAL heading 'Fetch|count|total' for 9999999
col AVG_ETIME_SECS heading 'Avg|elap|time(s)' for 9999999,999999
col AVG_ETIME_MIN heading 'Avg|elap|time(m)' for 9999999999
col EXECS_DELTA heading 'execs|delta' for 999999999
col AVG_TOTAL_ROWS heading 'Avg|total|rows' for 999999999
col avg_pio for 9999999999999
col IO_SAVED_% heading 'Pct|Io|Saved' for 9999
col parsing_schema_name heading 'Parsing|Schema' for a10 truncate

col min_interval_time for a30 truncate
col max_interval_time for a30 truncate


--select sql_text from dba_hist_sqltext where upper(sql_id) like upper('%&1%') and sql_text like upper ('%&2%');


prompt ******************************************************************************************************************
prompt
prompt Historic execution of SQLID &1 in last &4 days
prompt
prompt ******************************************************************************************************************

select   end_interval_time, --stat.sql_id,
		stat.instance_number,
           plan_hash_value,
		   nvl(executions_delta,0) execs_delta,
		   (elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000 avg_delta_etime,
			(buffer_gets_delta/decode(nvl(executions_delta,0),0,1,executions_delta)) avg_delta_lio,
			(disk_reads_delta/decode(nvl(executions_delta,0),0,1,executions_delta)) avg_delta_pio,
			rows_processed_delta delta_rows,
			'|',
			executions_total execs_total,
			(end_of_fetch_count_total) fetch_count_total,
		   round(elapsed_time_total/1e6/decode(nvl(executions_total,0),0,1,executions_total),2) avg_etime_secs,
		   round((elapsed_time_total/1e6/decode(nvl(executions_total,0),0,1,executions_total))/60) avg_etime_min,
		   ROUND((cpu_time_total)      /decode(nvl(executions_total,0),0,1,executions_total)) avg_cpu,
			ROUND(disk_reads_total      /decode(nvl(executions_total,0),0,1,executions_total)) avg_pio ,
			ROUND(buffer_gets_total     /decode(nvl(executions_total,0),0,1,executions_total)) avg_lio ,
			ROUND(px_servers_execs_total/decode(nvl(executions_total,0),0,1,executions_total)) avg_px ,
			ROUND(rows_processed_total  /decode(nvl(executions_total,0),0,1,executions_total)) avg_total_rows,
			'|',
			decode(IO_OFFLOAD_ELIG_BYTES_TOTAL,0,'No','Yes') Offload,
        decode(IO_OFFLOAD_ELIG_BYTES_TOTAL,0,0,100*(IO_OFFLOAD_ELIG_BYTES_TOTAL-IO_INTERCONNECT_BYTES_TOTAL))
        /decode(IO_OFFLOAD_ELIG_BYTES_TOTAL,0,1,IO_OFFLOAD_ELIG_BYTES_TOTAL) "IO_SAVED_%",
           parsing_schema_name,
		   sql_profile
    from   dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   where       stat.sql_id = txt.sql_id
           and stat.dbid = txt.dbid
           and ss.dbid = stat.dbid
		   and ss.end_interval_time > trunc (sysdate - nvl('&4',0))
           and ss.instance_number = stat.instance_number
           and stat.snap_id = ss.snap_id
           --and stat.instance_number = (select instance_number from v$instance)
           and upper (stat.sql_id) like upper('%&1%')
		   and upper (txt.sql_text) like upper ('%&2%')
		   and parsing_schema_name like upper ('%&3%')
		   --and executions_total > 0
order by   stat.snap_id
/

prompt ******************************************************************************************************************
prompt
prompt group by day (executions_total > 0)
prompt
prompt ******************************************************************************************************************

select to_date(TO_CHAR(trunc(end_interval_time),'dd-MON-yy')) as dt ,--stat.sql_id, 
ss.instance_number as inst_id,
min(end_interval_time) min_interval_time,
max(end_interval_time) max_interval_time,
 stat.sql_id,
           plan_hash_value,
		   sum(executions_total) execs_total,
		   sum(executions_delta) execs_delta,
		   sum(end_of_fetch_count_total) fetch_count_total,
		   round(sum(elapsed_time_total/1e6)/sum(executions_total),2) avg_etime_secs,
		   round((sum(elapsed_time_total/1e6)/sum(executions_total))/60) avg_etime_min,
		   round(sum(cpu_time_total)      /sum(executions_total)) avg_cpu,
			round(sum(disk_reads_total)      /sum(executions_total)) avg_pio ,
			round(sum(buffer_gets_total)     /sum(executions_total)) avg_lio ,
			round(sum(px_servers_execs_total)/sum(executions_total)) avg_px ,
			round(sum(rows_processed_total)  /sum(executions_total)) avg_rows,
			round(sum(cpu_time_total)      /sum(executions_total)) avg_cpu,
			sql_profile
    from   dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   where       stat.sql_id = txt.sql_id
           and stat.dbid = txt.dbid
           and ss.dbid = stat.dbid
           and ss.instance_number = stat.instance_number
		   and ss.end_interval_time > trunc (sysdate - nvl('&4',0))
           and stat.snap_id = ss.snap_id
           and upper (stat.sql_id) like upper('%&1%')
		   and upper (txt.sql_text) like upper ('%&2%')
		   and parsing_schema_name like upper ('%&3%')
		   --and executions_total > 0
	group by to_date(TO_CHAR(trunc(end_interval_time),'dd-MON-yy')), ss.instance_number, stat.sql_id, plan_hash_value,sql_profile
	order by  1
/


prompt ******************************************************************************************************************
prompt
prompt group by hour (executions_total > 0)
prompt
prompt ******************************************************************************************************************

select (TO_CHAR(trunc(end_interval_time),'HH24')) as dt ,--stat.sql_id, 
ss.instance_number as inst_id,
min(end_interval_time) min_interval_time,
max(end_interval_time) max_interval_time,
 stat.sql_id,
           plan_hash_value,
		   sum(executions_total) execs_total,
		   sum(executions_delta) execs_delta,
		   sum(end_of_fetch_count_total) fetch_count_total,
		   round(sum(elapsed_time_total/1e6)/sum(executions_total),2) avg_etime_secs,
		   round((sum(elapsed_time_total/1e6)/sum(executions_total))/60) avg_etime_min,
		   round(sum(cpu_time_total)      /sum(executions_total)) avg_cpu,
			round(sum(disk_reads_total)      /sum(executions_total)) avg_pio ,
			round(sum(buffer_gets_total)     /sum(executions_total)) avg_lio ,
			round(sum(px_servers_execs_total)/sum(executions_total)) avg_px ,
			round(sum(rows_processed_total)  /sum(executions_total)) avg_rows
    from   dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   where       stat.sql_id = txt.sql_id
           and stat.dbid = txt.dbid
           and ss.dbid = stat.dbid
           and ss.instance_number = stat.instance_number
		   and ss.end_interval_time > trunc (sysdate - nvl('&4',0))
           and stat.snap_id = ss.snap_id
           and upper (stat.sql_id) like upper('%&1%')
		   and upper (txt.sql_text) like upper ('%&2%')
		   and parsing_schema_name like upper ('%&3%')
		   and executions_total > 0
	group by (TO_CHAR(trunc(end_interval_time),'HH24')), ss.instance_number, stat.sql_id, plan_hash_value--,sql_profile
	order by  1
/

@plan_x_sqlid '&1'