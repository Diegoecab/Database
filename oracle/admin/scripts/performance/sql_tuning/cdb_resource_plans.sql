-- ------------------------------------------------------------------------------
-- File       : cdb_resource_plans.sql
-- Purpose    : Oracle SQL performance and tuning helper: cdb resource plans.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @cdb_resource_plans.sql
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
COLUMN plan FORMAT A30
COLUMN comments FORMAT A30
COLUMN status FORMAT A10
SET LINESIZE 100

SELECT plan_id,
       plan,
       comments,
       status,
       mandatory
FROM   dba_cdb_rsrc_plans
ORDER BY plan;