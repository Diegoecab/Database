-- ------------------------------------------------------------------------------
-- File       : drop_user_cascade.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: drop user cascade.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @drop_user_cascade.sql
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
--drop_user_cascade.sql

undefine all

accept OWNER prompt 'OWNER: '

set serveroutput on
begin
for r in (
select object_type,object_name from dba_objects where owner='&OWNER' order by 1)
loop
begin
IF r.object_type='TABLE' then
execute immediate ('DROP TABLE &OWNER'||'.'||r.object_name||' purge');
elsif r.object_type='VIEW' then
execute immediate ('DROP VIEW &OWNER'||'.'||r.object_name);
elsif r.object_type='SYNONYM' then
execute immediate ('DROP SYNONYM &OWNER'||'.'||r.object_name);
elsif r.object_type='SEQUENCE' then
execute immediate ('DROP SEQUENCE &OWNER'||'.'||r.object_name);
elsif r.object_type='PACKAGE' then
execute immediate ('DROP PACKAGE &OWNER'||'.'||r.object_name);
elsif r.object_type='FUNCTION' then
execute immediate ('DROP FUNCTION &OWNER'||'.'||r.object_name);
elsif r.object_type='TYPE' then
execute immediate ('DROP TYPE &OWNER'||'.'||r.object_name);
elsif r.object_type='PROCEDURE' then
execute immediate ('DROP PROCEDURE &OWNER'||'.'||r.object_name);
elsif r.object_type='TRIGGER' then
execute immediate ('DROP TRIGGER &OWNER'||'.'||r.object_name);
end if;
exception when others then
dbms_output.put_line ('Error al querer borrar '||r.object_type||'.'||r.object_name);
dbms_output.put_line (SQLERRM);
end;
end loop;
end;
/