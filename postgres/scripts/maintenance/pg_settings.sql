-- ------------------------------------------------------------------------------
-- File       : pg_settings.sql
-- Purpose    : postgres maintenance helper: pg settings.
-- Engine     : postgres
-- Category   : maintenance
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : Run with the target database client: pg_settings.sql
-- Parameters : Review script body before running.
-- Risk       : READ_ONLY
-- Output     : Client, shell or script-defined output.
-- Notes      : Validate in a non-production environment before operational use.
-- Source     : internal
-- Change Log :
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
\d pg_settings;
select name, setting, unit from pg_settings where name like '%plan%';