select distinct event, total_waits, time_waited/100 wait_Secs, average_wait/100 avg_wait_secs
from v$session_event e, v$mystat s
where event like 'cell%' and e.sid = s.sid;