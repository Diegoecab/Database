REM	Script para ver utilizacion de cursores por sesiones
REM ======================================================================
REM utilizacion_cursores_sesiones.sql		Version 1.1	18 Marzo 2010
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

SET pages 1000 lines 200 feed OFF echo OFF
COLUMN username    heading 'DB User' format a12
COLUMN act_sess    heading 'Active|Sessions' format 9,999
COLUMN inact_sess  heading 'Inactive|Sessions' format 9,999
COLUMN tot_sess    heading 'Total|Sessions' format 99,999
COLUMN act_curs    heading 'Active|Cursors' format 999,999
COLUMN inact_curs  heading 'Inactive|Cursors' format 999,999
COLUMN tot_curs    heading 'Total|Cursors' format 9,999,999
break ON report
compute SUM label 'Total Count:' OF tot_sess tot_curs ON report
SELECT username,
act_sess,
inact_sess,
(act_sess+inact_sess) AS tot_sess,
act_curs,
inact_curs,
(act_curs+inact_curs) AS tot_curs
FROM
(SELECT s.username,
(SELECT COUNT(*) FROM v$session ss WHERE ss.username = s.username AND ss.status = 'ACTIVE') AS act_sess,
(SELECT COUNT(*) FROM v$session ss WHERE ss.username = s.username AND ss.status = 'INACTIVE') AS inact_sess,
COUNT(DECODE(s.status, 'ACTIVE', oc.sid)) AS act_curs,
COUNT(DECODE(s.status, 'INACTIVE', oc.sid)) AS inact_curs
FROM v$open_cursor oc inner join v$session s ON oc.sid = s.sid
WHERE s.username NOT IN ('SYS', 'SYSTEM')
GROUP BY s.username)
ORDER BY tot_curs DESC
/
clear breaks
clear COLUMNS


REM Utilizacion de cursores para la sesion actual
prompt
prompt
prompt Utilizacion de cursores para la sesion actual:
select a.value, b.name 
            from v$mystat a, v$statname b 
           where a.statistic# = b.statistic# 
             and b.name = 'opened cursors current';

REM Utilizacion de cursores para todas las sesiones
prompt
prompt Utilizacion de cursores para todas las sesiones:
col username for a12
col sid for a4
col value for a5
col name for a30

select a.sid,c.username,a.value
      from v$sesstat a, v$statname b, v$session c
     where a.statistic# = b.statistic#
       and b.name = 'opened cursors current'
	   and c.sid=a.sid
	   order by c.username,a.value;
	   
REM Utilizacion de cursores
prompt
prompt Utilizacion de Cursores:
prompt
col value for a5
col usage for a10
col parameter for a23
select
  'session_cached_cursors'  parameter,
  lpad(value, 5)  value,
  decode(value, 0, '  n/a', to_char(100 * used / value, '990') || '%')  usage
from
  ( select
      max(s.value)  used
    from
      v$statname  n,
      v$sesstat  s
    where
      n.name = 'session cursor cache count' and
      s.statistic# = n.statistic#
  ),
  ( select
      value
    from
      v$parameter
    where
      name = 'session_cached_cursors'
  )
union all
select
  'open_cursors',
  lpad(value, 5),
  to_char(100 * used / value,  '990') || '%'
from
  ( select
      max(sum(s.value))  used
    from
      v$statname  n,
      v$sesstat  s
    where
      n.name in ('opened cursors current', 'session cursor cache count') and
      s.statistic# = n.statistic#
    group by
      s.sid
  ),
  ( select
      value
    from
      v$parameter
    where
      name = 'open_cursors'
  );