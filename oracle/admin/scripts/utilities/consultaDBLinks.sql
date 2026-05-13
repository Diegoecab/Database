-- ------------------------------------------------------------------------------
-- File       : consultaDBLinks.sql
-- Purpose    : Oracle administration helper: consultaDBLinks.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @consultaDBLinks.sql
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
set feedback off
set heading off
set linesize 500
set pagesize 15000
spool dblinks.log
select db_link||'*'||owner||'*'||''||'*'||username||'*'||created from dba_db_links;
select host||'*' from dba_db_links;
select db_link||'*'||owner||'*'||host||'*'||host||'*'||username||'*'||to_date(created,'DD/MM/YYYY') from dba_db_links;
spool off