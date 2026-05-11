-- ------------------------------------------------------------------------------
-- File       : dba_role_privs.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba role privs.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_role_privs.sql
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
--dba_role_privs

set verify off
undefine all
set define on
col stmt for a90
col granted_role for a30
col grantee for a20
col admin_option for a10
col default_role for a10


select grantee,granted_role,admin_option,default_role, case
when admin_option = 'NO' then
lower('grant '||granted_role||' to '||grantee||';')
when admin_option= 'YES' then
lower('grant '||granted_role||' to '||grantee||' with admin option;')
else '???'
end stmt
 from dba_role_privs 
where grantee like upper('%&grantee%')
and granted_role like upper('%&granted_role%')
and admin_option like upper('%&admin_option%')
and default_role like upper('%&default_role%')
order by 1,2
/
