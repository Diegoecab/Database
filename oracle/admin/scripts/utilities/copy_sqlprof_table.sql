-- ------------------------------------------------------------------------------
-- File       : copy_sqlprof_table.sql
-- Purpose    : Oracle administration helper: copy sqlprof table.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @copy_sqlprof_table.sql
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
--copy_sqlprof_table.sql

accept staging_table prompt 'Enter value for staging_table: '
accept schema_name prompt 'Enter value for schema_name: '
accept sql_profile_id prompt 'Enter value for sql_profile_id: '

begin
DBMS_SQLTUNE.CREATE_STGTAB_SQLPROF (table_name=>'&staging_table',schema_name=>'&schema_name'); 
commit;
end;
/

begin
DBMS_SQLTUNE.PACK_STGTAB_SQLPROF ( staging_schema_owner => '&schema_name', staging_table_name => '&staging_table',profile_name=>'&sql_profile_id');
end;
/