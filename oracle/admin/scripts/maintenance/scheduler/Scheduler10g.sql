-- ------------------------------------------------------------------------------
-- File       : Scheduler10g.sql
-- Purpose    : Oracle database maintenance helper: Scheduler10g.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @Scheduler10g.sql
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
--scheduler10g
/* nueva funcionalidad en 10g. Ver que otros datos son necesarios */

col additional_info for a100
set lines 400
col job_name for a50
select log_id, job_name, status, 
to_char(log_date, 'DD-MON-YYYY HH24:MI') log_date ,status, error#, run_duration, additional_info
from dba_scheduler_job_run_details
order by log_date desc
/

PROMPT Jobs details : dba_scheduler_jobs_x