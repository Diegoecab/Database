-- ------------------------------------------------------------------------------
-- File       : dba_rsrc_plans.sql
-- Purpose    : Oracle SQL performance and tuning helper: dba rsrc plans.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_rsrc_plans.sql
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
prompt Resouce Plans
prompt ****************************
prompt

select plan, status from dba_rsrc_plans
/