--dbms_scheduler.create_job.sql
@dba_scheduler_window_groups.sql
@dba_scheduler_job_classes.sql
@dba_scheduler_jobs.sql
@dba_scheduler_programs.sql
@dba_scheduler_schedules.sql

prompt
prompt Examples
prompt
prompt job_name:	"DBADMIN"."DBS_STATISTICS"
prompt schedule_name:"SYS"."DAILY_PURGE_SCHEDULE" (ex. Windows group)
prompt job_type:	plsql_block / stored_procedure
prompt job_class:	"SYS"."DEFAULT_JOB_CLASS"
prompt job_action:	"STAT_GATHER_PKG"."GATHER_STATISTICS"
prompt enabled:		true/false
prompt auto_drop:	true/false
prompt stop_on_window_close: true/false
prompt restartable:	true/false
prompt

accept job_name prompt 'Enter value for job_name: '

set verify off
prompt
prompt Job defined by an existing program and schedule.
prompt
prompt Other job defined in this file
prompt 

begin
dbms_scheduler.create_job (
   job_name             => '&job_name', 
   schedule_name 		=> '&schedule_name',
   program_name  		=> '&program_name',
   enabled              =>  &enabled,
   comments             => '&comments');
   
    sys.dbms_scheduler.set_attribute( 
             name => '&job_name', 
             attribute => 'restartable', value => &restartable);
    sys.dbms_scheduler.set_attribute( 
             name => '&job_name', 
             attribute => 'stop_on_window_close', value => &stop_on_window_close);
    sys.dbms_scheduler.set_attribute( 
             name => '&job_name', 
             attribute => 'logging_level', value => dbms_scheduler.logging_full);
    sys.dbms_scheduler.set_attribute( 
             name => '&job_name', 
             attribute => 'raise_events', value => '511');
end;
/

/*
-- Create jobs.

repeat_interval cada 10 minutos: FREQ=MINUTELY;INTERVAL=10

BEGIN
  -- Job defined entirely by the CREATE JOB procedure.
  DBMS_SCHEDULER.create_job (
    job_name        => 'test_full_job_definition',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN DBMS_STATS.gather_schema_stats(''SCOTT''); END;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'freq=hourly; byminute=0',
    end_date        => NULL,
    enabled         => TRUE,
    comments        => 'Job defined entirely by the CREATE JOB procedure.');

  -- Job defined by an existing program and schedule.
  DBMS_SCHEDULER.create_job (
    job_name      => 'test_prog_sched_job_definition',
    program_name  => 'test_plsql_block_prog',
    schedule_name => 'test_hourly_schedule',
    enabled       => TRUE,
    comments      => 'Job defined by an existing program and schedule.');

  -- Job defined by existing program and inline schedule.
  DBMS_SCHEDULER.create_job (
    job_name        => 'test_prog_job_definition',
    program_name    => 'test_plsql_block_prog',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'freq=hourly; byminute=0',
    end_date        => NULL,
    enabled         => TRUE,
    comments        => 'Job defined by existing program and inline schedule.');

  -- Job defined by existing schedule and inline program.
  DBMS_SCHEDULER.create_job (
     job_name      => 'test_sched_job_definition',
     schedule_name => 'test_hourly_schedule',
     job_type      => 'PLSQL_BLOCK',
     job_action    => 'BEGIN DBMS_STATS.gather_schema_stats(''SCOTT''); END;',
     enabled       => TRUE,
     comments      => 'Job defined by existing schedule and inline program.');
END;
/

*/