-- ------------------------------------------------------------------------------
-- File       : add_sql_stability_baseline.sql
-- Purpose    : Oracle administration helper: add sql stability baseline.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @add_sql_stability_baseline.sql
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
declare
     l_plans_loaded pls_integer;
begin
     l_plans_loaded := dbms_spm.load_plans_from_sqlset(sqlset_name => 'CRCO_DW_3107_DC'); 
end;
/



declare
     l_plans_loaded pls_integer;
begin
     l_plans_loaded := dbms_spm.load_plans_from_cursor_cache(
         sql_id => '52q1ac00nfksc'); 
end;