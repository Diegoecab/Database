-- ------------------------------------------------------------------------------
-- File       : active_session_history_active_sessions_count.sql
-- Purpose    : Oracle diagnostic query/report helper: active session history active sessions count.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @active_session_history_active_sessions_count.sql
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
/*Max active sessions count during last hour*/

select max(cnt) from 
(SELECT count(*) cnt, SESSION_STATE, WAIT_CLASS, sample_time FROM gv$active_session_history where  
SAMPLE_TIME > SYSDATE - INTERVAL '60' MINUTE AND SAMPLE_TIME <= TRUNC(SYSDATE, 'MI') 
group by session_state, wait_class, sample_time order by sample_time)
/
