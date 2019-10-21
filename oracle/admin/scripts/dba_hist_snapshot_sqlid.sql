--dba_hist_snapshot_sqlid

--Buscar sqlid en los snapshots


prompt

set verify off
set lines 1000
set long 5000
undefine all
clear col

col end_interval_time for a25
col sql_profile for a25
col sql_text for a900

accept sqlid prompt 'Enter value for sqlid: '
accept sqltext prompt 'Enter value for sqltext: '
accept parsing_schema_name prompt 'Enter value for parsing_schema_name: '

select sql_id, sql_text from dba_hist_sqltext where upper(sql_id) like upper('%&sqlid%') and sql_text like upper ('%&sqltext%');

select   stat.sql_id,
           plan_hash_value,
		   ss.end_interval_time,
           parsing_schema_name,
		   rows_processed_total,
		   disk_reads_total,
		   cpu_time_total,
		   iowait_total,
		   sorts_total,
           elapsed_time_delta,
		   executions_total,
		   round((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000) avg_etime,
		   round(((elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000)/60) avg_etime,
		   round(elapsed_time_total/1000000) elapsed_time_total_sec,
		   round((elapsed_time_total/1000000)/60) elapsed_time_total_min,
		   round(sharable_mem/1024/1024) sharable_mem_mb,
		   sql_profile, 
           stat.snap_id,
		   module
    from   dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   where       stat.sql_id = txt.sql_id
           and stat.dbid = txt.dbid
           and ss.dbid = stat.dbid
		   and ss.end_interval_time > trunc (sysdate - nvl('&days',0))
           and ss.instance_number = stat.instance_number
           and stat.snap_id = ss.snap_id
           and stat.dbid = (select dbid from v$database)
           and stat.instance_number = (select instance_number from v$instance)
           and upper (stat.sql_id) like upper('%&sqlid%')
		   and upper (txt.sql_text) like upper ('%&sqltext%')
		   and parsing_schema_name like upper ('%&parsing_schema_name%')
order by   stat.snap_id
/


prompt group by day

select trunc(end_interval_time),stat.sql_id, max(EXECUTIONS_TOTAL), count(*)
    from   dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   where       stat.sql_id = txt.sql_id
           and stat.dbid = txt.dbid
           and ss.dbid = stat.dbid
           and ss.instance_number = stat.instance_number
		   and ss.end_interval_time > trunc (sysdate - nvl('&days',0))
           and stat.snap_id = ss.snap_id
           and stat.dbid = (select dbid from v$database)
           and stat.instance_number = (select instance_number from v$instance)
           and upper (stat.sql_id) like upper('%&sqlid%')
		   and upper (txt.sql_text) like upper ('%&sqltext%')
		   and parsing_schema_name like upper ('%&parsing_schema_name%')
	group by trunc(end_interval_time), stat.sql_id
	order by  1
	/