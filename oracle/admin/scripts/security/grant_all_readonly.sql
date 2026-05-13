-- ------------------------------------------------------------------------------
-- File       : grant_all_readonly.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: grant all readonly.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @grant_all_readonly.sql
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
--grant_all_readonly.sql

set serveroutput on
begin
for r in 
(
select owner,object_name from dba_objects where owner = upper('%&owner%') and object_type in ('TABLE','VIEW','MATERIALIZED VIEW')
)
loop
begin
execute immediate ('grant select on '||r.owner||'.'||r.object_name||' to &grantee');
exception when others then
dbms_output.put_line ('Error on '||r.owner||'.'||r.object_name);
dbms_output.put_line (sqlerrm);
end;
end loop;
end;
/