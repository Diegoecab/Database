-- ------------------------------------------------------------------------------
-- File       : locked_object.sql
-- Purpose    : Oracle administration helper: locked object.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @locked_object.sql
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
--v$locked_object
--shows locked objects
col process for a12
set lines 400
col object_name for a30
col ORACLE_USERNAME for a30
col OS_USER_NAME for a20
select session_id,a.object_id,inst_id,oracle_username,os_user_name,DECODE(a.locked_mode,
  1, 'No Lock',
  2, 'Row Share',
  3, 'Row Exclusive',
  4, 'Shared Table',
  5, 'Shared Row Exclusive',
  6, 'Exclusive') locked_mode, b.object_name, 
  process from gv$locked_object a,dba_objects b where a.object_id=b.object_id order by 2;