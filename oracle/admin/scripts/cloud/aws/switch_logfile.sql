-- ------------------------------------------------------------------------------
-- File       : switch_logfile.sql
-- Purpose    : AWS/RDS/DMS Oracle administration helper: switch logfile.
-- Category   : cloud/aws
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @switch_logfile.sql
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
select sequence# from v$log where status='CURRENT';
exec rdsadmin.rdsadmin_util.switch_logfile;
select sequence# from v$log where status='CURRENT';
