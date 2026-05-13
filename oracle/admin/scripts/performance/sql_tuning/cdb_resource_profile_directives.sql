-- ------------------------------------------------------------------------------
-- File       : cdb_resource_profile_directives.sql
-- Purpose    : Oracle SQL performance and tuning helper: cdb resource profile directives.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @cdb_resource_profile_directives.sql
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
COLUMN pluggable_database FORMAT A25
COLUMN profile FORMAT A25
SET LINESIZE 150 VERIFY OFF

SELECT plan,
       pluggable_database,
       profile,
       shares,
       utilization_limit AS util,
       parallel_server_limit AS parallel
FROM   dba_cdb_rsrc_plan_directives
WHERE  plan = DECODE(UPPER('&1'), 'ALL', plan, UPPER('&1'))
ORDER BY plan, pluggable_database, profile;

SET VERIFY ON