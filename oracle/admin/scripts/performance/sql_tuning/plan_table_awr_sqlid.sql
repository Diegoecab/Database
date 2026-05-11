-- ------------------------------------------------------------------------------
-- File       : plan_table_awr_sqlid.sql
-- Purpose    : Oracle SQL performance and tuning helper: plan table awr sqlid.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @plan_table_awr_sqlid.sql
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
--plan_table_awr_sqlid


prompt ******************************************************************************************************************
prompt
prompt Execution Plans in AWR:
prompt
prompt ******************************************************************************************************************


SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR('&1',null,null,'ADVANCED'));
