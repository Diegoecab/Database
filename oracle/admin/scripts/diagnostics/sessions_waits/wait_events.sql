-- ------------------------------------------------------------------------------
-- File       : wait_events.sql
-- Purpose    : Oracle diagnostic query/report helper: wait events.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @wait_events.sql
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
col event for a80
col wait_class for a30
set linesize 180
select EVENT,TOTAL_WAITS,TOTAL_TIMEOUTS,TIME_WAITED,EVENT_ID,WAIT_CLASS
from
   v$system_event
where
   event like '%wait%'
   order by total_waits;
   
prompt session wait 
select event, state, count(*) from v$session_wait group by event, state order by 3 desc;