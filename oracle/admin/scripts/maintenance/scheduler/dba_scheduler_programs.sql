-- ------------------------------------------------------------------------------
-- File       : dba_scheduler_programs.sql
-- Purpose    : Oracle database maintenance helper: dba scheduler programs.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_scheduler_programs.sql
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
--dba_scheduler_programs
col program_action for a45
col owner for a10
col number_of_arguments for 9
col program_name for a25
col comments for a80
set lines 400

select * from dba_scheduler_programs
/

PROMPT
PROMPT *****************************************************
PROMPT Windows:		dba_scheduler_windows_x.sql
PROMPT Jobs:			dba_scheduler_jobs_x.sql
PROMPT Job Run Details:	dba_scheduler_job_run_details.sql
PROMPT Programs:		dba_scheduler_programs.sql
prompt schedules:		dba_scheduler_schedules.sql
Prompt  select client_name, status from dba_autotask_client;
PROMPT *****************************************************
PROMPT