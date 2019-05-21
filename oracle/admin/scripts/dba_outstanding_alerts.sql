--dba_outstanding_alerts
col suggested_action for a30
col reason for a50
col object_type for a10
col message_level heading 'mess|lvl' for 9
select
  to_char(creation_time, 'dd-mm-yyyy hh24:mi') crt,
  object_type,
  message_type,
  message_level,
  reason,
  suggested_action
from
  dba_outstanding_alerts
 order by
     creation_time
/