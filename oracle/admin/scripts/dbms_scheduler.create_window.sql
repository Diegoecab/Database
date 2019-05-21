--dbms_scheduler.create_window.sql
@dba_rsrc_plans
prompt
prompt Examples
prompt
prompt Start/End date: 07-SEP-10 12.00.00.000000 AM AMERICA/BUENOS_AIRES
prompt Repeat Interval: FREQ=DAILY / freq=daily;byday=MON,TUE,WED,THU,FRI;byhour=22;byminute=0; bysecond=0
prompt repeat_interval = frequency_clause
prompt [; interval=?] [; bymonth=?] [; byweekno=?] 
prompt   [; byyearday=?] [; bymonthday=?] [; byday=?] 
prompt   [; byhour=?] [; byminute=?] [; bysecond=?]
prompt
prompt frequency_clause = "FREQ" "=" frequency
prompt    frequency = "YEARLY" | "MONTHLY" | "WEEKLY" | "DAILY" | 
prompt    "HOURLY" | "MINUTELY" | "SECONDLY"
prompt window_priority: HIGH / LOW
prompt

BEGIN
DBMS_SCHEDULER.CREATE_WINDOW (
   window_name     =>  '&window_name',
   resource_plan   =>  '&resource_plan',
   start_date      =>  '&start_date',
   repeat_interval =>  '&repeat_interval',
   end_date        =>  '&end_date',
   duration        =>  interval '&duration_mins' minute,
   window_priority =>  '&window_priority',
   comments        =>  '&comments');
END;
/

prompt Add Window to Win group: dbms_scheduler.add_window_group_member.sql

prompt
@dba_scheduler_windows
prompt

