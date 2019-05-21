--dba_scheduler_job_log
set lines 500
col client_id for a40
col additional_info for a70
col job_name for a30
col job_subname for a10
col log_date for a35

select * from dba_scheduler_job_log
where job_name like upper('%&job_name%')
order by log_id
/