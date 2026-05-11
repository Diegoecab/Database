-- ------------------------------------------------------------------------------
-- File       : tamaño_objetos.sql
-- Purpose    : Oracle administration helper: tamaño objetos.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tamaño_objetos.sql
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
/* Tama�o Objetos de la BD en MB */

SELECT   OWNER, SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME,
         BYTES / 1024 / 1024 || ' MB' MB
    FROM DBA_SEGMENTS
   WHERE OWNER <> 'SYS'
ORDER BY BYTES DESC