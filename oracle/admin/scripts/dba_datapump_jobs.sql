--dba_datapump_jobs
col job_name for a30 truncate
col owner_name for a20 truncate
col operation for a20 truncate
set lines 300
select * from dba_datapump_jobs;