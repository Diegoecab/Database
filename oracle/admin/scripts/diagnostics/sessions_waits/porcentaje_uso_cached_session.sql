-- ------------------------------------------------------------------------------
-- File       : porcentaje_uso_cached_session.sql
-- Purpose    : oracle/admin diagnostics/sessions_waits helper: porcentaje uso cached session.
-- Engine     : oracle/admin
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: porcentaje_uso_cached_session.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
/*Ver porcentaje de soft parses y hard parses*/
select to_char(100 * sess / calls, '999999999990.00') || '%' cursor_cache_hits,
       to_char(100 * (calls - sess - hard) / calls, '999990.00') || '%' soft_parses,
       to_char(100 * hard / calls, '999990.00') || '%' hard_parses
from ( select value calls from v$sysstat where name = 'parse count (total)' ),
     ( select value hard from v$sysstat where name = 'parse count (hard)' ),
     ( select value sess from v$sysstat where name = 'session cursor cache hits' ) ;

/* Valor y porcentaje de uso de session_cached_cursors y open_cursors
Si el valor del SESSION_CACHED_CURSORS se encuentra en el 100%,
 deberíamos incrementar el valor del parámetro con normalidad.*/
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


