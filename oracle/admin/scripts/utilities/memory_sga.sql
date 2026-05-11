-- ------------------------------------------------------------------------------
-- File       : memory_sga.sql
-- Purpose    : Oracle administration helper: memory sga.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @memory_sga.sql
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
select * from v$sga order by 1;
select * from v$sgainfo order by 1;
select nvl(pool,name) pool, sum(bytes)/1024/1024/1024 Gb from v$sgastat group by nvl(pool,name) order by 1;
select component, current_size, user_specified_size from v$memory_dynamic_components order by 1;