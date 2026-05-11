-- ------------------------------------------------------------------------------
-- File       : archived_log_scn.sql
-- Purpose    : Oracle Data Guard administration helper: archived log scn.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @archived_log_scn.sql
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
col first_change# for 999999999999999
col next_change# for 999999999999999
set lines 400

select thread#,sequence#,FIRST_CHANGE#,NEXT_CHANGE#,FIRST_TIME,RESETLOGS_ID from v$archived_log where 690601453767 between FIRST_CHANGE# and NEXT_CHANGE#;


col first_change# for 999999999999999
col next_change# for 999999999999999

select thread#,sequence#,FIRST_CHANGE#,NEXT_CHANGE#,FIRST_TIME from v$archived_log where sequence#=18076 and thread#=1;