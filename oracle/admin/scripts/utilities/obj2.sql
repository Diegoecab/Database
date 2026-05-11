-- ------------------------------------------------------------------------------
-- File       : obj2.sql
-- Purpose    : Oracle administration helper: obj2.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @obj2.sql
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
col owner format a10
col object_type format a20
col object_name format a30
col last_ddl_time format a20
select owner, object_type, object_name, CREATED, last_ddl_time,status 
from dba_objects where object_name like '%'||upper('&1')||'%'
order by owner, object_name,object_type
/
