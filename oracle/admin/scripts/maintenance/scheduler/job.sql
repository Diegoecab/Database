-- ------------------------------------------------------------------------------
-- File       : job.sql
-- Purpose    : Oracle database maintenance helper: job.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @job.sql
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
select LOG_USER,job,what, last_date, last_sec, next_date, next_sec, failures, broken 
from dba_jobs 
where upper(what) like UPPER('%&1%')
order by log_user, what, job
/
