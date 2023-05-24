--DBA_HIST_ACTIVE_SESS_HISTORY_temp.sql
col username for a20 truncate
col program for a30 truncate
col sql_text for a80 truncate
set lines 600
set pages 50
@nls_date
select a.sql_id,   
       a.program,
sql_exec_start,
action,
--sum(elapsed_time_delta/ executions_delta/ 1000000) seconds_per_exe,  	   
	   e.username,
round(max(TEMP_SPACE_ALLOCATED)/(1024*1024*1024),1) gig,
(select distinct(cast(substr(sql_text,1,80) as varchar(100 byte))) from dba_hist_sqltext s where s.sql_id = a.sql_id) sql_text
from DBA_HIST_ACTIVE_SESS_HISTORY  a ,dba_users e --, dba_hist_sqlstat c
where ( a.user_id = e.user_id)  -- and (a.sql_id = c.sql_id )
and
sample_time > sysdate - &days and 
TEMP_SPACE_ALLOCATED > (&gb*1024*1024*1024) 
group by a.sql_id, a.program,  sql_exec_start, action, e.username order by max(TEMP_SPACE_ALLOCATED)/(1024*1024*1024);

col USERNAME for a30 truncate
col FIRST_SEEN for a20 truncate
col LAST_SEEN for a20 truncate
col SQL_TEXT for a60 truncate

select a.sql_id,   
	   e.username,
min(sample_time) first_seen,
max(sample_time) last_seen,
round(avg((TEMP_SPACE_ALLOCATED)/(1024*1024*1024))) avg_gig,
(select distinct(cast(substr(sql_text,1,80) as varchar(100 byte))) from dba_hist_sqltext s where s.sql_id = a.sql_id) sql_text
--(select distinct(cast(substr(sql_text,1,80) as varchar(100 byte))) from dba_hist_sqltext s where s.sql_id = a.sql_id) sql_text
from DBA_HIST_ACTIVE_SESS_HISTORY  a ,dba_users e --, dba_hist_sqlstat c
where ( a.user_id = e.user_id)  -- and (a.sql_id = c.sql_id )
and
sample_time > sysdate - &days
and 
((TEMP_SPACE_ALLOCATED)/(1024*1024*1024)) > &gb
group by a.sql_id, e.username
order by 5;
--@ash/ashtoph event,object_name,sql_plan_operation,TEMP_SPACE_ALLOCATED "sql_id='5255zd0s2vjfy' and sql_plan_hash_value='3902699488'" trunc(sysdate-15) sysdate
Prompt ej ashtop: @ash/ashtoph event,object_name,sql_plan_operation,TEMP_SPACE_ALLOCATED "sql_id='5255zd0s2vjfy' and sql_plan_hash_value='3902699488'" trunc(sysdate-15) sysdate
