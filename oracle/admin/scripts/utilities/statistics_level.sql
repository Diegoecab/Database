-- ------------------------------------------------------------------------------
-- File       : statistics_level.sql
-- Purpose    : Oracle administration helper: statistics level.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @statistics_level.sql
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
--v$statistics_level.sql
SELECT statistics_name,
           session_status,
           system_status,
           activation_level,
           session_settable
    FROM   v$statistics_level
    ORDER BY statistics_name;