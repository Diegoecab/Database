-- ------------------------------------------------------------------------------
-- File       : dba_hist_sqlbind_x.sql
-- Purpose    : Oracle administration helper: dba hist sqlbind x.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_hist_sqlbind_x.sql
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
--dba_hist_sqlbind_x
set lines 400
set pages 1000
col value_string for a50
col value_anydata for a50
col name for a10



break on snap_id skip 1


select 
snap_id,name,position,datatype_string, last_captured,value_string
 from DBA_HIST_SQLBIND where SQL_ID='&SQLID'
and last_captured > sysdate -1
order by SNAP_ID,POSITION
/