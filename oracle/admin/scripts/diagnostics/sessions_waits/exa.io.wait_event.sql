-- ------------------------------------------------------------------------------
-- File       : exa.io.wait_event.sql
-- Purpose    : Oracle diagnostic query/report helper: exa io wait event.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exa.io.wait_event.sql
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
select distinct event, total_waits, time_waited/100 wait_Secs, average_wait/100 avg_wait_secs
from v$session_event e, v$mystat s
where event like 'cell%' and e.sid = s.sid;