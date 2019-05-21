--dbms_scheduler.create_schedule.sql

@dba_scheduler_schedules.sql

prompt
prompt Examples
prompt
prompt schedule_name:	"DBADMIN"."DBS_STATISTICS"
prompt Start/End date: 07-SEP-10 12.00.00.000000 AM AMERICA/BUENOS_AIRES
prompt Repeat Interval: FREQ=DAILY / freq=daily;byday=MON,TUE,WED,THU,FRI;byhour=22;byminute=0; bysecond=0
prompt

-- create schedule.
begin
  dbms_scheduler.create_schedule (
    schedule_name   => '&schedule_name',
    start_date      => '&start_date',
    repeat_interval => '&repeat_interval',
    end_date        => null,
    comments        => '&comments');
end;
/

@dba_scheduler_schedules.sql