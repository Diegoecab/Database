-- ------------------------------------------------------------------------------
-- File       : dba_indexes_table.sql
-- Purpose    : Oracle administration helper: dba indexes table.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_indexes_table.sql
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
set pages 1000
set verify off
set lines 900
set feedback off
set trims on
col owner for a20
col index_name for a30



select owner,index_name,tablespace_name,degree from dba_indexes where owner like upper('%&owner%') and upper(table_name) like (upper('%&TABLE%')) order by 1,2;