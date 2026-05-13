-- ------------------------------------------------------------------------------
-- File       : dba_tab_privs_x.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba tab privs x.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tab_privs_x.sql
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
set verify off
col owner for a10
col grantee for a20
col grantor for a10
col privilege for a20
set lines 300

select * from dba_tab_privs where 
grantee like upper('%&grantee%')
and owner like upper('%&owner%') 
and table_name like upper('%&table_name%')
and grantor like upper('%&grantor%')
and privilege like upper('%&privilege%')
and grantable like upper('%&grantable%')
order by 1,2,3
/