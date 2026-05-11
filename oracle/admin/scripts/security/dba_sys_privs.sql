-- ------------------------------------------------------------------------------
-- File       : dba_sys_privs.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba sys privs.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_sys_privs.sql
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
--dba_sys_privs

set verify off
undefine all
set define on

col privilege for a40
col grantee for a30
set lines 400

select grantee,privilege,admin_option, case
when admin_option = 'NO' then
lower('grant '||privilege||' to '||grantee||';')
when admin_option= 'YES' then
lower('grant '||privilege||' to '||grantee||' with grant option;')
else '???'
end stmt
 from dba_sys_privs 
where grantee like upper('%&grantee%')
and privilege like upper('%&privilege%')
and admin_option like upper('%&admin_option%')
order by 1,2
/