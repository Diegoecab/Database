-- ------------------------------------------------------------------------------
-- File       : a_sql.sql
-- Purpose    : Oracle administration helper: a sql.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @a_sql.sql
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
--a_sql
--

define sql_id=&1
@sql_sqltext &sql_id
@sql.sql &sql_id
@dba_hist_snapshot_sqlid.sql &sql_id % % 30
@ash/ashtop username,sql_id sql_id='&sql_id' "sysdate-interval '600' minute" sysdate