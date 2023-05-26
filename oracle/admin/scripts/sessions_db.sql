REM    Script para ver las sesiones actuales en la base de datos
REM ======================================================================
REM sessions_db.sql        Version 1.1    29 Marzo 2010
REM
REM Autor:
REM Diego Cabrera
REM
REM Proposito:
REM
REM Dependencias:
REM
REM
REM Notas:
REM
REM Precauciones:
REM
REM ======================================================================
REM
set pagesize 10000
set linesize 900
set verify off
set lines 900


clear col
col machine  for a30 truncate
col program for a20 truncate
col osuser for a15 truncate
col status for a10 truncate
col username for a20 truncate
col sid for 9999
col last_act for 99999
col logon_time  for a25 truncate
col service_name for a20 truncate
col cnt for 999
col resource_consumer_group for a15 truncate
--col spid heading 'OsPid'
--col pq_status heading 'Parallel|Query'
--col min_inac heading 'Min|Inact'
col sql_id for a13
--col pdml_status heading 'Parallel|dml'
--col pddl_status heading 'Parallel|ddl'
col client_identifier for a30
col kill_sess for a100

break on report
@nls_date
compute sum of num_user_sess active# inactive# on report

PROMPT
PROMPT Sesiones en la base de datos
PROMPT

select  lpad (nvl (sess.username, '[B.G. Process]'), 20) username, count ( * ) num_user_sess, nvl (act.count, 0) active#, nvl (inact.count, 0) inactive# 
from   v$session sess,
(select   count ( * ) count, nvl (username, '[B.G. Process]') username from   v$session where   status = 'ACTIVE' group by   username) act,
(select   count ( * ) count, nvl (username, '[B.G. Process]') username from   v$session where   status = 'INACTIVE' group by   username) inact
where   nvl (sess.username, '[B.G. Process]') = act.username(+)
and nvl (sess.username, '[B.G. Process]') = inact.username(+)
group by sess.username, act.count, inact.count
order by 1;

select sessions_current, sessions_highwater from v$license;



SELECT NVL(s.username, '[bkgrnd]') AS username,
       s.inst_id, count(*) cnt
FROM   gv$session s,
       gv$process p
WHERE  s.paddr   = p.addr
AND    s.inst_id = p.inst_id
GROUP BY NVL(s.username, '[bkgrnd]'), s.inst_id
ORDER BY 1
/



prompt


SELECT NVL(s.username, '(oracle)') AS username,status,osuser,
       s.machine,
service_name,
       s.program,
	   logon_time,
resource_consumer_group,
count(*) cnt
FROM   gv$session s,
       gv$process p
WHERE  s.paddr   = p.addr
AND    s.inst_id = p.inst_id
--and s.username ='EXT_USER1'
group by NVL(s.username, '(oracle)'), status,osuser,
       s.machine,
service_name,
       s.program,
	   logon_time,
	   resource_consumer_group
order by logon_time desc
/

prompt


SELECT NVL(s.username, '(oracle)') AS username,status,osuser,
service_name,
count(*) cnt
FROM   gv$session s,
       gv$process p
WHERE  s.paddr   = p.addr
AND    s.inst_id = p.inst_id
--and s.username ='EXT_USER1'
group by NVL(s.username, '(oracle)'), status,osuser,
service_name
order by 5 desc
/

prompt


SELECT NVL(s.username, '(oracle)') AS username,MIN(LOGON_TIME),max(LOGON_TIME),status,osuser,machine,
service_name,
count(*) cnt
FROM   gv$session s,
       gv$process p
WHERE  s.paddr   = p.addr
AND    s.inst_id = p.inst_id
--and s.username ='EXT_USER1'
group by NVL(s.username, '(oracle)'), status,osuser,machine,
service_name
order by 5 desc
/

/*

SELECT NVL(s.username, '(oracle)') AS username,
       s.machine,
count(*) cnt
FROM   gv$session s,
       gv$process p
WHERE  s.paddr   = p.addr
AND    s.inst_id = p.inst_id
--and s.username ='EXT_USER1'
group by NVL(s.username, '(oracle)'),s.machine
order by 1,2
/

/

*/
prompt


--
-- List all sessions for RAC.
--
 /*
 
 
SELECT to_char(s.logon_Time,'DD-MON-YYYY HH24') , count(*)
FROM   gv$session s,
       gv$process p
WHERE  s.paddr   = p.addr
AND    s.inst_id = p.inst_id
and s.username ='MBANKING'
group by to_char(s.logon_Time,'DD-MON-YYYY HH24') 
ORDER BY 1
/


*/