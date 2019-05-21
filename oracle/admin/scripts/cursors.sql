REM	Script para ver utilizacion de cursores , parametros open_cursors y session_cached_cursors
REM ======================================================================
REM utilizacion_cursores.sql		Version 1.1	16 Marzo 2010
REM
REM Autor: 
REM Diego Cabrera
REM 
REM Proposito:
REM
REM Dependencias:
REM	v_$statname, v_$sesstat, v_$parameter
REM
REM Notas:
REM 	Ejecutar con usuario dba
REM	Para Oracle version 7.3, 8.0, 8.1, 9.0, 9.2, 10.1 y 10.2 solamente
REM
REM Precauciones:
REM	
REM ======================================================================
REM



select
'session_cached_cursors'  parameter,
lpad(value, 5)  value,
decode(value, 0, '  n/a', to_char(100 * used / value, '990') || '%')  usage
from
( select
    max(s.value)  used
  from
    sys.v_$statname  n,
    sys.v_$sesstat  s
  where
    n.name = 'session cursor cache count' and
    s.statistic# = n.statistic#
),
( select
    value
  from
    sys.v_$parameter
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
    sys.v_$statname  n,
    sys.v_$sesstat  s
  where
    n.name in ('opened cursors current', 'session cursor cache count') and
    s.statistic# = n.statistic#
  group by
    s.sid
),
( select
    value
  from
    sys.v_$parameter
  where
    name = 'open_cursors'
) ;

select to_char(100 * sess / calls, '999999999990.00') || '%' cursor_cache_hits,
       to_char(100 * (calls - sess - hard) / calls, '999990.00') || '%' soft_parses,
       to_char(100 * hard / calls, '999990.00') || '%' hard_parses
from ( select value calls from v$sysstat where name = 'parse count (total)' ),
     ( select value hard from v$sysstat where name = 'parse count (hard)' ),
     ( select value sess from v$sysstat where name = 'session cursor cache hits' ) ;