-- ------------------------------------------------------------------------------
-- File       : tam_indices.sql
-- Purpose    : Oracle administration helper: tam indices.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tam_indices.sql
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
/*Para ver el tamaño de un índice*/

SELECT (SUM (BYTES) / 1024) / 1024 "Tamaño MB"
  FROM DBA_EXTENTS
 WHERE SEGMENT_NAME = ’nombre_indice’;