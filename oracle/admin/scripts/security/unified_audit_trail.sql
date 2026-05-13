-- ------------------------------------------------------------------------------
-- File       : unified_audit_trail.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: unified audit trail.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @unified_audit_trail.sql
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
set lines 900
col unified_audit_policies for a20
col dbusername for a20
col action_name for a20
col object_schema for a20
col object_name for a30
col sql_text for a50 truncate
col event_timestamp for a30

 select unified_audit_policies,event_timestamp,
dbusername,
action_name,
object_schema,
object_name,
sql_text
from unified_audit_trail
WHERE event_timestamp > trunc(sysdate) and UPPER(object_name)='EXT_LIB';
