-- ------------------------------------------------------------------------------
-- File       : dba_mviews.sql
-- Purpose    : Oracle administration helper: dba mviews.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_mviews.sql
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
col master_link for a20
col owner for a20
col query for a40
col mview_name for a40
set lines 400
select mview_name,MASTER_LINK,
REWRITE_ENABLED,
REWRITE_CAPABILITY,
REFRESH_MODE,
REFRESH_METHOD,
BUILD_MODE,
FAST_REFRESHABLE,
LAST_REFRESH_TYPE,
LAST_REFRESH_DATE from dba_mviews
/
