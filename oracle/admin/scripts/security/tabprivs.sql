-- ------------------------------------------------------------------------------
-- File       : tabprivs.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: tabprivs.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tabprivs.sql
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
set linesize 180
col grantor format a10
col grantee format a20
col table_name format a30
col grantable format a4
select grantor, grantee, table_name, grantable, privilege 
from dba_tab_privs where table_name like upper('%&1%')
and grantee like upper('%&2%')
order by 1,2,3
/
