-- ------------------------------------------------------------------------------
-- File       : audit1.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: audit1.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @audit1.sql
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
set linesize 220
col username format a20
col obj_name format a20
col priv_used format a20
col action_name format a20
col userhost format a20
select count(*) cant, username, obj_name, priv_used, action_name, userhost
from dba_audit_trail
group by username, obj_name, priv_used, action_name, userhost
/
