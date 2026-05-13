-- ------------------------------------------------------------------------------
-- File       : dbms_scheduler.drop_schedule.sql
-- Purpose    : Oracle database maintenance helper: dbms scheduler drop schedule.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_scheduler.drop_schedule.sql
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
--dbms_scheduler.drop_schedule
BEGIN
    dbms_scheduler.drop_schedule( schedule_name => '&owner_schedule_name',
                                  force => &force );
END;
/