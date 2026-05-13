-- ------------------------------------------------------------------------------
-- File       : stress_test.sql
-- Purpose    : Oracle administration helper: stress test.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @stress_test.sql
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
nval number;
nval2 number:=1;

begin

for r in 1..50000000 loop
select power(
	(mod( (DBMS_RANDOM.VALUE(0,100000000000)/(DBMS_RANDOM.VALUE(1,100000000000))), DBMS_RANDOM.VALUE(0,100000000000)/(DBMS_RANDOM.VALUE(1,100000000000)) ))
,-1
 )+nval2 into nval from dual;

select ((nval-nval2)) into nval2 from dual;

end loop;
end;
/
