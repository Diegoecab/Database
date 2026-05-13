-- ------------------------------------------------------------------------------
-- File       : recreate_redo_logfiles.sql
-- Purpose    : Oracle administration helper: recreate redo logfiles.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @recreate_redo_logfiles.sql
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
set lines 600
set pages 100
set serveroutput on

begin
for r in (select * from  v$log) loop
dbms_output.put_line ('ALTER DATABASE DROP LOGFILE GROUP '||r.group#||';');
dbms_output.put_line ('ALTER DATABASE ADD LOGFILE GROUP '||r.group#||' size '||ROUND (r.BYTES / 1024 / 1024)||'M ;');
end loop;
end;
/