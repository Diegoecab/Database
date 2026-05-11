-- ------------------------------------------------------------------------------
-- File       : library_cache_hit_ratio.sql
-- Purpose    : Oracle administration helper: library cache hit ratio.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @library_cache_hit_ratio.sql
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
SELECT SUM(PINHITS)/SUM(PINS) "Hit Ratio"
  FROM V$LIBRARYCACHE
/
