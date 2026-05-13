-- ------------------------------------------------------------------------------
-- File       : audit_unified_policies.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: audit unified policies.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @audit_unified_policies.sql
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
col AUDIT_CONDITION for a30
col POLICY_NAME for a30
col AUDIT_OPTION for a50
col OBJECT_NAME for a30
col OBJECT_SCHEMA for a30
set pages 1000
 select distinct
  policy_name,
  object_schema,
  object_name,
  audit_condition,
  audit_option,
 AUDIT_OPTION_TYPE
  from
  audit_unified_policies where policy_name in (select POLICY_NAME FROM audit_unified_enabled_policies)
 order by policy_name,object_schema;
