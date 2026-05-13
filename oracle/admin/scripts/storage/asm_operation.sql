-- ------------------------------------------------------------------------------
-- File       : asm_operation.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: asm operation.
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @asm_operation.sql
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
set lines 1200 pages 1000
col error_code form a30
col name for a12
select dg.name, o.* from gv$asm_operation o, v$asm_diskgroup dg where o.group_number = dg.group_number;