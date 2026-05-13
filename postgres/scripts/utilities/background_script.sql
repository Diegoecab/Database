-- ------------------------------------------------------------------------------
-- File       : background_script.sql
-- Purpose    : postgres utilities helper: background script.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: background_script.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SET lock_timeout=7200000;
--Find lock on a specific table.
SELECT
    pid,
    state,
    usename,
    query,
    usename,
    query,
    query_start,
    age(now(), query_start) AS "age"
FROM
    pg_stat_activity
WHERE
    pid IN (
        SELECT
            pid
        FROM
            pg_locks l
            JOIN pg_class t ON l.relation = t.oid
                AND t.relkind = 'r'
        WHERE
            t.relname = 'entitlement_modification'
            AND pid <> pg_backend_pid());
