-- ------------------------------------------------------------------------------
-- File       : flashback_database_logfile.sql
-- Purpose    : Oracle administration helper: flashback database logfile.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @flashback_database_logfile.sql
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
----- 
-- Listing 2.7: Flashback Log Query
-----

-- What Flashback Logs are available?
TTITLE 'Current Flashback Logs Available'
COL log#                FORMAT 9999     HEADING 'FLB|Log#'
COL bytes               FORMAT 99999999 HEADING 'Flshbck|Log Size'
COL first_change#       FORMAT 9999999999 HEADING 'Flshbck|SCN #'
COL first_time          FORMAT A24      HEADING 'Flashback Start Time'

SELECT 
    LOG#
    ,bytes
    ,first_change#
    ,first_time
  FROM v$flashback_database_logfile;
