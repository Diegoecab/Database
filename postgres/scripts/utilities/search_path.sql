-- ------------------------------------------------------------------------------
-- File       : search_path.sql
-- Purpose    : postgres utilities helper: search path.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: search_path.sql
-- Parameters : Review script body before running.
-- Risk       : CHANGES
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SHOW search_path;
SET search_path TO myschema,public;
ALTER DATABASE db_name SET search_path = database,public;
