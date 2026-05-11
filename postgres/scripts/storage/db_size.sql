-- ------------------------------------------------------------------------------
-- File       : db_size.sql
-- Purpose    : postgres storage helper: db size.
-- Engine     : postgres
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: db_size.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SELECT pg_size_pretty( pg_database_size('testdb2'));
SELECT pg_size_pretty(pg_database_size(pg_database.datname)) AS size_in_mb,
pg_database.datname as database_name
FROM pg_database ORDER BY pg_database_size(pg_database.datname) DESC;
