-- ------------------------------------------------------------------------------
-- File       : pg_tablespace.sql
-- Purpose    : postgres storage helper: pg tablespace.
-- Engine     : postgres
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: pg_tablespace.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
show temp_tablespaces;

SELECT spcname,pg_tablespace_location(oid) FROM pg_tablespace;
