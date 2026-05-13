-- ------------------------------------------------------------------------------
-- File       : dba_part_key_columns_x.sql
-- Purpose    : Oracle administration helper: dba part key columns x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_part_key_columns_x.sql
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
--dba_part_key_columns_x
col column_name for a20
select * from 
DBA_PART_KEY_COLUMNS where owner='&OWNER' and name='&NAME'
order by 1,2;