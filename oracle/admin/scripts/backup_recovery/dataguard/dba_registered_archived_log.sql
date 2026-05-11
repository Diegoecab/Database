-- ------------------------------------------------------------------------------
-- File       : dba_registered_archived_log.sql
-- Purpose    : Oracle Data Guard administration helper: dba registered archived log.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_registered_archived_log.sql
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
set pagesize 1000 
col first_scn format 999999999999999999 
col next_scn format 999999999999999999 
alter session set nls_date_format='dd-mon-yyyy hh24:mi:ss'; 
select source_database,thread#,sequence#,name,modified_time,first_scn,next_scn,dictionary_begin,dictionary_end from dba_registered_archived_log where 634962926571  between first_scn and next_scn; 