-- ------------------------------------------------------------------------------
-- File       : dba_objects_invalid_gowner.sql
-- Purpose    : Oracle administration helper: dba objects invalid gowner.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_objects_invalid_gowner.sql
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
--dba_objects_invalid_gowner
set pages 1000
set lines 200
set trims on
set verify off
col owner for a20
col object_name for a40
col sql for a80
break on owner on report
compute sum of tot on report

SELECT   owner, count(*) tot
   FROM   dba_objects
   WHERE   status <> 'VALID' and owner like upper('%&owner%')
   group by owner
ORDER BY   1
/