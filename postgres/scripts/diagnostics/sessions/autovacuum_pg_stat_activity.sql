-- ------------------------------------------------------------------------------
-- File       : autovacuum_pg_stat_activity.sql
-- Purpose    : postgres diagnostics/sessions helper: autovacuum pg stat activity.
-- Engine     : postgres
-- Category   : diagnostics/sessions
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: autovacuum_pg_stat_activity.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
select count(*) from pg_stat_activity where query like 'autovacuum:%';

SELECT datname, usename, pid, -- waiting, 
current_timestamp - xact_start
AS xact_runtime, query
FROM pg_stat_activity WHERE upper(query) like '%VACUUM%' ORDER BY xact_start;
