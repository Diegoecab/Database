-- ------------------------------------------------------------------------------
-- File       : sql_sqltext.sql
-- Purpose    : Oracle administration helper: sql sqltext.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sql_sqltext.sql
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
--v$sql_sqltext.sql
set verify off
set long 100000
set lines 90
set pages 10000
set serveroutput on
col sql_fulltext for a20000 word_wrap
set feed off
set head off


--select sql_fulltext from gv$sql where sql_id='&1';
select sql_text from dba_hist_sqltext where sql_id='&1';

select sql_fulltext from v$sql where sql_id='&1';

set head on
set feed on