-- ------------------------------------------------------------------------------
-- File       : dba_autotask_job_history.sql
-- Purpose    : Oracle database maintenance helper: dba autotask job history.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_autotask_job_history.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
--@dba_autotask_job_history
col job_Start_time for a60
col job_duration for a60
set lines 400
SELECT window_name,job_name, job_status, job_duration,JOB_START_TIME
FROM DBA_AUTOTASK_JOB_HISTORY
WHERE client_name='auto optimizer stats collection'
AND window_start_time >= SYSDATE -&days
ORDER BY job_start_time DESC
/