-- ------------------------------------------------------------------------------
-- File       : role_sys_privs.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: role sys privs.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @role_sys_privs.sql
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
--role_sys_privs

set verify off
undefine all
set define on

select role,privilege,admin_option from
role_sys_privs
where role like upper('%&role%')
and privilege like upper('%&privilege%')
and admin_option like upper('%&admin_option%')
order by 1,2
/