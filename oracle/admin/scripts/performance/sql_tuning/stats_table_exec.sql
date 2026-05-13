-- ------------------------------------------------------------------------------
-- File       : stats_table_exec.sql
-- Purpose    : Oracle SQL performance and tuning helper: stats table exec.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @stats_table_exec.sql
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
--stats_table_exec.sql

prompt Estadisticas de esquema
set serveroutput on
set timing on

accept OWNER prompt 'Ingrese OWNER: '
accept TABLE prompt 'Ingrese TABLA: '
accept POR prompt 'Ingrese PORCENTAJE (Ej. DBMS_STATS.AUTO_SAMPLE_SIZE o 100): '

BEGIN
   DBMS_STATS.gather_table_stats (ownname               => '&OWNER',
                                  tabname               => '&TABLE',
                                  estimate_percent      => &POR,
                                  method_opt            => 'FOR ALL COLUMNS SIZE AUTO',
								  cascade 				=> true		
                                 );
END;
/

prompt Estadistica ejecutada sobre la tabla &TABLE de &OWNER
prompt method_opt FOR ALL COLUMNS SIZE AUTO
prompt estimate_percent &POR