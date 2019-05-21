col event for a80
col wait_class for a30
set linesize 180
select EVENT,TOTAL_WAITS,TOTAL_TIMEOUTS,TIME_WAITED,EVENT_ID,WAIT_CLASS
from
   v$system_event
where
   event like '%wait%'
   order by total_waits;
   
prompt session wait 
select event, state, count(*) from v$session_wait group by event, state order by 3 desc;