-- ------------------------------------------------------------------------------
-- File       : block_change_tracking.sql
-- Purpose    : Oracle RAC or cluster administration helper: block change tracking.
-- Category   : platform/rac
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @block_change_tracking.sql
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
col filename for a50
select status,filename,round(bytes/1024/1024,1) MB from v$block_change_tracking
/