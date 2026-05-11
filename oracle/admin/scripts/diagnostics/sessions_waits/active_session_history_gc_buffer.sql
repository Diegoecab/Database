-- ------------------------------------------------------------------------------
-- File       : active_session_history_gc_buffer.sql
-- Purpose    : Oracle diagnostic query/report helper: active session history gc buffer.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @active_session_history_gc_buffer.sql
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
set lines 900
col event for a30
set pages 100
select sample_time,  sql_id, event, current_obj#,count (*)  from  gv$active_session_history
   where sample_time between  sysdate -1 and
     sysdate
and event like '%gc buffer%'
    group by  sample_time,  sql_id, event, current_obj#
   order by sample_time
/