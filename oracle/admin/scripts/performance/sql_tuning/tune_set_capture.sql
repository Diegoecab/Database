-- ------------------------------------------------------------------------------
-- File       : tune_set_capture.sql
-- Purpose    : Oracle SQL performance and tuning helper: tune set capture.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tune_set_capture.sql
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
	dbms_sqltune.capture_cursor_cache_sqlset (
		sqlset_name => '&name'
		, time_limit => 216000 -- 1 hour ; 108000 30min; 300 5min
		, repeat_interval => 5 -- seconds
		, capture_mode => dbms_sqltune.MODE_ACCUMULATE_STATS
		, basic_filter => 'parsing_schema_name=upper(''&schema'')'
		);
end;
/
