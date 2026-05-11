-- ------------------------------------------------------------------------------
-- File       : plan_table_object.sql
-- Purpose    : Oracle SQL performance and tuning helper: plan table object.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @plan_table_object.sql
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
--plan_table_object
--Plan de ejecucion de cualquier sql que se encuentre en memoria que haga referencia a un objeto en particular
accept OBJECT prompt 'Ingrese OBJETO:  '
SELECT t.*
FROM v$sql s, table(DBMS_XPLAN.DISPLAY_CURSOR(s.sql_id, s.child_number)) t WHERE sql_text LIKE upper('%&OBJECT%');