-- ------------------------------------------------------------------------------
-- File       : dba_hist_sqlbind.sql
-- Purpose    : Oracle administration helper: dba hist sqlbind.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_hist_sqlbind.sql
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
--dba_hist_sqlbind.sql
col VALUE_ANYDATA for a10
col value_string for a20
set lines 900
select VALUE_STRING, a.* from DBA_HIST_SQLBIND a
WHERE
  sql_id = '&SQLID' --and snap_id = (select max(snap_id) from DBA_HIST_SQLBIND b WHERE b.sql_id = a.sql_id)
  order by snap_id, position;