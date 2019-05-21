select a.sid, a.serial#, a.username,
b.owner, b.object, b.type
from   v$session a, v$access b
where  a.sid = b.sid
and b.object like upper('%&1%')
/