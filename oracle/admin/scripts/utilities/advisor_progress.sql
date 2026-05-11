-- ------------------------------------------------------------------------------
-- File       : advisor_progress.sql
-- Purpose    : Oracle administration helper: advisor progress.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @advisor_progress.sql
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
--v$advisor_progress
set verify off
col info1_desc for a20
col info2_desc for a20
col info3_desc for a20
col info4_desc for a20
accept TASKID prompt 'Ingrese Task Id (Para ver un listado ejecutar dba_advisor_tasks): '
SELECT sofar, totalwork, info1_desc, info1, info2_desc, info2, info3_desc,
       info3, info4_desc, info4
  FROM v$advisor_progress
 WHERE task_id = &taskid;
