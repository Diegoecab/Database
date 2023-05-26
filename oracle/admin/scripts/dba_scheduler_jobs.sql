--dba_scheduler_jobs
set lines 800
set verify off

col program_owner for a10
col program_name for a30
col job_Action for a100
col job_name for a30
col job_creator for a10
col job_type for a25
col schedule_owner for a30
col schedule_name for a30
col repeat_interval for a30
col source for a50
col comments for a60
col last_run_duration for a30
col max_run_duration for a30
col next_run_date for a20
col start_date for a20
col last_start_date for a35
col next_start_date for a35
col stop_on_window_close for a10



select owner,job_name,job_creator,state, program_owner,program_name,job_type,substr(job_action,1,100) job_action,
schedule_owner,schedule_name,schedule_type,job_class,
to_char(start_date,'dd/mm/yyyy hh24:mi:ss') start_date, repeat_interval, enabled, run_count, max_runs, failure_count, max_failures, 
to_char(last_start_date,'dd/mm/yyyy hh24:mi:ss') last_start_date, last_run_duration,
to_char(next_run_date,'dd/mm/yyyy hh24:mi:ss') next_run_date, max_run_duration,
stop_on_window_close,source,comments 
from
dba_scheduler_jobs 
where upper(job_name) like upper('%&job_name%')
/

PROMPT
PROMPT *****************************************************
PROMPT Windows:		dba_scheduler_windows_x.sql
PROMPT Jobs:			dba_scheduler_jobs.sql
PROMPT Job Run Details:	dba_scheduler_job_run_details.sql
PROMPT Programs:		dba_scheduler_programs.sql
PROMPT *****************************************************
PROMPT