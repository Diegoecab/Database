-- ------------------------------------------------------------------------------
-- File       : dbms_scheduler.drop_window.sql
-- Purpose    : Oracle database maintenance helper: dbms scheduler drop window.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_scheduler.drop_window.sql
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
--dbms_scheduler.drop_window.sql

@dba_scheduler_windows.sql

begin
dbms_scheduler.drop_window ('&window_list_sep_coma');
end;
/
