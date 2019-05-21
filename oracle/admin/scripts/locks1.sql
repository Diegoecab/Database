select inst_id,sid, serial#, username, program, status, lockwait
from gv$session
where username is not null
and lockwait is not null
/
