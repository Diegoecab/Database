-- ------------------------------------------------------------------------------
-- File       : monitoreo_uso_temporal.sql
-- Purpose    : Oracle SQL performance and tuning helper: monitoreo uso temporal.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @monitoreo_uso_temporal.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SELECT tablespace_name, current_users "Usuarios", 
max_sort_blocks  "Mayor_consumo_bloques"
FROM v$sort_segment;

SELECT user, tablespace, blocks
FROM v$sort_usage
ORDER BY blocks;