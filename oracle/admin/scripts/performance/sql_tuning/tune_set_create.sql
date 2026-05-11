-- ------------------------------------------------------------------------------
-- File       : tune_set_create.sql
-- Purpose    : Oracle SQL performance and tuning helper: tune set create.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tune_set_create.sql
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
set serveroutput on
set pages 80
set lines 185

--exec dbms_output.put_line('Sqlset name: ');
PROMPT Sqlset name:
define name=&1
--exec dbms_output.put_line('Sqlset description: ');
PROMPT Sqlset description
define description=&2

begin
	dbms_sqltune.create_sqlset(
		sqlset_name => '&name',
		description => '&description');
end;
/
