-- ------------------------------------------------------------------------------
-- File       : control_dataguard.sql
-- Purpose    : Oracle Data Guard administration helper: control dataguard.
-- Category   : backup_recovery/dataguard
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @control_dataguard.sql
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
SELECT name, value,substr(value,2,2) DIA, substr(value,5,2) HORA, 
substr(value,8,2) MIN,substr(value,11,2) SEG, unit, time_computed
FROM V$DATAGUARD_STATS
WHERE name ='apply lag'
and substr(value,8,2) + ((substr(value,5,2)) * 60) > 60
/
