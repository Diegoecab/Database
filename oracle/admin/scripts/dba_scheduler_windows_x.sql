--dba_scheduler_windows_x
PROMPT Windows, filter by window group name

set lines 400
set feed off
set verify off
alter session set nls_date_format='dd/mm/yyyy hh24:mi';
col schedule_owner heading 'Schedule|Owner' for a5
col schedule_name heading 'Schedule|Name' for a5
col repeat_interval for a80
col next_start_date for a50
col last_start_date for a50
col start_date for a50
col end_date for a20
col duration for a20
col window_name for a25
col resource_plan heading 'Resource|Plan' for a25
col comments for a20
col manual_open_time for a30
col manual_duration for a20
select a.window_name,window_group_name,repeat_interval,duration,window_priority,next_start_date,last_start_date,enabled,active,schedule_type 
from dba_scheduler_windows a, dba_scheduler_wingroup_members b
where a.window_name like upper('%&window_name%')
and upper(window_group_name) like upper('%&win_group_name%') 
and b.window_name=a.window_name
order by next_start_date
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