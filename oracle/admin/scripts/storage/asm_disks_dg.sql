-- ------------------------------------------------------------------------------
-- File       : asm_disks_dg.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: asm disks dg.
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @asm_disks_dg.sql
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
col diskgroup for a20
col name for a20
col path for a30
col free_mb for 999,999,999.99
col total_mb for 999,999,999.99
col new_aloc_mb for 999,999,999.99
col add_mb for 999,999,999.99

select dg.name diskgroup
,dk.path
,dk.name
,dk.header_status
,dk.total_mb
,dk.free_mb
,dk.MOUNT_DATE
,dk.create_DATE
from v$asm_diskgroup dg
, v$asm_disk dk
where dg.group_number =dk.group_number
and dg.name =upper('&dg')
order by create_date
;
