-- ------------------------------------------------------------------------------
-- File       : sqlstats_unshared.sql
-- Purpose    : Oracle SQL performance and tuning helper: sqlstats unshared.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sqlstats_unshared.sql
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
select substr(sql_text,1,60), count(*) from v$sqlstats where executions < 4 group by substr(sql_text,1,60) having count(*) >1;

select sql_text,parse_calls, executions  from v$sqlstats order by parse_calls;
