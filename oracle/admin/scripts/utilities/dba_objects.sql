-- ------------------------------------------------------------------------------
-- File       : dba_objects.sql
-- Purpose    : Oracle administration helper: dba objects.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_objects.sql
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
--dba_objects

set pages 1000
set lines 400
set trims on
set verify off
col owner for a20
col object_name for a40


select owner,object_type,object_name,created,status,last_ddl_time, timestamp from 
dba_objects where 
owner like upper('%&owner%') 
and object_type like upper('%&object_type%') 
and object_name like upper('%&obj_name%')
order by 1,2,3

/