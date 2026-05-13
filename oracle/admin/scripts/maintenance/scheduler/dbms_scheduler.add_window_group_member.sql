-- ------------------------------------------------------------------------------
-- File       : dbms_scheduler.add_window_group_member.sql
-- Purpose    : Oracle database maintenance helper: dbms scheduler add window group member.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_scheduler.add_window_group_member.sql
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
--dbms_scheduler.add_window_group_member.sql
@dba_scheduler_window_groups.sql
@dba_scheduler_windows.sql

begin
dbms_scheduler.add_window_group_member (
   group_name   =>  '&group_name',
   window_list  =>  '&window_list_sep_coma');
end;
/