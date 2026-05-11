-- ------------------------------------------------------------------------------
-- File       : obj3.sql
-- Purpose    : Oracle administration helper: obj3.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @obj3.sql
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
select object_type, status, count(*) 
from dba_objects where owner not in ('SYS','SYSTEM')
AND OBJECT_NAME NOT LIKE 'Z99_00%'
group by object_type, status
/
