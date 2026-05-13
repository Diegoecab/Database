-- ------------------------------------------------------------------------------
-- File       : last_modified_date_table.sql
-- Purpose    : postgres storage helper: last modified date table.
-- Engine     : postgres
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: last_modified_date_table.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--https://michaelellerbeck.com/2022/09/16/get-last-modified-date-of-table-in-postgresql/
--Turn on track_commit_timestamp in postgresql.conf and restart the DB cluster.
SELECT pg_xact_commit_timestamp(t.xmin) AS modified_ts
FROM   my_table t
ORDER  BY modified_ts DESC NULLS LAST
LIMIT  1;
