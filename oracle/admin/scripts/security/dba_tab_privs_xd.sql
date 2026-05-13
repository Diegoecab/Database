-- ------------------------------------------------------------------------------
-- File       : dba_tab_privs_xd.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba tab privs xd.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tab_privs_xd.sql
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
accept usuario prompt 'Ingrese usuario:  '
col owner for a10
col grantee for a20
col grantor for a10
col privilege for a20
set linesize 130
select owner,table_name,grantor,privilege,grantable,hierarchy from dba_tab_privs where GRANTEE=upper('&USUARIO') order by 1,2,3;