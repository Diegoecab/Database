-- ------------------------------------------------------------------------------
-- File       : rep.sql
-- Purpose    : Oracle administration helper: rep.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @rep.sql
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
select a.owner, mview_name, rname,  updatable,refresh_method 
from dba_mviews a,dba_refresh_children  b
where mview_name = '&1'
and name = mview_name
and a.owner = b.owner
/