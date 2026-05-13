-- ------------------------------------------------------------------------------
-- File       : grants_all.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: grants all.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @grants_all.sql
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
--grants_all.sql
--Usage. @grants_all <owner> <grantee>
--
whenever sqlerror exit sql.sqlcode

define owner='&1';
define grantee='&2';

prompt Working with owner &owner and grantee &grantee

set serveroutput on
begin
for r in 
(
select owner,object_name from dba_objects where owner = upper('&owner') and object_type in ('TABLE')
)
loop
begin
	dbms_output.put_line ('grant delete, insert, select, update on  '||r.owner||'.'||r.object_name||' to &grantee');
	execute immediate ('grant delete, insert, select, update on '||r.owner||'.'||r.object_name||' to &grantee');
exception when others then
	dbms_output.put_line ('Error on '||r.owner||'.'||r.object_name);
	dbms_output.put_line (sqlerrm);
end;
end loop;
end;
/


begin
for r in 
(
select owner,object_name from dba_objects where owner = upper('&owner') and object_type in ('PACKAGE','PROCEDURE','FUNCTION')
)
loop
begin
	dbms_output.put_line ('grant execute on  '||r.owner||'.'||r.object_name||' to &grantee');
	execute immediate ('grant execute on '||r.owner||'.'||r.object_name||' to &grantee');
exception when others then
	dbms_output.put_line ('Error on '||r.owner||'.'||r.object_name);
	dbms_output.put_line (sqlerrm);
end;
end loop;
end;
/