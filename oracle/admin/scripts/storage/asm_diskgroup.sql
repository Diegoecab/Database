-- ------------------------------------------------------------------------------
-- File       : asm_diskgroup.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: asm diskgroup.
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @asm_diskgroup.sql
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
col compatibility for a20
col DATABASE_COMPATIBILITY for a20
select group_number, name, state, type, total_mb, round(total_mb/1024) total_gb, free_mb, 
 COMPATIBILITY  ,                                                                      
 DATABASE_COMPATIBILITY,VOTING_FILES,
round(free_mb/1024) free_gb from  v$asm_diskgroup
 order by 1;
 
 
select group_number, name, state, type, total_mb, round(total_mb/1024) total_gb, free_mb, 
round(free_mb/1024) free_gb,  round(free_mb*100/total_mb) pct_free, 
round(100-(free_mb*100/total_mb)) pct_used from  v$asm_diskgroup
where total_mb > 0
 order by 10;
 
 