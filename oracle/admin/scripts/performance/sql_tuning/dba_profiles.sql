-- ------------------------------------------------------------------------------
-- File       : dba_profiles.sql
-- Purpose    : Oracle SQL performance and tuning helper: dba profiles.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_profiles.sql
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
ttitle 'Perfiles'
undefine all
set lines 400
col profile for a100
select * from dba_profiles 
where profile like upper('%&profile%')
order by 1,2;

ttitle off