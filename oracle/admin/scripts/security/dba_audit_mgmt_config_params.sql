-- ------------------------------------------------------------------------------
-- File       : dba_audit_mgmt_config_params.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: dba audit mgmt config params.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_audit_mgmt_config_params.sql
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
col PARAMETER_NAME for a40
col PARAMETER_VALUE for a40
set pages 100
SELECT *
FROM   dba_audit_mgmt_config_params;
