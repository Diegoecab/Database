set linesize 220
col username format a20
col obj_name format a20
col priv_used format a20
col action_name format a20
col userhost format a20
select count(*) cant, username, obj_name, priv_used, action_name, userhost
from dba_audit_trail
group by username, obj_name, priv_used, action_name, userhost
/
