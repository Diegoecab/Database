-- ------------------------------------------------------------------------------
-- File       : create_big_table.sql
-- Purpose    : Oracle administration helper: create big table.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @create_big_table.sql
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
 CREATE TABLE &tablename NOLOGGING PARALLEL 4 AS
 SELECT level id, 'nom_'||level nom
 FROM dual
 CONNECT BY level <= 2000000;

ALTER TABLE &tablename add constraint &tablename_pk PRIMARY KEY (ID);

begin
for r in 2000001..5000000 loop
insert into BIGTABLE values (r,'TEST');
end loop;
commit;
end;
/

begin
for r in 2000001..3000001 loop
update BIGTABLE set nom='TEST2' where id=r;
end loop;
commit;
end;
/
