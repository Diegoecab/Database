-- ------------------------------------------------------------------------------
-- File       : db_size.sql
-- Purpose    : Oracle administration helper: db size.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @db_size.sql
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
/*
select 'SEG', round(sum(bytes/1024/1024/1024),1) GB from dba_segments
union all
select 'DAT', round(sum(bytes/1024/1024/1024),1) GB from dba_data_files
union all
select 'TMP', round(sum(bytes/1024/1024/1024),1) GB from dba_temp_files
*/

select round(sum(GB)/1024,2) TB from (
select 'DAT', round(sum(bytes/1024/1024/1024),1) GB from dba_data_files
union all
select 'TMP', round(sum(bytes/1024/1024/1024),1) GB from dba_temp_files)
/

set lines 900
col compatibility for a20
col DATABASE_COMPATIBILITY for a20
COL NAME FOR A30

select group_number, name, state, type, total_mb, round(total_mb/1024) total_gb, free_mb, 
 COMPATIBILITY  ,                                                                      
 DATABASE_COMPATIBILITY,VOTING_FILES,
round(free_mb/1024) free_gb from  v$asm_diskgroup
 order by 1;
 
exit


