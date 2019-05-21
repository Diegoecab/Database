set pagesize 50 linesize 150

col sid format 999999
col serial# format 999999
col username format a12 trunc
col process format a8 trunc
col terminal format a12 trunc
col type format a12 trunc
col lmode format a4 trunc
col lrequest format a4 trunc
col object format a50 trunc

select s.sid, s.serial#,
       decode(s.process, null,
          decode(substr(p.username,1,1), '?',   upper(s.osuser), p.username),
          decode(       p.username, 'ORACUSR ', upper(s.osuser), s.process)
       ) process,
       nvl(s.username, 'SYS ('||substr(p.username,1,4)||')') username,
       decode(s.terminal, null, rtrim(p.terminal, chr(0)),
              upper(s.terminal)) terminal,
       l.type type,
	O.NAME OBJECT
from   sys.v_$lock l, sys.v_$session s, sys.obj$ o, sys.user$ u,
       sys.v_$process p
where  s.paddr  = p.addr(+)
  and  l.sid    = s.sid
  and  l.id1    = o.obj#(+)
  and  o.owner# = u.user#(+)
 -- and  o.name = 'THAZ_EMP'
  and  l.type   <> 'MR'
/
