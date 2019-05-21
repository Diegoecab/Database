--dba_scheduler_programs
col program_action for a45
col owner for a10
col number_of_arguments for 9
col program_name for a25
col comments for a80
set lines 400

select * from dba_scheduler_programs
/

PROMPT
PROMPT *****************************************************
PROMPT Windows:		dba_scheduler_windows_x.sql
PROMPT Jobs:			dba_scheduler_jobs_x.sql
PROMPT Job Run Details:	dba_scheduler_job_run_details.sql
PROMPT Programs:		dba_scheduler_programs.sql
prompt schedules:		dba_scheduler_schedules.sql
PROMPT *****************************************************
PROMPT