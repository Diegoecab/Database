--dba_scheduler_job_run_details.sql

col job_name for a40
col status for a20

select log_id, job_name, status, 
to_char(log_date, 'DD-MON-YYYY HH24:MI') fecha_log
from dba_scheduler_job_run_details
order by log_date asc;
