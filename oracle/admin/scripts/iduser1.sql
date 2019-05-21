select sid,s.serial#, spid,  process cpid, s.username,
to_char(s.logon_time,'DD/MM/YYYY HH24:MI:SS') logon_time,
to_char(sysdate - last_call_et / 86400,'DD/MM/YYYY HH24:MI:SS') last_call_et,
s.status, SERVER
from v$session s,v$process
where addr(+)=paddr
and s.username like upper('%&&1%')
and (sysdate - last_call_et / 86400) < (sysdate - 60/1440)
order by s.username,sid
/
