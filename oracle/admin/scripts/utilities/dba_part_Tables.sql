-- ------------------------------------------------------------------------------
-- File       : dba_part_Tables.sql
-- Purpose    : Oracle administration helper: dba part Tables.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_part_Tables.sql
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
--dba_part_Tables.sql
col interval for a50
set lines 400

select owner, table_name, partitioning_type, subpartitioning_type, partition_count, status,interval from dba_part_Tables
where owner like upper('%&owner%')
and table_name like upper('%&table_name%')
and partitioning_type like upper('%&partitioning_type%')
and subpartitioning_type like upper('%&subpartitioning_type%')
and partition_count like upper('%&partition_count%')
and status like upper('%&status%')
/