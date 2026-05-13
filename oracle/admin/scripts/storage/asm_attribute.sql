-- ------------------------------------------------------------------------------
-- File       : asm_attribute.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: asm attribute.
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @asm_attribute.sql
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
col value for a50 
col name for a50
 
select name, value, group_number from v$asm_attribute; 
--where upper(name) like 'CELL%';