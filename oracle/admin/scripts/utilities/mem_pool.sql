-- ------------------------------------------------------------------------------
-- File       : mem_pool.sql
-- Purpose    : Oracle administration helper: mem pool.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @mem_pool.sql
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
col value format 99999999999

select * from v$sga
/

select decode(pool,null,'buffer',pool), trunc(sum(bytes/1024/1024/1024)) "Used G bytes" from v$sgastat 
group by decode(pool,null,'buffer',pool)
/

select pool, trunc(bytes/1024/1024/1024) "Free G bytes" from v$sgastat where name = 'free memory'
/