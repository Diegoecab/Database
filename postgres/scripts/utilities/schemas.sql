-- ------------------------------------------------------------------------------
-- File       : schemas.sql
-- Purpose    : postgres utilities helper: schemas.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: schemas.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
 SELECT distinct '-'||nspname||'-'
 FROM pg_catalog.pg_namespace;

SELECT schema_name
FROM information_schema.schemata;

\dn
