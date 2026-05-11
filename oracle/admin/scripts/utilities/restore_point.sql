-- ------------------------------------------------------------------------------
-- File       : restore_point.sql
-- Purpose    : Oracle administration helper: restore point.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @restore_point.sql
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
SET PAGESIZE 60
SET LINESIZE 300
SET VERIFY OFF
 
COLUMN scn FOR 999999999999999
COLUMN Incar FOR 99
COLUMN name FOR A25
COLUMN storage_size FOR 9999999999999
COLUMN guarantee_flashback_database FOR A3
 
SELECT 
      database_incarnation# as Incar,
      scn,
      name,
      time,
      storage_size/1024/1024,
      guarantee_flashback_database
FROM 
      v$restore_point
ORDER BY 4
/