-- ------------------------------------------------------------------------------
-- File       : role_tab_privs.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: role tab privs.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @role_tab_privs.sql
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
--role_tab_privs

set verify off
undefine all
set define on

select * from
role_tab_privs
where role like upper('%&role%')
and owner like upper('%&owner%')
and table_name like upper('%&table_name%')
and column_name like upper('%&column_name%')
and privilege like upper('%&privilege%')
and grantable like upper('%&grantable%')
order by 1,2,3
/