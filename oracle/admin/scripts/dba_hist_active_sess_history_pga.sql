--dba_hist_active_sess_history_pga.sql
@nls_date
col username for a10 truncate
col program for a20 truncate
select a.instance_number inst_id, a.sql_id,   
a.sql_plan_hash_value,
       a.program,
sql_exec_start,
--sum(elapsed_time_delta/ executions_delta/ 1000000) seconds_per_exe,  	   
	   e.username,
max(pga_ALLOCATED)/(1024*1024*1024) gig_alocated
from DBA_HIST_ACTIVE_SESS_HISTORY  a ,dba_users e --, dba_hist_sqlstat c
where ( a.user_id = e.user_id)  -- and (a.sql_id = c.sql_id )
and
sample_time > sysdate - &days  
and (pga_ALLOCATED)/(1024*1024*1024) > &min_pga
and sql_id like '%&sqlid%'
group by a.instance_number, a.sql_id, a.sql_plan_hash_value, a.program, sql_exec_start, e.username order by sql_exec_start;




