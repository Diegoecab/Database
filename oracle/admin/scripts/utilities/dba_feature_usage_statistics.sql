-- ------------------------------------------------------------------------------
-- File       : dba_feature_usage_statistics.sql
-- Purpose    : Oracle administration helper: dba feature usage statistics.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_feature_usage_statistics.sql
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
--dba_feature_usage_statistics
col name for a45
col detected_usages for 999999
col total_samples for 9999999
col version for a10
SELECT name,version,first_usage_date,last_usage_date,detected_usages,total_samples
  FROM dba_feature_usage_statistics
 WHERE dbid IN (SELECT dbid
                  FROM v$database);