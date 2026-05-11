-- ------------------------------------------------------------------------------
-- File       : vacuum_running_jobs.sql
-- Purpose    : postgres performance/tuning helper: vacuum running jobs.
-- Engine     : postgres
-- Category   : performance/tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: vacuum_running_jobs.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SELECT datname, usename, pid, state, wait_event, current_timestamp - xact_start AS xact_runtime, query
FROM pg_stat_activity 
WHERE upper(query) LIKE '%VACUUM%' 
ORDER BY xact_start;