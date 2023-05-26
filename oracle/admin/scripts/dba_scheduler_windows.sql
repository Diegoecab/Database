--dba_scheduler_windows.sql
PROMPT Windows, filter by window group name

set lines 400
set feed off
set verify off
alter session set nls_date_format='dd/mm/yyyy hh24:mi';
col schedule_owner heading 'Schedule|Owner' for a5
col schedule_name heading 'Schedule|Name' for a5
col repeat_interval for a80
col next_start_date for a50
col last_start_date for a50
col start_date for a50
col end_date for a20
col duration for a20
col window_name for a25
col resource_plan heading 'Resource|Plan' for a25
col comments for a60
col manual_open_time for a30
col manual_duration for a20
select a.window_name,resource_plan,repeat_interval,duration,window_priority,next_start_date,last_start_date,enabled,active,schedule_type,comments
from dba_scheduler_windows a
where a.window_name like upper('%&window_name%')
/

PROMPT
PROMPT *****************************************************
PROMPT Windows:		dba_scheduler_windows.sql
PROMPT Jobs:			dba_scheduler_jobs_x.sql
PROMPT Job Run Details:	dba_scheduler_job_run_details.sql
PROMPT Programs:		dba_scheduler_programs.sql
prompt schedules:		dba_scheduler_schedules.sql
PROMPT *****************************************************
PROMPT
/*
SQL> select * from dba_scheduler_wingroup_members where WINDOW_GROUP_NAME='ORA$AT_WGRP_OS';

WINDOW_GROUP_NAME                                                                                                                WINDOW_NAME
-------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------
ORA$AT_WGRP_OS                                                                                                                   MONDAY_WINDOW
ORA$AT_WGRP_OS                                                                                                                   TUESDAY_WINDOW
ORA$AT_WGRP_OS                                                                                                                   WEDNESDAY_WINDOW
ORA$AT_WGRP_OS                                                                                                                   THURSDAY_WINDOW
ORA$AT_WGRP_OS                                                                                                                   FRIDAY_WINDOW
ORA$AT_WGRP_OS                                                                                                                   SATURDAY_WINDOW
ORA$AT_WGRP_OS                                                                                                                   SUNDAY_WINDOW
SQL> 
SQL> /

set lines 600

SQL> l
  1* select window_name, repeat_interval, duration from dba_scheduler_windows order by window_name

SQL> col WINDOW_NAME for a20 truncate
col repeat_interval for a80 truncate
SQL> /

WINDOW_NAME          REPEAT_INTERVAL      DURATION
-------------------- -------------------- ---------------------------------------------------------------------------
FRIDAY_WINDOW        freq=daily;byday=FRI +000 04:00:00
MONDAY_WINDOW        freq=daily;byday=MON +000 04:00:00
SATURDAY_WINDOW      freq=daily;byday=SAT +000 20:00:00
SUNDAY_WINDOW        freq=daily;byday=SUN +000 20:00:00
THURSDAY_WINDOW      freq=daily;byday=THU +000 04:00:00
TUESDAY_WINDOW       freq=daily;byday=TUE +000 04:00:00
WEDNESDAY_WINDOW     freq=daily;byday=WED +000 04:00:00
WEEKEND_WINDOW       freq=daily;byday=SAT +002 00:00:00
WEEKNIGHT_WINDOW     freq=daily;byday=MON +000 08:00:00



select 'exec dbms_scheduler.set_attribute('''||window_name||''',''repeat_interval'','''||REPEAT_INTERVAL||''');' from dba_scheduler_windows order by window_name;

EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE('MONDAY_WINDOW',   'repeat_interval','freq=daily;byday=MON;byhour=05;byminute=0; bysecond=0');
EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE('TUESDAY_WINDOW',  'repeat_interval','freq=daily;byday=TUE;byhour=05;byminute=0; bysecond=0');
EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE('WEDNESDAY_WINDOW','repeat_interval','freq=daily;byday=WED;byhour=05;byminute=0; bysecond=0');
EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE('THURSDAY_WINDOW', 'repeat_interval','freq=daily;byday=THU;byhour=05;byminute=0; bysecond=0');
EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE('FRIDAY_WINDOW',   'repeat_interval','freq=daily;byday=FRI;byhour=05;byminute=0; bysecond=0');
EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE('SATURDAY_WINDOW', 'repeat_interval','freq=daily;byday=SAT;byhour=13;byminute=0; bysecond=0');
EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE('SUNDAY_WINDOW',   'repeat_interval','freq=daily;byday=SUN;byhour=13;byminute=0; bysecond=0');

exec dbms_scheduler.set_attribute('FRIDAY_WINDOW','repeat_interval','freq=daily;byday=FRI;byhour=22;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('MONDAY_WINDOW','repeat_interval','freq=daily;byday=MON;byhour=22;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('SATURDAY_WINDOW','repeat_interval','freq=daily;byday=SAT;byhour=6;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('SUNDAY_WINDOW','repeat_interval','freq=daily;byday=SUN;byhour=6;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('THURSDAY_WINDOW','repeat_interval','freq=daily;byday=THU;byhour=22;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('TUESDAY_WINDOW','repeat_interval','freq=daily;byday=TUE;byhour=22;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('WEDNESDAY_WINDOW','repeat_interval','freq=daily;byday=WED;byhour=22;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('WEEKEND_WINDOW','repeat_interval','freq=daily;byday=SAT;byhour=0;byminute=0;bysecond=0');
exec dbms_scheduler.set_attribute('WEEKNIGHT_WINDOW','repeat_interval','freq=daily;byday=MON,TUE,WED,THU,FRI;byhour=22;byminute=0; bysecond=0');


exec dbms_scheduler.set_attribute('FRIDAY_WINDOW','repeat_interval','freq=daily;byday=FRI;byhour=16;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('MONDAY_WINDOW','repeat_interval','freq=daily;byday=MON;byhour=16;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('THURSDAY_WINDOW','repeat_interval','freq=daily;byday=THU;byhour=16;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('TUESDAY_WINDOW','repeat_interval','freq=daily;byday=TUE;byhour=16;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('WEDNESDAY_WINDOW','repeat_interval','freq=daily;byday=WED;byhour=16;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('SATURDAY_WINDOW','repeat_interval','freq=daily;byday=SAT;byhour=16;byminute=0; bysecond=0');
exec dbms_scheduler.set_attribute('SUNDAY_WINDOW','repeat_interval','freq=daily;byday=SUN;byhour=16;byminute=0; bysecond=0');

exec dbms_scheduler.set_attribute('SATURDAY_WINDOW','duration','+000 08:00:00');
exec dbms_scheduler.set_attribute('SUNDAY_WINDOW','duration','+000 08:00:00');






9 rows selected.


*/