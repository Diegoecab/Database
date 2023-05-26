prompt
prompt

undefine all
set verify off
set lines 300
set long 5000
set pages 10000
set feed on
set head on

clear col

col end_interval_time for a25
col sql_profile for a20 truncate
col sql_text for a100 truncate
col instance_number heading 'INST#' for 9
col parsing_schema_name for a15 truncate
col FIRST_SEEN for a25
col LAST_SEEN for a25
col MODULE for a20 truncate

define sql_id='&1'
define sql_text='&2'
define parsing_schema_name='&3'

select min(end_interval_time) FIRST_SEEN, max(end_interval_time) LAST_SEEN,
		stat.sql_id,
		stat.plan_hash_value,
		   sum(executions_delta) execs,
		   round((sum(elapsed_time_delta/1e6)/decode(nvl(sum(executions_delta/1e6),0),0,1,sum(executions_delta/1e6)))/1e6) avg_etime_sec_delt,
		   --round((elapsed_time_total/1e6/decode(nvl(elapsed_time_total,0),0,1,elapsed_time_total))/60) avg_etime_min_delt,
           parsing_schema_name,
		   module,
		   cast(substr(sql_text,1,100) as varchar(120 byte)) sql_text
    from   dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot ss
   where       stat.sql_id = txt.sql_id
           and stat.dbid = txt.dbid
           and ss.dbid = stat.dbid
		   --and ss.end_interval_time > trunc (sysdate - )
           and ss.instance_number = stat.instance_number
           and stat.snap_id = ss.snap_id
           and stat.dbid = (select dbid from v$database)
		   and executions_delta > 0
           --and stat.instance_number = (select instance_number from v$instance)
           and upper (stat.sql_id) like upper('%&sql_id%')
		   and upper (txt.sql_text) like upper ('%&sql_text%')
		   and parsing_schema_name like upper ('%&parsing_schema_name%')
		   group by stat.sql_id,
		   stat.plan_hash_value,
           parsing_schema_name,
		   module,
		   cast(substr(sql_text,1,100) as varchar(120 byte))
order by   2
/