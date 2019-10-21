REM	Script para listar los usuarios que consumen mas tablespace de undo
REM ======================================================================
REM undo_xuser.sql		Version 1.1	29 Abril 2010
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
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM

col username for a20
col program for a40
col name for a30
col osuser for a15
col sid for 99999999

SELECT c.username, a.sid, c.program, b.name , a.value 
FROM V$SESSTAT a, v$statname b, v$session c 
WHERE rownum < 10 and
a.statistic# = b.statistic# 
AND a.sid = c.sid 
AND b.name like '%undo%' 
AND a.value > 0
order by value desc;

SELECT  a.sid, a.username,a.program,a.osuser,b.used_urec, b.used_ublk
FROM v$session a, v$transaction b
WHERE a.saddr = b.ses_addr
ORDER BY b.used_ublk DESC;

SELECT a.sid,c.username,c.program,c.osuser,b.name, a.value
FROM v$sesstat a, v$statname b, v$session c
WHERE  rownum < 10 and
a.statistic# = b.statistic#
and c.sid=a.sid
AND a.statistic# = 176  -- Es el ID de undo change vector size
ORDER BY a.value DESC;

clear col

@@undo_sessions.sql