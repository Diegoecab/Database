-- ------------------------------------------------------------------------------
-- File       : dba_indexes_tbs.sql
-- Purpose    : Oracle administration helper: dba indexes tbs.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_indexes_tbs.sql
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
REM
set verify off
set linesize 200
col owner for a20
col index_type for a10
col degree for 9
accept TBS prompt 'Ingrese nombre de tablespace: '
select owner,index_name,index_type,table_name,uniqueness,compression,degree from dba_indexes where tablespace_name=upper('&TBS') order by 1,3,4,5;