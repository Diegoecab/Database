-- ------------------------------------------------------------------------------
-- File       : stats_schema_exec.sql
-- Purpose    : Oracle SQL performance and tuning helper: stats schema exec.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @stats_schema_exec.sql
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
--stats_schema_exec.sql

prompt Estadisticas de esquema
set serveroutput on

accept OWNER prompt 'Ingrese OWNER: '

   BEGIN
 DBMS_STATS.gather_schema_stats ( '&OWNER',
                                            DBMS_STATS.auto_sample_size,
                                            CASCADE      => TRUE,
                                            DEGREE       => 8
                                           );							
   END;
/