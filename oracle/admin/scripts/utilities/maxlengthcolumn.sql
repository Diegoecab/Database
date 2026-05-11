-- ------------------------------------------------------------------------------
-- File       : maxlengthcolumn.sql
-- Purpose    : Oracle administration helper: maxlengthcolumn.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @maxlengthcolumn.sql
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
SET SERVEROUTPUT ON
declare maxs number;
BEGIN
for r in (
select column_name from dba_tab_columns where owner='DBADMIN' and table_name='TEST222' and data_type='VARCHAR2'
order by column_id)
loop
execute immediate 'select max(length('||r.column_name||')) from dbadmin.test222' into maxs;
dbms_output.put_line ('"'||R.column_name||'" VARCHAR2('||maxs||'),');
end loop;
END;
/