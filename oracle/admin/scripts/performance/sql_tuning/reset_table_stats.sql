-- ------------------------------------------------------------------------------
-- File       : reset_table_stats.sql
-- Purpose    : Oracle SQL performance and tuning helper: reset table stats.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @reset_table_stats.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : REVIEW
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
connect sh/sh
alter session set nls_date_format='mm/dd hh24:mi:ss';
-- delete statistics
exec dbms_stats.delete_table_stats('SH', 'CUSTOMERS_OBE');

