REM    Script para ver las sesiones actuales en la base de datos
REM ======================================================================
REM v$session.sql        Version 1.1    29 Marzo 2010
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
col sql_id for a13
col client_identifier for a30
col kill_sess for a60
col module for a50
col osuser for a8

select   s.username, s.osuser,  sid, s.serial#, 
status, round (last_call_et / 60) min_act, to_char (logon_time, 'DD/MM HH24:MI:SS') logon_time,
floor (last_call_et / 60) last_act,  'alter system kill session '''||sid||','||s.serial#||''' immediate;' kill_sess,
module, machine, s.program
from   v$session s
where
s.username is not null 
and s.username like upper('%&username%') 
and sid like upper('%&sid%')
and status like upper('&status%')
order by 1, 2, 3, 7;
