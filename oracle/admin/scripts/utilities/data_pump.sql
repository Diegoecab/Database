-- ------------------------------------------------------------------------------
-- File       : data_pump.sql
-- Purpose    : Oracle administration helper: data pump.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @data_pump.sql
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
rem data_pump.sql
set pagesize 100
col owner_name for a10
col job_name for a22
col operation for a11
col job_mode for a11
col state for a12
col degree for 9
col attached_sessions for 99
col datapump_sessions for 99

col opname for a20
col message for a80
col username for a20
col target_desc for a5
select * from dba_datapump_jobs
/

SELECT * FROM DBA_DATAPUMP_SESSIONS
/

select username,opname,target_desc,sofar,totalwork,message from V$SESSION_LONGOPS
/