-- ------------------------------------------------------------------------------
-- File       : timezone_file_version_dst_check_objects.sql
-- Purpose    : Oracle administration helper: timezone file version dst check objects.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @timezone_file_version_dst_check_objects.sql
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
SELECT VERSION FROM V$TIMEZONE_FILE;

--This select gives all TimeStamp with Time Zone (TSTZ) columns in your database:
select c.owner || '.' || c.table_name || '(' || c.column_name || ') -'|| c.data_type || ' ' col
from dba_tab_cols c, dba_objects o 
where c.data_type like '%WITH TIME ZONE'
and c.owner=o.owner
and c.table_name = o.object_name
and o.object_type = 'TABLE'
order by col;
