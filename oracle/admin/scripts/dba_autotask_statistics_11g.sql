--dba_autotask_statistics_11g.sql
col job_Start_time for a60
col job_duration for a60
set lines 400

SELECT client_name, status
FROM DBA_AUTOTASK_TASK
WHERE client_name like 'auto optimizer %';

SELECT window_name,job_name, job_status, job_duration,JOB_START_TIME
FROM DBA_AUTOTASK_JOB_HISTORY
WHERE client_name='auto optimizer stats collection'
AND window_start_time >= SYSDATE -&days
ORDER BY job_start_time DESC
/

