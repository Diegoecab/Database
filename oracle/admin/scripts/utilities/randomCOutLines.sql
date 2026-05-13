-- ------------------------------------------------------------------------------
-- File       : randomCOutLines.sql
-- Purpose    : Oracle administration helper: randomCOutLines.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @randomCOutLines.sql
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
alter system set use_stored_outlines = TEST_OUTLINES_MIGRACIONES;
alter system flush shared_pool;
set timing on
alter session set events '10046 trace name context forever, level 8';
begin
  for i in 1..2000000 loop
     execute immediate
        'select id1 from migraciones_registros where id1 = :id'
     using ROUND(dbms_random.value(1,2000000));
  end loop;
end;
/