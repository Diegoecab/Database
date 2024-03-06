col rownum for 99
col event for a40
set linesize 180
 select
*
from
  (select
    event,
   total_waits,
     time_waited
from
       v$session_event
  where
     sid='&SID'--SYS_CONTEXT('USERENV','SID')
  order by
       time_waited desc)
where
 rownum <= 5;