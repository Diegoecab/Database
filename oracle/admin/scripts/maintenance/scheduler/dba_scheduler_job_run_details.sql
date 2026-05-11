-- ------------------------------------------------------------------------------
-- File       : dba_scheduler_job_run_details.sql
-- Purpose    : Oracle database maintenance helper: dba scheduler job run details.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_scheduler_job_run_details.sql
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
col additional_info for a100
col run_duration for a20
col job_name for a40
col day for a6
set lines 400
set verify off

select log_id, job_name, status, 
to_char(log_date, 'dd-mon-yyyy hh24:mi') fecha_log, to_char(log_date, 'dy') day, run_duration, error#, additional_info
from dba_scheduler_job_run_details
where job_name like upper('%&job_name%')
and to_char(log_date, 'dy') like '%&day%'
order by log_date asc;

prompt
prompt *****************************************************
prompt windows:		dba_scheduler_windows_x.sql
prompt jobs:			dba_scheduler_jobs_x.sql
prompt job run details:	dba_scheduler_job_run_details.sql
prompt programs:		dba_scheduler_programs.sql
prompt schedules:		dba_scheduler_schedules.sql 
prompt *****************************************************
prompt