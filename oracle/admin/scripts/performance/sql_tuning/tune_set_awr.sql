-- ------------------------------------------------------------------------------
-- File       : tune_set_awr.sql
-- Purpose    : Oracle SQL performance and tuning helper: tune set awr.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tune_set_awr.sql
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

exec dbms_output.put_line('Sqlset name: ');
define name=&1
exec dbms_output.put_line('Sqlset schema: ');
define schema=&2

declare
c_sql dbms_sqltune.sqlset_cursor;
filter varchar2(300) :='parsing_schema_name = '''||'&schema'||'''';
BEGIN
	--dbms_output.put_line(filter);
	open c_sql for
	select value(p)
	from table( dbms_sqltune.select_workload_repository (
			&snap_begin,
			&snap_end,
			basic_filter => filter) 
	) p;

	dbms_sqltune.load_sqlset (
				sqlset_name => '&name',
				populate_cursor => c_sql
				);

	close c_sql;
END;
/
