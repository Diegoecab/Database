-- ------------------------------------------------------------------------------
-- File       : relaciones_entre_tablas.sql
-- Purpose    : Oracle administration helper: relaciones entre tablas (2).
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @relaciones_entre_tablas (2).sql
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
/* Este script me da una lista de tablas a las que hace referencia una tabla en particular*/
SELECT DISTINCT B.TABLE_NAME FROM ALL_CONSTRAINTS A ,ALL_CONSTRAINTS B 
WHERE A.TABLE_NAME='NOMBRE_DE_TABLA' AND A.CONSTRAINT_TYPE ='R'
AND A.R_CONSTRAINT_NAME=B.CONSTRAINT_NAME

/* Este script busca las tablas hijas de una tabla en particular*/
SELECT TABLE_NAME, CONSTRAINT_NAME
  FROM ALL_CONSTRAINTS
 WHERE CONSTRAINT_TYPE = 'R'
   AND R_CONSTRAINT_NAME IN (
                  SELECT CONSTRAINT_NAME
                    FROM ALL_CONSTRAINTS
                   WHERE TABLE_NAME = 'ENT_ENTIDADES'
                         AND CONSTRAINT_TYPE = 'P')