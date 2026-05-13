-- ------------------------------------------------------------------------------
-- File       : scheduler.sql
-- Purpose    : Oracle database maintenance helper: scheduler.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @scheduler.sql
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
--dba_scheduler_job_run_details.sql

col job_name for a40
col status for a20

select log_id, job_name, status, 
to_char(log_date, 'DD-MON-YYYY HH24:MI') fecha_log
from dba_scheduler_job_run_details
order by log_date asc;
