--sql_monitor sqlid status
--sql_monitor % EXECUTING
set lines 1000 pages 9999 
column sid format 9999 
column serial for 999999
column status format a15
column username format a15 truncate 
col process_name heading 'Fore|Or|Back' for a10 truncate
column sql_text format a55 truncate
col inst_id for 99 heading 'Ins|ID'
column module format a20 truncate
col program for a20 truncate
col sql_exec_start for a20
col sql_plan_hash_value heading 'sql|plan|hash|value'

SELECT * FROM
       (SELECt sql_id,status,inst_id,sid,session_serial# as serial,username,sql_plan_hash_value,
     module,program,
         TO_CHAR(sql_exec_start,'dd-mon-yyyy hh24:mi:ss') AS sql_exec_start,
         ROUND(elapsed_time/1000000)                      AS "Elapsed (s)",
		 ROUND((elapsed_time/1000000)/60)                      AS "Elapsed (m)",
         ROUND(cpu_time    /1000000)                      AS "CPU (s)",
		 process_name, --ora if the process is foreground, else the background process name (for example, p001 for PX server p001)
         substr(sql_text,1,55) sql_text
       FROM gv$sql_monitor where
	   sql_id like '%&1%' and
	   upper(status) like upper('%&2%') --status='EXECUTING'
       ORDER BY elapsed_time,sql_id, process_name, sql_exec_start  desc
       ) ;