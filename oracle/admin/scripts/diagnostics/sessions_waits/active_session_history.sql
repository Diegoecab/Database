-- ------------------------------------------------------------------------------
-- File       : active_session_history.sql
-- Purpose    : Oracle diagnostic query/report helper: active session history.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @active_session_history.sql
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
--v$active_session_history
set verify off
set lines 900


select b.username,a.user_id, a.session_id, a.SESSION_SERIAL#,  sample_time, module, program, pid
from sys.wrh$_active_session_history a, dba_users b
where b.user_id=a.user_id
and a.session_id=&session_id
and b.username like upper('%&username%')
order by sample_time
/