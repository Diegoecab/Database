-- ------------------------------------------------------------------------------
-- File       : ashrelated.sql
-- Purpose    : Oracle diagnostic query/report helper: ashrelated.
-- Category   : diagnostics/ash
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @ashrelated.sql
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
SELECT 
        COUNT(*)                                                     totalseconds
      , ROUND(COUNT(*) / ((CAST(&4 AS DATE) - CAST(&3 AS DATE)) * 86400), 1) AAS
      , LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',5,' ')||' |' "%This"
      , &1
      , TO_CHAR(MIN(sample_time), 'YYYY-MM-DD HH24:MI:SS') first_seen
      , TO_CHAR(MAX(sample_time), 'YYYY-MM-DD HH24:MI:SS') last_seen
--    , MAX(sql_exec_id) - MIN(sql_exec_id) 
      , COUNT(DISTINCT sql_exec_start||':'||sql_exec_id) dist_sqlexec_seen
FROM v$active_session_history a
WHERE (session_id, session_serial#) IN (SELECT session_id, session_serial# FROM v$active_session_history 
                                       WHERE sample_time BETWEEN &3 AND &4
                                       AND &2
                                       )
AND sample_time BETWEEN &3 AND &4
GROUP BY
    &1
/

