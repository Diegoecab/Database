-- ------------------------------------------------------------------------------
-- File       : sess_optimizer_env.sql
-- Purpose    : Oracle diagnostic query/report helper: sess optimizer env.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sess_optimizer_env.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SELECT
ID,
NAME,
VALUE
FROM
V$SES_OPTIMIZER_ENV
WHERE sid=&sid
ORDER BY
NAME
/
