-- ------------------------------------------------------------------------------
-- File       : backupRMAN.sql
-- Purpose    : Oracle RMAN backup, restore or recovery helper: backupRMAN.
-- Category   : backup_recovery/rman
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @backupRMAN.sql
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
set feedback off
set linesize 150
col INPUT_MBYTES format 999,999
select START_TIME,END_TIME,INPUT_TYPE,STATUS,round(INPUT_BYTES/1024/1024)INPUT_MBYTES,OUTPUT_DEVICE_TYPE,AUTOBACKUP_DONE
from V$RMAN_BACKUP_JOB_DETAILS
order by start_time;
col controlfile_included format a20
select
CONTROLFILE_INCLUDED       ,
PIECES                       ,
START_TIME                    ,
ELAPSED_SECONDS                ,
DEVICE_TYPE              ,
round(ORIGINAL_INPUT_BYTES/1024/1024) IMPUT_MBYTES
from v$BACKUP_SET_DETAILS
order by start_time
/
