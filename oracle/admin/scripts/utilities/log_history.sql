-- ------------------------------------------------------------------------------
-- File       : log_history.sql
-- Purpose    : Oracle administration helper: log history.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @log_history.sql
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
--v$log_history.sql

alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS';
select sequence#, first_time from v$log_history 
where first_time > &first_time
order by sequence#
/