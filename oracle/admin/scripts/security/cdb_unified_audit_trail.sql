-- ------------------------------------------------------------------------------
-- File       : cdb_unified_audit_trail.sql
-- Purpose    : Oracle security, audit, user, role or grants helper: cdb unified audit trail.
-- Category   : security
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @cdb_unified_audit_trail.sql
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
COLUMN con_id FORMAT 999999
COLUMN count FORMAT 99999
COLUMN name FORMAT a8
SELECT
   v.con_id, v.name, v.open_mode, COUNT(u.event_timestamp) count
FROM
   cdb_unified_audit_trail u
FULL OUTER JOIN v$containers v ON u.con_id = v.con_id
GROUP BY
   v.con_id, v.name, v.open_mode
ORDER BY
   v.con_id;
