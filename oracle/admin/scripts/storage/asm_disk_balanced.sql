-- ------------------------------------------------------------------------------
-- File       : asm_disk_balanced.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: asm disk balanced.
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @asm_disk_balanced.sql
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
select group_number, max(free_mb) biggest, min(free_mb) lowest, avg(free_mb) AVG,
trunc(GREATEST ((avg(free_mb)*100/max(free_mb)),(min(free_mb)*100/avg(free_mb))),2)||'%' as balanced,
trunc(100-(GREATEST ((avg(free_mb)*100/max(free_mb)),(min(free_mb)*100/avg(free_mb)))),2)||'%' as inbalanced
from v$asm_disk
where group_number in
(select group_number from v$asm_diskgroup where name like upper('%&DG%'))
group by group_number;