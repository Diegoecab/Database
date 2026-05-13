-- ------------------------------------------------------------------------------
-- File       : opened_cursors_current.sql
-- Purpose    : Oracle administration helper: opened cursors current.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @opened_cursors_current.sql
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
select a.value, s.username, s.sid, s.serial#
from v$sesstat a, v$statname b, v$session s
where a.statistic# = b.statistic# and s.sid=a.sid
and b.name = 'opened cursors current'
order by 1
/
