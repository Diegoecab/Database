-- ------------------------------------------------------------------------------
-- File       : dbms_sqldiag.create_sql_patch.sql
-- Purpose    : Oracle administration helper: dbms sqldiag create sql patch.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dbms_sqldiag.create_sql_patch.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--

DECLARE
   patch_name varchar2(100);
BEGIN
patch_name := dbms_sqldiag.create_sql_patch(
sql_id=>'g06d5qs35kkvf',
hint_text=>' FULL(@"SEL$58A6D7F6" "C"@"SEL$1")');
end;
/
	
	
	
	
DECLARE
   patch_name varchar2(100);
BEGIN
dbms_sqldiag.drop_sql_patch(name => 'SYS_SQLPTCH_0172be451e100000'
);
end;
/
	
	
	
	
	DECLARE
   patch_name varchar2(100);
BEGIN
patch_name := dbms_sqldiag.disable_sql_patch(
'SYS_SQLPTCH_0172be451e100000'
);
end;
/
	patch_name := dbms_sqldiag.create_sql_patch(