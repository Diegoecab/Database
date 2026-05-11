-- ------------------------------------------------------------------------------
-- File       : set_sqlplus_defaults.sql
-- Purpose    : Oracle administration helper: set sqlplus defaults.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @set_sqlplus_defaults.sql
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
col publish     format a18
col table_name  format a18
col index_name  format a21
col column_name format a22
col stale_percent format a20
set lines 120 
set pages 1000
set echo on 