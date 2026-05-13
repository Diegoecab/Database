-- ------------------------------------------------------------------------------
-- File       : process_memory_pga.sql
-- Purpose    : Oracle administration helper: process memory pga.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @process_memory_pga.sql
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
--@process_memory_pga
set lines 110
col unm format a35 hea "USERNAME (SID,SERIAL#)"
col pus format 999999999 hea "PROC MB|USED"
col pal format 999999999 hea "PROC MB|MAX ALLOC"
col pgu format 999999999 hea "PGA MB|USED"
col pga format 999999999 hea "PGA MB|ALLOC"
col pgm format 999999999 hea "PGA MB|MAX MEM"

select s.username||' ('||s.sid||','||s.serial#||')' unm, round((sum(m.used)/1024/1024),1) pus,
round((sum(m.max_allocated)/1024/1024),1) pal, round((sum(p.pga_used_mem)/1024/1024),1) pgu,
round((sum(p.pga_alloc_mem)/1024/1024),1) pga, round((sum(p.pga_max_mem)/1024/1024),1) pgm
from v$process_memory m, v$session s, v$process p
where m.serial# = p.serial# and p.pid = m.pid and p.addr=s.paddr and
s.username is not null group by s.username, s.sid, s.serial# order by unm;