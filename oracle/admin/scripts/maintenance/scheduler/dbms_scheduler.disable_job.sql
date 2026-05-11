-- ------------------------------------------------------------------------------
-- File       : dbms_scheduler.disable_job.sql
-- Purpose    : Oracle database maintenance helper: dbms scheduler disable job.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_scheduler.disable_job.sql
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
--dbms_scheduler.disable
BEGIN
      sys.dbms_scheduler.disable(name=>'"SYS"."FULL_BACKUP"');
END;
/Bostero