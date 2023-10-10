--v$session_wait_history.sql
select sid, seq#, event, wait_time, p1, p2, p3
  from v$session_wait_history
 where upper(event) like upper('%&event%')
 /
 
prompt
prompt v$session_wait_class: Waits in session 
prompt v$session_wait_history: History waits in sessions
prompt v$session_wait: Current sessions waits
prompt