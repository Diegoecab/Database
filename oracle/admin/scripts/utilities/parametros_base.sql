-- ------------------------------------------------------------------------------
-- File       : parametros_base.sql
-- Purpose    : Oracle administration helper: parametros base.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @parametros_base.sql
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
SELECT   a.NAME, a.VALUE, upper(i.instance_name) instance_name
FROM     v$parameter a, v$instance i
ORDER BY UPPER(NAME);