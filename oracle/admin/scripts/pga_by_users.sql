set lines 900
col maxmem for 9999
col osuser for a20
select s.osuser osuser,s.serial# serial,se.sid,n.name,
max(se.value)/1024/1024 maxmem
from v$sesstat se,
v$statname n
,v$session s
where n.statistic# = se.statistic#
and n.name in ('session pga memory','session pga memory max',
'session uga memory','session uga memory max')
and s.sid=se.sid
group by n.name,se.sid,s.osuser,s.serial#
order by 2;