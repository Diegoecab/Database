-- ------------------------------------------------------------------------------
-- File       : dba_policies.sql
-- Purpose    : Oracle administration helper: dba policies.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_policies.sql
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
--dba_policies
col object_owner for a9
col object_name for a25
col policy_group for a12
col policy_name for a12
col pf_owner for a12
col package for a5
col policy_type for a10
col function for a22
select * from dba_policies;