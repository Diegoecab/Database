-- ------------------------------------------------------------------------------
-- File       : db_object_cache.sql
-- Purpose    : Oracle administration helper: db object cache.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @db_object_cache.sql
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
--v$db_object_cache.sql
col owner for a20 truncate
col name for a20 truncate
col type for a20 truncate
set verify off
set lines 300

SELECT inst_id,owner,name,timestamp,type,kept,sharable_mem/1024/1024 MB--,round((sum(sharable_mem))/1024/1024) MB
  FROM gV$DB_OBJECT_CACHE
  where upper(owner) like upper('%&owner%')
  and upper(name) like upper('%&name%')
-- GROUP BY owner,name,TYPE,KEPT
ORDER BY 3;