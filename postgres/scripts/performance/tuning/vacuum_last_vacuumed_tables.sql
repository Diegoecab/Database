-- ------------------------------------------------------------------------------
-- File       : vacuum_last_vacuumed_tables.sql
-- Purpose    : postgres performance/tuning helper: vacuum last vacuumed tables.
-- Engine     : postgres
-- Category   : performance/tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: vacuum_last_vacuumed_tables.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--Tables Last Vacuumed
SELECT
schemaname, relname,last_vacuum, cast(last_autovacuum as date), cast(last_analyze as date), cast(last_autoanalyze as date),
pg_size_pretty(pg_total_relation_size(table_name)) as table_total_size
from pg_stat_user_tables a, information_schema.tables b where a.relname=b.table_name ORDER BY pg_total_relation_size(table_name) DESC limit 10;