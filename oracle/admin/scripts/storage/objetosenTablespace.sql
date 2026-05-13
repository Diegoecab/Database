-- ------------------------------------------------------------------------------
-- File       : objetosenTablespace.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: objetosenTablespace.
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @objetosenTablespace.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
SELECT OWNER,
       DECODE (PARTITION_NAME,
               NULL, SEGMENT_NAME,
               SEGMENT_NAME || ':' || PARTITION_NAME
              ) OBJECTNAME,
       SEGMENT_TYPE OBJECTTYPE, NVL (BYTES / 1048576, 0) SIZEMB,
       NVL (INITIAL_EXTENT, 0) INITIALEXT, NVL (NEXT_EXTENT, 0) NEXTEXT,
       NVL (EXTENTS, 0) NUMEXTENTS, NVL (MAX_EXTENTS, 0) "MAXEXTENTS"
  FROM DBA_SEGMENTS
 WHERE TABLESPACE_NAME = :TABLESPACE