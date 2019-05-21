--scheduler10g
/* nueva funcionalidad en 10g. Ver que otros datos son necesarios */

col additional_info for a100
set lines 400
col job_name for a50
select log_id, job_name, status, 
to_char(log_date, 'DD-MON-YYYY HH24:MI') log_date ,status, error#, run_duration, additional_info
from dba_scheduler_job_run_details
order by log_date desc
/

PROMPT Jobs details : dba_scheduler_jobs_x