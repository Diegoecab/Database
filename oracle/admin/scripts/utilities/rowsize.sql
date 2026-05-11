-- ------------------------------------------------------------------------------
-- File       : rowsize.sql
-- Purpose    : Oracle administration helper: rowsize.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rowsize.sql
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
set linesize 180
select owner, table_name, last_analyzed, avg_row_len, num_rows, round(avg_row_len * &1 /1024/1024,2) avgsize
from dba_tables 
where table_name = upper('&2')
/
