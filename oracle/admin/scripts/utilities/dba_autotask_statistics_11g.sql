-- ------------------------------------------------------------------------------
-- File       : dba_autotask_statistics_11g.sql
-- Purpose    : Oracle administration helper: dba autotask statistics 11g.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_autotask_statistics_11g.sql
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
--dba_autotask_statistics_11g.sql
col job_Start_time for a60
col job_duration for a60
set lines 400

SELECT client_name, status
FROM DBA_AUTOTASK_TASK
WHERE client_name like 'auto optimizer %';

SELECT window_name,job_name, job_status, job_duration,JOB_START_TIME
FROM DBA_AUTOTASK_JOB_HISTORY
WHERE client_name='auto optimizer stats collection'
AND window_start_time >= SYSDATE -&days
ORDER BY job_start_time DESC
/

