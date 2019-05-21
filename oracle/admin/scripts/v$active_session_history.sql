--v$active_session_history
set verify off

select b.username,a.user_id, a.session_id, sample_time, module, program 
from sys.wrh$_active_session_history a, dba_users b
where b.user_id=a.user_id
and a.session_id=&session_id
and b.username like upper('%&username%')
order by sample_time
/