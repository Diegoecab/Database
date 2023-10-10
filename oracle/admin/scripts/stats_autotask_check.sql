--stats_autotask_check.sql
Prompt
Prompt Is 'auto optimizer stats collection' enabled ?
Prompt
set lines 600
set pages 1000
col WINDOW_NAME for a20 truncate
col repeat_interval for a80 truncate
col client_name for a20 truncate
select client_name, status, window_group from dba_autotask_client  where client_name like '%stats%';
select operation_name, status from dba_autotask_operation where client_name like '%stats%';

Prompt
PROMPT To Enable the AutoTask Operation for the auto optimizer stats job.
PROMPT SQL> exec DBMS_AUTO_TASK_ADMIN.ENABLE(client_name => 'auto optimizer stats collection', operation => 'auto optimizer stats job', window_name => NULL);

Prompt
Prompt Is ORA$AT_WGRP_OS window group is enabled ?

select * from dba_scheduler_wingroup_members where WINDOW_GROUP_NAME='ORA$AT_WGRP_OS';
select window_name, repeat_interval, duration, enabled, active from dba_scheduler_windows order by window_name;

Prompt
Prompt Is the optimizer task enabled?
Prompt

select * from DBA_AUTOTASK_WINDOW_CLIENTS;

Prompt
Prompt Is there a group for 'auto optimizer stats collection'? Is it enabled? Is the next start date ok?
Prompt
col WINDOW_GROUP_NAME for a40 truncate
col COMMENTS for a40 truncate
select * from DBA_SCHEDULER_WINDOW_GROUPS;
Prompt
	
Prompt Has 'auto optimizer stats collection' ever successfully completed?
col WINDOW_DURATION for a40 truncate
select * from DBA_AUTOTASK_CLIENT_HISTORY where client_name like 'auto optimizer stats%' order by WINDOW_START_TIME;

col additional_info for a100
col run_duration for a20
col job_name for a40
col day for a6
set lines 400
set verify off

select log_id, job_name, status, 
to_char(log_date, 'dd-mon-yyyy hh24:mi') fecha_log, to_char(log_date, 'dy') day, run_duration, error#, additional_info
from dba_scheduler_job_run_details
where upper(job_name) like 'ORA$%OS%'
and log_date>sysdate-30
order by log_date asc;

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