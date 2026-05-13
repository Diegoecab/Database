-- ------------------------------------------------------------------------------
-- File       : alert_log_raise_error_simula.sql
-- Purpose    : Oracle administration helper: alert log raise error simula.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @alert_log_raise_error_simula.sql
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
declare
a exception;
pragma exception_init(a,-600);
begin
raise a;
end;
/



declare
a exception;
pragma exception_init(a,-4031);
begin
raise a;
end;
/



exec sys.dbms_system.ksdwrt(2, 'ORA-4031: testing');
commit;