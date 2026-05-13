-- ------------------------------------------------------------------------------
-- File       : calcula_estadisticas.sql
-- Purpose    : Oracle administration helper: calcula estadisticas.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @calcula_estadisticas.sql
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
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') from dual;
begin
  for r in (select distinct owner
            from dba_tables
            where owner not in ('SYS','SYSTEM','OUTLN','CTXSYS','DBSNMP'))
  loop
     dbms_stats.GATHER_SCHEMA_STATS( r.owner, dbms_stats.AUTO_SAMPLE_SIZE, CASCADE=>true);
  end loop;
end;
/
exit
