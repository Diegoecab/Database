-- ------------------------------------------------------------------------------
-- File       : get_execplan.sql
-- Purpose    : Oracle SQL performance and tuning helper: get execplan.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @get_execplan.sql
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
set linesize 140
set pagesize 40
explain plan for 
select * from customers_obe where CUST_CREDIT_LIMIT=1500;

select plan_table_output plan from table(dbms_xplan.display('plan_table',null,'serial'));