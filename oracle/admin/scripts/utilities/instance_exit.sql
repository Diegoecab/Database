-- ------------------------------------------------------------------------------
-- File       : instance_exit.sql
-- Purpose    : Oracle administration helper: instance exit.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @instance_exit.sql
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
set lines 400
col instance_number for 99
col host_name for a30
col database_status heading "Database|Status" 
select * from (
select '*' connected, instance_number,logins,instance_name,host_name,version,startup_time,status, database_status from v$instance a
union 
select  ' ' connected , instance_number,logins,instance_name,host_name,version,startup_time,status, database_status from gv$instance where instance_number <> (select instance_number from v$instance))
order by 2;

SHOW CON_NAME

exit;