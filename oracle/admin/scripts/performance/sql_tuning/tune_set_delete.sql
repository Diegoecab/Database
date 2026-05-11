-- ------------------------------------------------------------------------------
-- File       : tune_set_delete.sql
-- Purpose    : Oracle SQL performance and tuning helper: tune set delete.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tune_set_delete.sql
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

define name=&1
begin
	dbms_sqltune.delete_sqlset (
		sqlset_name => '&name'
		);

end;
/
