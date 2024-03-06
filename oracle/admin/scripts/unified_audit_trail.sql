set lines 900
col unified_audit_policies for a20
col dbusername for a20
col action_name for a20
col object_schema for a20
col object_name for a30
col sql_text for a50 truncate
col event_timestamp for a30

 select unified_audit_policies,event_timestamp,
dbusername,
action_name,
object_schema,
object_name,
sql_text
from unified_audit_trail
WHERE event_timestamp > trunc(sysdate) and UPPER(object_name)='EXT_LIB';
