-- ------------------------------------------------------------------------------
-- File       : pg_locks_fastpath.sql
-- Purpose    : postgres diagnostics/sessions helper: pg locks fastpath.
-- Engine     : postgres
-- Category   : diagnostics/sessions
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: pg_locks_fastpath.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
select pid,locktype,fastpath,l.relation,t.relname FROM
            pg_locks l
            JOIN pg_class t ON l.relation = t.oid
                AND t.relkind = 'r'
        WHERE
 pid <> pg_backend_pid() and fastpath='f';
