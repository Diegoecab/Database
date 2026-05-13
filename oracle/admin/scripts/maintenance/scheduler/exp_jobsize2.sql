-- ------------------------------------------------------------------------------
-- File       : exp_jobsize2.sql
-- Purpose    : Oracle database maintenance helper: exp jobsize2.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exp_jobsize2.sql
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
set echo off
SELECT book_date, run, servername, 
      db_sid, schema_name, 
      Round(Max(jobsize)/1024/1024/1024) max_size, 
      Round(Avg(jobsize)/1024/1024/1024) avg_size,
      Count(1) snaps
FROM exp_job_size
GROUP BY book_date, run, servername, db_sid, schema_name
ORDER BY 6 desc
/