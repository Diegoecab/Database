--scheduler_stats
col job_name for a18
col status for a10
col fecha_log for a17
col run_duration for a15
select log_id, job_name, status, 
to_char(log_date, 'DD-MON-YYYY HH24:MI') fecha_log, run_duration
from dba_scheduler_job_run_details
where job_name='GATHER_STATS_JOB'
order by log_date asc;