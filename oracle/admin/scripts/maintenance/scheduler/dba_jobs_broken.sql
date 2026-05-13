-- ------------------------------------------------------------------------------
-- File       : dba_jobs_broken.sql
-- Purpose    : Oracle database maintenance helper: dba jobs broken.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_jobs_broken.sql
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
col what for a40
col nls_env for a20
col interval for a10
col misc_env for a30
col job for 999
col schema_user for a10
col priv_user for a10
col misc_env for a5
col log_user for a10
col failures for 9
set linesize 200
set pagesize 100
select job,what,last_date,last_sec,next_date,total_time,log_user,priv_user,schema_user,broken,interval,failures from dba_jobs
where broken='Y';