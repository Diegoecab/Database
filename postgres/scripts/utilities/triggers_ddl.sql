-- ------------------------------------------------------------------------------
-- File       : triggers_ddl.sql
-- Purpose    : postgres utilities helper: triggers ddl.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: triggers_ddl.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SELECT oid FROM pg_trigger WHERE tgname = 'my_t';
SELECT pg_get_triggerdef(16429);
