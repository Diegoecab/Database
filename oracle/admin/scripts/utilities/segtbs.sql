-- ------------------------------------------------------------------------------
-- File       : segtbs.sql
-- Purpose    : Oracle administration helper: segtbs.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @segtbs.sql
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
select segment_name,partition_name,segment_type,bytes,extents,tablespace_name,
initial_extent,next_extent,pct_increase
from user_segments
where segment_name like upper('%&&1%')
and tablespace_name like upper('&&2')
order by bytes desc
/
