-- ------------------------------------------------------------------------------
-- File       : shared_pool_free_mem.sql
-- Purpose    : Oracle administration helper: shared pool free mem.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @shared_pool_free_mem.sql
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
REM shared_pool_free_mem.sql
SELECT pool, name,round(bytes/1024/1024,2) MB FROM V$SGASTAT 
 WHERE NAME = 'free memory'
AND POOL = 'shared pool';

PROMPT Para ver memoria libre en shared_pool_reserved, script v$shared_pool_reserved.sql