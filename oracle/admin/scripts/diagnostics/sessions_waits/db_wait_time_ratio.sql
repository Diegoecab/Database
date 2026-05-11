-- ------------------------------------------------------------------------------
-- File       : db_wait_time_ratio.sql
-- Purpose    : Oracle diagnostic query/report helper: db wait time ratio.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @db_wait_time_ratio.sql
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
--db_wait_time_ratio.sql minute
set pages 100
set lines 120
set verify off

SELECT
  to_char(begin_time,'DD-MM-YY HH24:MI:SS') begin_time ,metric_name,
value "Average Wait time %"
FROM
   gv$sysmetric_history
WHERE metric_name = 'Database Wait Time Ratio'
and (begin_time > SYSDATE - INTERVAL '&1' MINUTE)
order by 1
/


SELECT
  metric_name,
  ROUND(AVG(value),1) "Average Wait time %"
FROM
   v$sysmetric_history
WHERE metric_name = 'Database Wait Time Ratio'
and (begin_time > SYSDATE - INTERVAL '&1' MINUTE)
GROUP BY metric_name;
