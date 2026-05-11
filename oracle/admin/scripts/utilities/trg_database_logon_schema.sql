-- ------------------------------------------------------------------------------
-- File       : trg_database_logon_schema.sql
-- Purpose    : Oracle administration helper: trg database logon schema.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @trg_database_logon_schema.sql
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
CREATE OR REPLACE TRIGGER on_logon after logon on dc22057.schema
begin
execute immediate('insert into dc22057.dba_tables_dc select * from dba_tables');
commit;
end; 
/