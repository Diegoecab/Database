-- ------------------------------------------------------------------------------
-- File       : explain_plan.sql
-- Purpose    : Oracle SQL performance and tuning helper: explain plan (1).
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @explain_plan (1).sql
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
set pages 1000
set verify off
set lines 132
set feedback off
set trims on

accept SQL prompt 'Ingrese SQL: '

explain plan for &SQL

select 
  substr (lpad(' ', level-1) || operation || ' (' || options || ')',1,30 ) "Operation", 
  object_name                                                              "Object"
from 
  plan_table 
start with id = 0 
connect by prior id=parent_id;