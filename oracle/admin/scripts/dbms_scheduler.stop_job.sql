--dbms_scheduler.stop_job.sql
undefine all

@dba_scheduler_jobs.sql

begin
dbms_scheduler.stop_job (job_name => '&job_name');
end;
/