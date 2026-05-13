-- ------------------------------------------------------------------------------
-- File       : dba_tab_histograms.sql
-- Purpose    : Oracle administration helper: dba tab histograms.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tab_histograms.sql
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
--dba_tab_histograms
col column_name for a30
col endpoint_actual_value for a50
set feed off
set head on

select * from dba_tab_histograms
where owner like upper ('%&owner%')
and table_name like upper ('%&table_name%')
and column_name like upper ('%&column_name%')
order by 1,2,3,5
/