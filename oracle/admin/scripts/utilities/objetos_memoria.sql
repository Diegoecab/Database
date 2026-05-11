-- ------------------------------------------------------------------------------
-- File       : objetos_memoria.sql
-- Purpose    : Oracle administration helper: objetos memoria.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @objetos_memoria.sql
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
SELECT   OWNER, NAME, TYPE, SHARABLE_MEM / 1024 / 1024 MB, LOADS
    FROM V$DB_OBJECT_CACHE
   WHERE NAME NOT IN (SELECT OBJECT_NAME
                        FROM DBA_RECYCLEBIN)
     AND OWNER IS NOT NULL
     AND NVL (SHARABLE_MEM, 0) > 0
     AND KEPT = 'NO'
ORDER BY LOADS DESC