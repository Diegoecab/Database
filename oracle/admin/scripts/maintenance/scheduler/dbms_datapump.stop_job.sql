-- ------------------------------------------------------------------------------
-- File       : dbms_datapump.stop_job.sql
-- Purpose    : Oracle database maintenance helper: dbms datapump stop job.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_datapump.stop_job.sql
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
--dbms_datapump.stop_job.sql
@datapump_status
SET serveroutput on
SET lines 100
DECLARE
   h1 NUMBER;
BEGIN
  -- Format: DBMS_DATAPUMP.ATTACH('[job_name]','[owner_name]');
   h1 := DBMS_DATAPUMP.ATTACH('&JOB_NAME','&OWNER_NAME');
   DBMS_DATAPUMP.STOP_JOB (h1,1,0);
END;
/