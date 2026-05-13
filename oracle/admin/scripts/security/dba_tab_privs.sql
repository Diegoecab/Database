-- ------------------------------------------------------------------------------
-- File       : dba_tab_privs.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba tab privs.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tab_privs.sql
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
--dba_tab_privs.sql
set verify off
col owner for a20
col grantee for a20
col grantor for a20
col privilege for a25
col table_name for a40

set lines 400
set pages 5000

select grantee,owner,table_name,grantor,privilege,grantable,hierarchy, case
when grantable = 'NO' then
lower('grant '||privilege||' on '||owner||'.'||table_name||' to '||grantee||';')
when grantable= 'YES' then
lower('grant '||privilege||' on '||owner||'.'||table_name||' to '||grantee||' with grant option;')
else '???'
end stmt
from dba_tab_privs
where grantee like upper('%&grantee%')
and owner like upper('%&owner%') 
and table_name like upper('%&table_name%')
and grantor like upper('%&grantor%')
and privilege like upper('%&privilege%')
and grantable like upper('%&grantable%')
order by 1,2,3
/