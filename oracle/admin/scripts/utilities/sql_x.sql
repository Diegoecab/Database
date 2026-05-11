-- ------------------------------------------------------------------------------
-- File       : sql_x.sql
-- Purpose    : Oracle administration helper: sql x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sql_x.sql
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
set linesize 180
set verify off
accept SQL_TEXT prompt 'Ingrese %SQL%:  '
select sql_id,sql_text,executions,round(sharable_mem/1024)    "MemKB", elapsed_time,
loads, invalidations from v$sql where UPPER(sql_text) like upper('%&SQL_TEXT%');