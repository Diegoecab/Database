-- ------------------------------------------------------------------------------
-- File       : uso_memoria.sql
-- Purpose    : Oracle administration helper: uso memoria.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @uso_memoria.sql
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
/* Uso de SGA */
SELECT   1 NUM, 'db buffer cache' AREA, NAME, RPAD (SUM (BYTES)/1024/1024,4) MB
    FROM V$SGASTAT
   WHERE POOL IS NULL AND NAME IN ('db_block_buffers', 'buffer_cache')
GROUP BY NAME
UNION ALL
SELECT   2, 'shared pool', POOL, RPAD (SUM (BYTES)/1024/1024,4) MB
    FROM V$SGASTAT
   WHERE POOL = 'shared pool'
GROUP BY POOL
UNION ALL
SELECT   3, 'large pool', POOL, RPAD (SUM (BYTES)/1024/1024,4) MB
    FROM V$SGASTAT
   WHERE POOL = 'large pool'
GROUP BY POOL
UNION ALL
SELECT   4, 'java pool', POOL, RPAD (SUM (BYTES)/1024/1024,4) MB
    FROM V$SGASTAT
   WHERE POOL = 'java pool'
GROUP BY POOL
UNION ALL
SELECT   5, 'redo log buffer', NAME, RPAD (SUM (BYTES)/1024/1024,4) MB
    FROM V$SGASTAT
   WHERE POOL IS NULL AND NAME = 'log_buffer'
GROUP BY NAME
UNION ALL
SELECT   6, 'fixed SGA', NAME, RPAD (SUM (BYTES)/1024/1024,4) MB
    FROM V$SGASTAT
   WHERE POOL IS NULL AND NAME = 'fixed_sga'
GROUP BY NAME
/


/* Uso del Shared_Pool */
SELECT   'shared pool' AREA, NAME, RPAD (SUM (BYTES)/1024/1024,4) MB
    FROM V$SGASTAT
   WHERE POOL = 'shared pool'
     AND NAME IN
             ('library cache', 'dictionary cache', 'free memory', 'sql area')
GROUP BY NAME
UNION ALL
SELECT   'shared pool' AREA, 'miscellaneous', RPAD (SUM (BYTES)/1024/1024,4) MB
    FROM V$SGASTAT
   WHERE POOL = 'shared pool'
     AND NAME NOT IN
             ('library cache', 'dictionary cache', 'free memory', 'sql area')
GROUP BY POOL

/