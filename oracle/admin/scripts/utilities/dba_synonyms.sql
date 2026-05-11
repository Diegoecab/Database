-- ------------------------------------------------------------------------------
-- File       : dba_synonyms.sql
-- Purpose    : Oracle administration helper: dba synonyms.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_synonyms.sql
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
--dba_synonyms.sql
set verify off
col db_link for a40
undefine all
set lines 400
col synonym_name for a30 truncate
col table_owner for a20 truncate
col owner for a20 truncate
col table_name for a30 truncate
col db_link for a30 truncate

select owner,synonym_name,table_owner,table_name,db_link 
from dba_synonyms 
where owner like upper('%&owner%')
and synonym_name like upper('%&synonym_name%')
and table_owner like upper('%&table_owner%')
and table_name like upper('%&table_name%')
and table_name like upper('%&table_name%')
order by 1,2,3
/