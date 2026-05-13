-- ------------------------------------------------------------------------------
-- File       : dbms_stats_table.sql
-- Purpose    : Oracle SQL performance and tuning helper: dbms stats table.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_stats_table.sql
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
--dbms_stats_table.sql
REM
set verify off

exec DBMS_STATS.gather_table_stats('&owner', '&table_name', estimate_percent => &estimate_percent, cascade=>&cascade, method_opt=>'FOR ALL COLUMNS SIZE AUTO');
