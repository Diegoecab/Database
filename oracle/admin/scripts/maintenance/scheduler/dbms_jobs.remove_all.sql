-- ------------------------------------------------------------------------------
-- File       : dbms_jobs.remove_all.sql
-- Purpose    : Oracle database maintenance helper: dbms jobs remove all.
-- Category   : maintenance/scheduler
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_jobs.remove_all.sql
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
set serveroutput on
begin
for h in (select job from dba_jobs)
loop
dbms_output.put_line ('Eliminando Job '||h.job);
dbms_job.remove(h.job);
commit;
end loop;
end;
/