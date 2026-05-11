-- ------------------------------------------------------------------------------
-- File       : partition_control.sql
-- Purpose    : Oracle administration helper: partition control.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @partition_control.sql
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
set linesize 180
select TP.TABLE_OWNER, TP.TABLE_NAME, tp.partition_name,NUM_ROWS, LAST_ANALYZED
 from
 ( select table_name, max(partition_position) max
   from dba_tab_partitions
   WHERE TABLE_owner NOT IN ( 'SYS','SYSTEM')
   group by table_name ) aux,
   dba_tab_partitions tp
 where  tp.table_name = aux.table_name
   and  tp.partition_position = aux.max
   and  TABLE_owner NOT IN ( 'SYS','SYSTEM')
   AND (NUM_ROWS > 0 OR TRUNC(LAST_ANALYZED) <= TRUNC(SYSDATE) - 15) 
/
