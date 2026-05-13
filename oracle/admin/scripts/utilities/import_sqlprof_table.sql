-- ------------------------------------------------------------------------------
-- File       : import_sqlprof_table.sql
-- Purpose    : Oracle administration helper: import sqlprof table.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @import_sqlprof_table.sql
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
--import_sqlprof_table.sql
set serveroutput on

accept staging_table prompt 'Enter value for staging_table: '
accept schema_name prompt 'Enter value for schema_name: '

begin
dbms_sqltune.unpack_stgtab_sqlprof(replace => true,staging_table_name => '&staging_table', staging_schema_owner => '&schema_name');
commit;
end;
/
