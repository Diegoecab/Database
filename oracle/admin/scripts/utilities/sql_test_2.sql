-- ------------------------------------------------------------------------------
-- File       : sql_test_2.sql
-- Purpose    : Oracle administration helper: sql test 2.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sql_test_2.sql
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
set feedback off
begin
  for i in 1..100000 loop
execute immediate
        'insert into prueba_stb3 (numero) values (:id)'
     using ROUND(dbms_random.value(1,100000));
commit;
  end loop;
for i in 1..100000 loop
execute immediate
        'delete from prueba_stb3 where numero= :id'
     using ROUND(dbms_random.value(1,100000));
commit;
  end loop;
end;
/
