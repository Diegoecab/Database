-- ------------------------------------------------------------------------------
-- File       : db_object_cache_sharedpool.sql
-- Purpose    : Oracle administration helper: db object cache sharedpool.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @db_object_cache_sharedpool.sql
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
--v$db_object_cache_sharedpool.sql
col object for a50
col name for a50
col type for a50
col owner for a15
col db_link for a20
set lines 220
select     OWNER,
   NAME,
   TYPE,
   loads,
   executions,
   locks,
   kept,
        pins,
		db_link,
   round(SHARABLE_MEM/1024) KB
from       v$db_object_cache
where      SHARABLE_MEM > 10000
and        type in ('PACKAGE','PACKAGE BODY','FUNCTION','PROCEDURE')
--and owner='BFI'
order      by SHARABLE_MEM desc
/