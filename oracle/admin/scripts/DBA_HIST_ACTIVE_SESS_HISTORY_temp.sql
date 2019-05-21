--DBA_HIST_ACTIVE_SESS_HISTORY_temp.sql
@nls_date
select a.sql_id,   
       a.program,
sql_exec_start,
--sum(elapsed_time_delta/ executions_delta/ 1000000) seconds_per_exe,  	   
	   e.username,
max(TEMP_SPACE_ALLOCATED)/(1024*1024*1024) gig 
from DBA_HIST_ACTIVE_SESS_HISTORY  a ,dba_users e --, dba_hist_sqlstat c
where ( a.user_id = e.user_id)  -- and (a.sql_id = c.sql_id )
and
sample_time > sysdate - &days and 
TEMP_SPACE_ALLOCATED > (&gb*1024*1024*1024) 
group by a.sql_id, a.program,  sql_exec_start, e.username order by sql_exec_start;