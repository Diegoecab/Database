-- ------------------------------------------------------------------------------
-- File       : dba_feature_usage_statistics_java_jvm.sql
-- Purpose    : Oracle administration helper: dba feature usage statistics java jvm.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_feature_usage_statistics_java_jvm.sql
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
--dba_feature_usage_statistics_java_jvm
prompt For Oracle version 11.2 or later query the DBA_FEATURE_USAGE_STATISTICS view to confirm if the Java features are being used.

select currently_used, name from  dba_feature_usage_statistics where name like '%Java%';