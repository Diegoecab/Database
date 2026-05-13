-- ------------------------------------------------------------------------------
-- File       : character_set.sql
-- Purpose    : postgres utilities helper: character set.
-- Engine     : postgres
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: character_set.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SHOW SERVER_ENCODING;
SELECT datname ,pg_encoding_to_char(encoding) FROM pg_database;
