--dba_scheduler_schedules.sql
set lines 400
col program_owner for a10
col program_name for a30
col job_Action for a100
col job_name for a30
col job_creator for a10
col job_type for a25
col schedule_owner for a30
col schedule_name for a30
col repeat_interval for a50
col source for a50
col comments for a60
col last_run_duration for a30
col max_run_duration for a30
col next_run_date for a20
col start_date for a20
col last_start_date for a35
col next_start_date for a35
col stop_on_window_close for a10
col event_condition for a20

select * from dba_scheduler_schedules
/

prompt
prompt *****************************************************
prompt windows:		dba_scheduler_windows_x.sql
prompt jobs:			dba_scheduler_jobs_x.sql
prompt job run details:	dba_scheduler_job_run_details.sql
prompt programs:		dba_scheduler_programs.sql
prompt schedules:		dba_scheduler_schedules.sql 
prompt *****************************************************
prompt