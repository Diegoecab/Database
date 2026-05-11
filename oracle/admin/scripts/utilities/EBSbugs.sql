-- ------------------------------------------------------------------------------
-- File       : EBSbugs.sql
-- Purpose    : Oracle administration helper: EBSbugs.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @EBSbugs.sql
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
set echo off veri off
accept 1 prompt 'Enter BUG number: '

prompt AD_BUGS
prompt =======
select * from apps.ad_bugs where bug_number = '&&1';

prompt AD_APPLIED_PATCHES
prompt =======
select * from apps.AD_APPLIED_PATCHES  where patch_name = '&&1';