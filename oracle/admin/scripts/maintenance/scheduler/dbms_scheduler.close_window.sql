-- ------------------------------------------------------------------------------
-- File       : dbms_scheduler.close_window.sql
-- Purpose    : Oracle database maintenance helper: dbms scheduler close window.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_scheduler.close_window.sql
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
--dbms_scheduler.open_window
SELECT window_name, resource_plan, enabled, active 
FROM   dba_scheduler_windows;
accept WIN_NAME prompt 'Ingrese Nombre de ventana: '
BEGIN
  DBMS_SCHEDULER.close_window (
   window_name => '&WIN_NAME');
END;
/
commit;