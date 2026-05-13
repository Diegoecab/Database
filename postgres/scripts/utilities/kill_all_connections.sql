-- ------------------------------------------------------------------------------
-- File       : kill_all_connections.sql
-- Purpose    : postgres utilities helper: kill all connections.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: kill_all_connections.sql
-- Parameters : Review script body before running.
-- Risk       : DESTRUCTIVE
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
Select pid, usename, application_name, datname 
FROM
    pg_stat_activity;

SELECT
    pg_terminate_backend(pid)
FROM
    pg_stat_activity
WHERE
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'database_name'
;
