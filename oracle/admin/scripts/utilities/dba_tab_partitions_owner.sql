-- ------------------------------------------------------------------------------
-- File       : dba_tab_partitions_owner.sql
-- Purpose    : Oracle administration helper: dba tab partitions owner.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tab_partitions_owner.sql
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
col subpartition_count heading 'Subp|Cnt' for 99
col table_owner heading 'Table|Owner' for a20
col pct_Free heading 'Pct|Free' for 99
col composite heading 'Com|Po|Si|Te'
col buffer_pool heading 'Buffer|Pool' for a8
col partition_position heading 'Part|Posit' for 999
col high_value for a80
set linesize 350

SELECT
table_owner,table_name,composite,partition_name,partition_position,high_value,
subpartition_count,tablespace_name,pct_free,logging,compression,buffer_pool
FROM dba_tab_partitions where table_owner='&OWNER'
ORDER BY 1,2,5
/