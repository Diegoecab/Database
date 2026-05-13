-- ------------------------------------------------------------------------------
-- File       : dbms_stats_toma_estadisticas.sql
-- Purpose    : Oracle SQL performance and tuning helper: dbms stats toma estadisticas.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_stats_toma_estadisticas.sql
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
/*ejemplo de toma de estadisticas para indice*/
exec dbms_stats.gather_index_stats ( ownname=>'ahs_sop',indname=>'stk_grupo_stks_idx',estimate_percent=>100);
/*ejemplo de toma de estadisticas para tabla*/
exec dbms_stats.gather_table_stats ( ownname=>'ahs_sop',tabname=>'stk_grupo_stks_idx',estimate_percent=>100);
