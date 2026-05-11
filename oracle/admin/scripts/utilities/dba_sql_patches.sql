-- ------------------------------------------------------------------------------
-- File       : dba_sql_patches.sql
-- Purpose    : oracle/admin utilities helper: dba sql patches.
-- Engine     : oracle/admin
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: dba_sql_patches.sql
-- Parameters : Review script body before running.
-- Risk       : DESTRUCTIVE
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--@dba_sql_patches
col name for a40 truncate
set lines 300
col description for a40 truncate
select name, created, description, status, SIGNATURE from dba_sql_patches;