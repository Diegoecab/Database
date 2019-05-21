--v$open_cursor
set pagesize 1000
PROMPT Cantidad de cursores abiertos por sesion
PROMPT
select user_name, sid, count(1) as count
from sys.v_$open_cursor
group by user_name, sid
order by count
/
PROMPT
PROMPT Se puede ver los cursores abiertos con sql sql_text por SID, con v$open_cursor_sid
PROMPT