-- ------------------------------------------------------------------------------
-- File       : dba_ts_quotas.sql
-- Purpose    : Oracle administration helper: dba ts quotas.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_ts_quotas.sql
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
--dba_ts_quotas.sql

select * from dba_ts_quotas
where tablespace_name like upper('%&tablespace_name%')
and username like upper('%&username%')
/