select LOG_USER,job,what, last_date, last_sec, next_date, next_sec, failures, broken 
from dba_jobs 
where broken = 'Y' or failures > 0
/
