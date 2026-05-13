-- ------------------------------------------------------------------------------
-- File       : dba_fga_audit_trail.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba fga audit trail.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_fga_audit_trail.sql
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
--dba_fga_audit_trail
col sql_text for a30
col object_name for a25
col policy_name for a25
select DB_USER, timestamp, SQL_TEXT from dba_fga_audit_trail;

--select DB_USER, timestamp, SQL_TEXT, object_name,policy_name from dba_fga_audit_trail where object_schema='RRHH_DW'