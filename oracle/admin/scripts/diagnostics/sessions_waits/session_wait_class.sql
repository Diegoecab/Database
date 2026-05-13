-- ------------------------------------------------------------------------------
-- File       : session_wait_class.sql
-- Purpose    : Oracle diagnostic query/report helper: session wait class.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @session_wait_class.sql
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
--v$session_wait_class.sql
select * from v$session_wait_class
where sid = &sid
and wait_class != 'Idle'
order by time_waited desc
/


prompt
prompt v$session_wait_class: Waits in session 
prompt v$session_wait_history: History waits in sessions
prompt v$session_wait: Current sessions waits
prompt