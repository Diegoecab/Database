-- ------------------------------------------------------------------------------
-- File       : dba_role_privs_x.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba role privs x (1).
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_role_privs_x (1).sql
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
prompt Usuarios que contienen un rol
select distinct grantee from dba_role_privs where granted_role=upper('&ROLE')
/
