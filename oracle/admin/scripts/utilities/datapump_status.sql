-- ------------------------------------------------------------------------------
-- File       : datapump_status.sql
-- Purpose    : Oracle administration helper: datapump status.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @datapump_status.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
set pages 1000
set lines 132
set trims on
col owner_name 		format a10          heading "Owner"
col job_name       	format a20          heading "Job Name"
col operation      	format a10     		heading "Operation"
col job_mode      	format a10     		heading "Job Mode"
col state      		format a12     		heading "State"
col OPNAME			format a31			
col MESSAGE			format a40
col TARGET_DESC		format a20

select * from dba_datapump_jobs
/

select * from dba_datapump_sessions
/

--select username,opname,target_desc,sofar,totalwork,message from V$SESSION_LONGOPS
--/