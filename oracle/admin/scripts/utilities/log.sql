-- ------------------------------------------------------------------------------
-- File       : log.sql
-- Purpose    : Oracle administration helper: log.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @log.sql
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
--v$log.sql

col status for a10

SELECT group#, thread#, sequence#, ROUND (BYTES / 1024 / 1024) mb, members,
       archived, status, first_change#, first_time
  FROM v$log;
