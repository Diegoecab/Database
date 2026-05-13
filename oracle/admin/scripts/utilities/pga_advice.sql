-- ------------------------------------------------------------------------------
-- File       : pga_advice.sql
-- Purpose    : Oracle administration helper: pga advice.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @pga_advice.sql
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
SELECT ROUND(pga_target_for_estimate/1024/1024) target_mb,
       PGA_TARGET_FACTOR,
       estd_pga_cache_hit_percentage cache_hit_perc,
       estd_overalloc_count
FROM   v$pga_target_advice;

SELECT *
FROM v$pga_target_advice_histogram
WHERE pga_target_factor = 1
AND estd_total_executions != 0
ORDER BY 1;
