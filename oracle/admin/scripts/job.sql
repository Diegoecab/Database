select LOG_USER,job,what, last_date, last_sec, next_date, next_sec, failures, broken 
from dba_jobs 
where upper(what) like UPPER('%&1%')
order by log_user, what, job
/
