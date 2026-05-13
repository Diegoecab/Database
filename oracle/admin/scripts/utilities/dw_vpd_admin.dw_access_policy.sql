-- ------------------------------------------------------------------------------
-- File       : dw_vpd_admin.dw_access_policy.sql
-- Purpose    : Oracle administration helper: dw vpd admin dw access policy.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dw_vpd_admin.dw_access_policy.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
col user_name for a20
col object_name for a15
col predicate for a10
col rol for a10
col grupo_asociado for a10
col sub_grupo_asociado for a10
col schema_owner for a10