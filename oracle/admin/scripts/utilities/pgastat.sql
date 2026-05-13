-- ------------------------------------------------------------------------------
-- File       : pgastat.sql
-- Purpose    : Oracle administration helper: pgastat.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @pgastat.sql
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
col name for a50
select inst_id, name, round(value/1024/1024/1024) gb  from gv$pgastat
where
NAME in ( 'aggregate PGA target parameter', 'aggregate PGA auto target', 'total PGA inuse ', 
'total PGA allocated', 'maximum PGA used for auto workareas', 'cache hit percentage', 'over allocation count')
order by inst_id,name;
 