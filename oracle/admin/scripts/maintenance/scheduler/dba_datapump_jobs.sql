-- ------------------------------------------------------------------------------
-- File       : dba_datapump_jobs.sql
-- Purpose    : Oracle database maintenance helper: dba datapump jobs.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_datapump_jobs.sql
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
--dba_datapump_jobs
col job_name for a30 truncate
col owner_name for a20 truncate
col operation for a20 truncate
set lines 300
select * from dba_datapump_jobs;