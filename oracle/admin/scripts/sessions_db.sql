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
set linesize 600
set verify off

clear col
col machine  for a30
col program for a50
col username for a21
col sid for 9999
col last_act for 99999
col logon_time  for a15
--col spid heading 'OsPid'
--col pq_status heading 'Parallel|Query'
--col min_inac heading 'Min|Inact'
col sql_id for a13
--col pdml_status heading 'Parallel|dml'
--col pddl_status heading 'Parallel|ddl'
col client_identifier for a30
col kill_sess for a60

break on report

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


select   s.username, module, machine, s.osuser, s.program, ownerid, sid, s.serial#, status, round (last_call_et / 60) min_act, to_char (logon_time, 'DD/MM HH24:MI:SS') logon_time,
floor (last_call_et / 60) last_act, resource_consumer_group, pq_status, pdml_status, pddl_status, 'alter system kill session '''||sid||','||s.serial#||''' immediate;' kill_sess, p.spid, 'kill -9 '||p.spid kill_proc,
client_identifier, action
from   v$session s, v$process p
where   s.paddr = p.addr 
and s.username is not null 
and s.username like upper('%&username%') 
and sid like upper('%&sid%')
and status like upper('&status%')
order by 1, 2, 3, 7;

prompt