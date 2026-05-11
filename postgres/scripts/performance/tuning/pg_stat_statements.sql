-- ------------------------------------------------------------------------------
-- File       : pg_stat_statements.sql
-- Purpose    : postgres performance/tuning helper: pg stat statements.
-- Engine     : postgres
-- Category   : performance/tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: pg_stat_statements.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
\d pg_stat_statements
SELECT
  (total_exec_time / 1000 / 60) as total_min,
  mean_exec_time as avg_ms,
  calls,
  rows,
  substr(query,1,50) query
FROM pg_stat_statements
ORDER BY 1 DESC
LIMIT 500;

