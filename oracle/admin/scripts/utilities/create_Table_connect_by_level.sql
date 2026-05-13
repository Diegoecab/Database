-- ------------------------------------------------------------------------------
-- File       : create_Table_connect_by_level.sql
-- Purpose    : Oracle administration helper: create Table connect by level.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @create_Table_connect_by_level.sql
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
create tablespace dbas_marron datafile size 1000m autoextend on next 100M maxsize 10000M;
alter user dba_dc22057	 quota unlimited on dbas_marron;
CREATE TABLE test (id number, name varchar2(1000))  tablespace users;

set timing on
insert into test select level id, 'nom_'||level nombre
FROM dual
CONNECT BY level <= 300000;

begin
for r in 1..2000 loop
insert into test select level id, 'nom_'||level nombre
FROM dual
CONNECT BY level <= 500000;
end loop;
end;
/


select level id,
STDDEV(level) OVER (ORDER BY level) "idStdDev"
FROM dual
CONNECT BY level <= 2000;