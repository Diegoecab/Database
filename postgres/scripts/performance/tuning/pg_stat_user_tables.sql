-- ------------------------------------------------------------------------------
-- File       : pg_stat_user_tables.sql
-- Purpose    : postgres performance/tuning helper: pg stat user tables.
-- Engine     : postgres
-- Category   : performance/tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: pg_stat_user_tables.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SELECT
schemaname,
relname AS TableName
,n_live_tup AS LiveTuples
,n_dead_tup AS DeadTuples
,last_autovacuum AS Autovacuum
,last_autoanalyze AS Autoanalyze
,autovacuum_count
,vacuum_count
FROM pg_stat_user_tables;

