-- ------------------------------------------------------------------------------
-- File       : exp_env.sql
-- Purpose    : Oracle administration helper: exp env.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exp_env.sql
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
alter session set nls_date_format='DD-MM-YY HH24:MI';
alter session set current_schema=dbadmin;
col other noprint
col jobsize for 99999999999999
col filesize for 999999999999
col detail for a10
col schema_name for a20
col status for a10 trunc
col step for 999
col value for a15
col p1 for a5
col p2 for a27
col INTERVAL FOR 9999
col REPEAT for 99
col name for a45
COL RULE_ID FOR 99
COL TYPE FOR A4
COL PROC FOR A33
COL RULE_ID FOR 99
COL DETAIL FOR A35 TRUNC
COL STATUS FOR A8
COL JOB_ID FOR 99999