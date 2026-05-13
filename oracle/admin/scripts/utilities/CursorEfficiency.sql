-- ------------------------------------------------------------------------------
-- File       : CursorEfficiency.sql
-- Purpose    : Oracle administration helper: CursorEfficiency.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @CursorEfficiency.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--

REM Filename  CursorEfficiency.sql
REM 

col "parameter" format a30 head "Init Parameter"
col value format 999,999,999,999 Head "Limit" 
col usage head "Max|Usage" 

spool efficiency.out
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
      n.name in ('opened cursors current') and
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

spool off

/* -----------------------------------------------------

Sample Output:

                                                             Max
Init Parameter                          Limit  Usage
---------------------------------------- ------- ---------
session_cached_cursors            25  100%
open_cursors                             300     19%

*/
 