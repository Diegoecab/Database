-- ------------------------------------------------------------------------------
-- File       : dbms_stats.report_col_usage.sql
-- Purpose    : Oracle SQL performance and tuning helper: dbms stats report col usage.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_stats.report_col_usage.sql
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
SET LONG 100000
SET LINES 120
SET PAGES 5000

SELECT DBMS_STATS.report_col_usage('&OWNER', '&TABLE')
FROM   dual;