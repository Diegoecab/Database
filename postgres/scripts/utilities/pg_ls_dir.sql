-- ------------------------------------------------------------------------------
-- File       : pg_ls_dir.sql
-- Purpose    : postgres utilities helper: pg ls dir.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: pg_ls_dir.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
select * from pg_ls_dir('pg_xlog');

select * 
from pg_ls_dir('pg_wal');
--(vERSION 10):

