set lines 900
col maxmem for 9999
col osuser for a20
col LOGON for a40 truncate

select s.osuser osuser,s.serial# serial,se.sid,n.name,
max(se.value)/1024/1024 maxmem
from v$sesstat se,
v$statname n
,gv$session s
where n.statistic# = se.statistic#
and n.name in ('session pga memory','session pga memory max',
'session uga memory','session uga memory max')
and s.sid=se.sid
group by n.name,se.sid,s.osuser,s.serial#
order by 2;



SELECT inst_id,DECODE(TRUNC(SYSDATE - LOGON_TIME), 0, NULL, TRUNC(SYSDATE - LOGON_TIME) || ' Days' || ' + ') || 
TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-LOGON_TIME,1) * 86400), 'SSSSS'), 'HH24:MI:SS') LOGON, 
SID, s.SERIAL#, v$process.SPID , ROUND(v$process.pga_used_mem/(1024*1024), 2) PGA_MB_USED, 
s.USERNAME, STATUS, OSUSER, MACHINE, s.PROGRAM, MODULE 
FROM gv$session s, v$process 
WHERE s.paddr = v$process.addr 
--and status = 'ACTIVE' 
--and v$session.sid = 97
--and v$session.username = 'SYSTEM' 
--and v$process.spid = 24301
ORDER BY pga_used_mem;