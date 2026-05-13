-- ------------------------------------------------------------------------------
-- File       : rman_backup_job_details_vview.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: v$rman backup job details (1).
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @v$rman_backup_job_details (1).sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : RMAN, Oracle environment, and required backup/recovery privileges.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
col STATUS format a9
col hrs format 999.99
col start_time for a16
col end_time for a16
set pagesize 100
select
SESSION_KEY, INPUT_TYPE, STATUS,
to_char(START_TIME,'mm/dd/yy hh24:mi') start_time,
to_char(END_TIME,'mm/dd/yy hh24:mi')   end_time,
elapsed_seconds/3600                   hrs
from V$RMAN_BACKUP_JOB_DETAILS
order by session_key;