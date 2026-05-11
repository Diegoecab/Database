-- ------------------------------------------------------------------------------
-- File       : asm_dg.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: asm dg.
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @asm_dg.sql
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
define dg=&1
set lines 185
set pages 50
col name for a20
col free_mb for 999,999,999.99
col used_mb for 999,999,999.99
col total_mb for 999,999,999.99
col new_aloc_mb for 999,999,999.99
col add_mb for 999,999,999.99
col pct_free for 999.99

select name,total_mb, total_mb-free_mb used_mb,free_mb,free_mb/total_mb*100 pct_free
,round((TOTAL_MB-FREE_MB)/(75/100),2) NEW_ALOC_MB
,round((TOTAL_MB-FREE_MB)/(75/100),2)-total_mb ADD_MB
from v$asm_diskgroup dg
where dg.name like upper('&dg')
--and free_mb/total_mb*100  < 20
order by pct_free desc
;
