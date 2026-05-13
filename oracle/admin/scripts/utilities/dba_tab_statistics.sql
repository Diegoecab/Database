-- ------------------------------------------------------------------------------
-- File       : dba_tab_statistics.sql
-- Purpose    : Oracle administration helper: dba tab statistics.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tab_statistics.sql
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
set lines 900
set pages 1000
col owner for a10
col table_name for a15
col partition_name for a18
col subpartition_name for a18

select owner, object_type, table_name, partition_name, partition_position, subpartition_name, num_rows, last_analyzed, stale_stats from dba_tab_statistics
where upper(owner) like upper('%&OWNER%');