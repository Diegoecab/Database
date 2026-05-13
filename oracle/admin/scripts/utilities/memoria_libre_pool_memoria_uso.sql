-- ------------------------------------------------------------------------------
-- File       : memoria_libre_pool_memoria_uso.sql
-- Purpose    : Oracle administration helper: memoria libre pool memoria uso.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @memoria_libre_pool_memoria_uso.sql
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
SELECT A.POOL " ", (A.BYTES / 1024) / 1024 || ' Megas' "Memoria Libre",
       (B.BYTES / 1024) / 1024 || ' Megas' "Memoria en uso"
  FROM V$SGASTAT A, V$SGASTAT B
 WHERE A.NAME = 'free memory' AND B.NAME = 'memory in use'  