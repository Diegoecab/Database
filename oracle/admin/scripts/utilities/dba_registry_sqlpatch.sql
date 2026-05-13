-- ------------------------------------------------------------------------------
-- File       : dba_registry_sqlpatch.sql
-- Purpose    : Oracle administration helper: dba registry sqlpatch.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_registry_sqlpatch.sql
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
--dba_registry_sqlpatch
col comp_name for a40
col comp_id for a10
set lines 900
col logfile for a120 truncate
col action_time for a30 truncate
col status for a15 truncate
select install_id, patch_id,  action, status, action_time,logfile,source_version,target_version from dba_registry_sqlpatch order by action_time;
--select install_id, patch_id,  action, status, action_time,description,source_version,target_version from dba_registry_sqlpatch where action_time > '<YourDBCreationDate>' and patch_type = 'RU' order by action_time;
