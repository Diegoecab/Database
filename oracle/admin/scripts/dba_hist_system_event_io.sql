select
event_name,
total_waits,
end_interval_time,
TIME_WAITED_MICRO,
TOTAL_TIMEOUTS
from
dba_hist_system_event stat,
dba_hist_snapshot ss
   where       
ss.snap_id=stat.snap_id and
(event_name like 'db file %' or
event_name = 'free buffer waits' or
event_name = 'write complete waits' ) and
ss.end_interval_time > trunc (sysdate - 1)
	   and ss.instance_number = stat.instance_number
order by
TIME_WAITED_MICRO;