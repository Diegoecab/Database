--v$session_wait_class.sql
select * from v$session_wait_class
where sid = &sid
and wait_class != 'Idle'
order by time_waited desc
/


prompt
prompt v$session_wait_class: Waits in session 
prompt v$session_wait_history: History waits in sessions
prompt v$session_wait: Current sessions waits
prompt