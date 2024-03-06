--v$active_session_history
set verify off
set lines 900


select b.username,a.user_id, a.session_id, a.SESSION_SERIAL#,  sample_time, module, program, pid
from sys.wrh$_active_session_history a, dba_users b
where b.user_id=a.user_id
and a.session_id=&session_id
and b.username like upper('%&username%')
order by sample_time
/