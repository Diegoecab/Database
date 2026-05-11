-- ------------------------------------------------------------------------------
-- File       : sqlarea_x.sql
-- Purpose    : Oracle administration helper: sqlarea x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sqlarea_x.sql
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
COL sql_text for a60
COL module for a20
SET pagesize 10000
accept SQL_ID prompt 'Ingrese SQL_ID:  '
SELECT   module, executions, rows_processed, round(elapsed_time/1000000,2) elapsed_time_segundos, sql_text
    FROM v$sqlarea
	where sql_id = '&SQL_ID'
ORDER BY module;