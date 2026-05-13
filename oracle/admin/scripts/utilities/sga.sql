-- ------------------------------------------------------------------------------
-- File       : sga.sql
-- Purpose    : Oracle administration helper: sga.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sga.sql
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
SET LINESIZE 145
SET PAGESIZE 9999
SET FEEDBACK off
SET VERIFY   off

COLUMN bytes   FORMAT  999,999,999
COLUMN percent FORMAT  999.99999

break on report

compute sum of bytes on report
compute sum of percent on report

SELECT
    a.name
  , a.bytes
  , a.bytes/(b.sum_bytes*100)  Percent  
FROM sys.v_$sgastat a
   , (SELECT SUM(value)sum_bytes FROM sys.v_$sga) b 
ORDER BY bytes DESC
/