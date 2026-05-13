-- ------------------------------------------------------------------------------
-- File       : dba_audit_policies.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba audit policies.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_audit_policies.sql
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
--DBA_AUDIT_POLICIES
col object_owner for a9
col object_name for a25
col policy_group for a12
col policy_name for a12
col pf_owner for a12
col package for a5
col policy_type for a10
col function for a22
col policy_text for a15
col object_schema for a15
col pf_function for a10
col policy_column for a10
select object_schema,object_name,policy_name,policy_text,pf_schema,pf_package,pf_function,enabled,audit_trail from DBA_AUDIT_POLICIES;