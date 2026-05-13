-- ------------------------------------------------------------------------------
-- File       : rsrc_plan.sql
-- Purpose    : Oracle SQL performance and tuning helper: rsrc plan.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rsrc_plan.sql
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
prompt
prompt ****************************
prompt Resouce Plans. Viewing the Currently Active Plans
prompt ****************************
prompt
select * from v$rsrc_plan
/
prompt