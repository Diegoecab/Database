-- ------------------------------------------------------------------------------
-- File       : Uso_Actual_de_componentes_en_memoria.sql
-- Purpose    : Oracle administration helper: Uso Actual de componentes en memoria.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @Uso_Actual_de_componentes_en_memoria.sql
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
SELECT RPAD (component, 30), current_size / 1024 / 1024 taman_act_mb,
       min_size / 1024 / 1024 taman_min_mb, max_size, oper_count
  FROM v$sga_dynamic_components
 WHERE component LIKE '%buffer cache%';