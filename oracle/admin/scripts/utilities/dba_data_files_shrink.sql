-- ------------------------------------------------------------------------------
-- File       : dba_data_files_shrink.sql
-- Purpose    : Oracle administration helper: dba data files shrink.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_data_files_shrink.sql
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
--dba_data_files_shrink.sql
--Author Diego Cabrera Apr 2012
set verify off
ACCEPT DB_BLOCK_SIZE PROMPT 'DB_BLOCK_SIZE [8192] : ' default 8192
ACCEPT ts_name PROMPT 'TABLESPACE NAME: '

col cmd for a200
set lines 600

COMPUTE SUM LABEL 'TOTAL' OF released_size ON report;
COMPUTE SUM LABEL 'TOTAL' OF real_size ON report;
COMPUTE SUM LABEL 'TOTAL' OF shrinked_size ON report;

SELECT   ROUND(bytes / 1024 / 1024) real_size,
         CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024) shrinked_size,
         round(bytes / 1024 / 1024
         - CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024))
            released_size,
            'alter database datafile '
         || ''''
         || file_name
         || ''''
         || ' resize '
         || CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024)
         || ' m; -- (current size '||bytes/1024/1024||' MB)'
            cmd
  FROM   dba_data_files a, (  SELECT   file_id, MAX (block_id + blocks - 1) hwm
                                FROM   dba_extents
                            GROUP BY   file_id) b
 WHERE       tablespace_name = '&ts_name'
         AND a.file_id = b.file_id(+)
         AND CEIL (blocks * &DB_BLOCK_SIZE / 1024 / 1024)
            - CEIL ( (NVL (hwm, 1) * &DB_BLOCK_SIZE) / 1024 / 1024) > 0 order by 3;