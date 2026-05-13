-- ------------------------------------------------------------------------------
-- File       : archive_dest.sql
-- Purpose    : Oracle Data Guard administration helper: archive dest.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @archive_dest.sql
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
--v$archive_dest
col dest_id for 99
col dest_name for a20
col destination for a25
col process for a4
col max_connections for 99
col db_unique_name for a15
select DEST_ID,DEST_NAME,STATUS,DESTINATION,DELAY_MINS,MAX_CONNECTIONS,PROCESS,TRANSMIT_MODE,DB_UNIQUE_NAME from v$archive_dest;