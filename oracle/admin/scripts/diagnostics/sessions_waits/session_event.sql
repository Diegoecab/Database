-- ------------------------------------------------------------------------------
-- File       : session_event.sql
-- Purpose    : Oracle diagnostic query/report helper: session event.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @session_event.sql
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
col rownum for 99
col event for a40
set linesize 180
 select
*
from
  (select
    event,
   total_waits,
     time_waited
from
       v$session_event
  where
     sid='&SID'--SYS_CONTEXT('USERENV','SID')
  order by
       time_waited desc)
where
 rownum <= 5;