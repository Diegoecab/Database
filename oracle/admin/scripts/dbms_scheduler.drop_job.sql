--dbms_scheduler.drop_job.sql
@dba_scheduler_jobs.sql
prompt
prompt job_name:	Owner.Job_name
prompt

begin
dbms_scheduler.drop_job (job_name => '&job_name', force=> &force);
end;
/ 