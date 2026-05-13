-- ------------------------------------------------------------------------------
-- File       : rman_backup_job_details.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: rman backup job details.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rman_backup_job_details.sql
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
--v$rman_backup_job_details.sql
col STATUS format a25
col hrs format 999.99
col start_time for a16
col end_time for a16
col compression_ratio heading 'Compress|Ratio' for 99.99
set pages 500
set lines 600
set verify off
select
SESSION_KEY, INPUT_TYPE, STATUS,
to_char(START_TIME,'mm/dd/yy hh24:mi') start_time,
to_char(END_TIME,'mm/dd/yy hh24:mi')   end_time,
round(compression_ratio,2) compression_ratio,
elapsed_seconds/3600                   hrs
from V$RMAN_BACKUP_JOB_DETAILS
--where STATUS='RUNNING'
order by START_TIME;