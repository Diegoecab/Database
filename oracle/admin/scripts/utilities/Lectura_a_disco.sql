-- ------------------------------------------------------------------------------
-- File       : Lectura_a_disco.sql
-- Purpose    : Oracle administration helper: Lectura a disco.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @Lectura_a_disco.sql
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
/*Este select es para ver la cantidad  en porcent. de veces que se realizo lecturas a disco desde que inicio la instancia.
Lo ideal es que la cantidad sea al menos 95%*/
SELECT mem.value/(disk.value + mem.value) Indicador
FROM v$sysstat mem, v$sysstat disk
WHERE mem.name = 'sorts (memory)'
AND   disk.name = 'sorts (disk)';