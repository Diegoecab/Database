-- ------------------------------------------------------------------------------
-- File       : exadata_system_stats_gather.sql
-- Purpose    : Oracle SQL performance and tuning helper: exadata system stats gather.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exadata_system_stats_gather.sql
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
exec dbms_stats.gather_system_stats(‘exadata’);
col sname format a15
col pname format a15
col pval2 format a20
set pagesize 25
set echo on
select * from aux_stats$;
