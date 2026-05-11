-- ------------------------------------------------------------------------------
-- File       : dataguard_status.sql
-- Purpose    : Oracle Data Guard administration helper: dataguard status.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dataguard_status.sql
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
alter session set nls_date_format = 'dd/mm/yyyy HH24:MI:SS'; 
col message for a110
select timestamp, message from v$dataguard_status
where severity in ('Error','Fatal')
order by 1
/