/* para determinar los bloqueos en 10g ver nuevas columnas en v$session */
/* ver nota en yahoo */

select BLOCKING_SESSION_STATUS, BLOCKING_SESSION
from v$session 
where sid = 269
/

/* mas información de bloqueo: ( time in centiseconds ) */
select * from v$session_wait_class where sid = 269
/

select event, wait_time, wait_count
from v$session_wait_history
where sid = 265
/