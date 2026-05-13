-- ------------------------------------------------------------------------------
-- File       : scheduler_stats.sql
-- Purpose    : Oracle SQL performance and tuning helper: scheduler stats.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @scheduler_stats.sql
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
--scheduler_stats
col job_name for a18
col status for a10
col fecha_log for a17
col run_duration for a15
select log_id, job_name, status, 
to_char(log_date, 'DD-MON-YYYY HH24:MI') fecha_log, run_duration
from dba_scheduler_job_run_details
where job_name='GATHER_STATS_JOB'
order by log_date asc;