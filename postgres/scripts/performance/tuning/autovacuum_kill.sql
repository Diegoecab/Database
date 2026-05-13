-- ------------------------------------------------------------------------------
-- File       : autovacuum_kill.sql
-- Purpose    : postgres performance/tuning helper: autovacuum kill.
-- Engine     : postgres
-- Category   : performance/tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: autovacuum_kill.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
select pg_terminate_backend(pid) from pg_stat_activity where query = 'autovacuum: VACUUM rkms.transaction (to prevent wraparound)' and pid <> pg_backend_pid();
\watch 1
