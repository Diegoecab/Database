-- ------------------------------------------------------------------------------
-- File       : dba_scheduler_job_log.sql
-- Purpose    : Oracle database maintenance helper: dba scheduler job log.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_scheduler_job_log.sql
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
--dba_scheduler_job_log
set lines 500
col client_id for a40
col additional_info for a70
col job_name for a30
col job_subname for a10
col log_date for a35

select * from dba_scheduler_job_log
where job_name like upper('%&job_name%')
order by log_id
/