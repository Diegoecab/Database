-- ------------------------------------------------------------------------------
-- File       : cantidad_extents_objetos.sql
-- Purpose    : Oracle administration helper: cantidad extents objetos.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @cantidad_extents_objetos.sql
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
/*Ver cantidad de extents que tiene un objeto*/


SELECT  OWNER USUARIO, SEGMENT_TYPE TIPO, SEGMENT_NAME OBJETO, EXTENTS_ACTUALES
    FROM (SELECT   OWNER,SEGMENT_TYPE, SEGMENT_NAME,
                   EXTENTS AS "EXTENTS_ACTUALES"
              FROM DBA_SEGMENTS
             WHERE OWNER IN ('GEM_ADM','SYSTEM','SYS')
          GROUP BY OWNER, SEGMENT_TYPE, SEGMENT_NAME,EXTENTS)
   WHERE EXTENTS_ACTUALES > 10
ORDER BY USUARIO, EXTENTS_ACTUALES DESC
