-- ------------------------------------------------------------------------------
-- File       : segments_to_keep_sql.sql
-- Purpose    : Oracle administration helper: segments to keep sql.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @segments_to_keep_sql.sql
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
--segments_to_keep_Sql.sql
PROMPT ONLINE:
SELECT    'ALTER '
       || SEGMENT_TYPE
       || ' '
       || OWNER
       || '.'
       || SEGMENT_NAME
       || ' storage (buffer_pool keep);' SQL
  FROM DBAS.OBJETOS_TO_KEEP;
  
set linesize 120
col sql for a80
prompt
PROMPT TABLA DBAS.SEGMENTS_TO_KEEP
prompt
SELECT    'ALTER '
       || SEGMENT_TYPE
       || ' '
       || OWNER
       || '.'
       || SEGMENT_NAME
       || ' storage (buffer_pool keep);' SQL, MB
  FROM DBAS.SEGMENTS_TO_KEEP;

prompt
prompt luego de subir los objetos, ejecutar truncate table DBAS.SEGMENTS_TO_KEEP;
prompt