-- ------------------------------------------------------------------------------
-- File       : analyzed_tables.sql
-- Purpose    : Oracle database maintenance helper: analyzed tables.
-- Category   : maintenance/stats
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @analyzed_tables.sql
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
set pages 999 lines 100
select	a.owner
,	a.total_tables tables
,	nvl(b.analyzed_tables,0) analyzed
from	(select	owner
	,	count(*) total_tables
	from	dba_tables
	group	by owner) a
,	(select	owner
	,	count(last_analyzed) analyzed_tables
	from	dba_tables
	where	last_analyzed is not null
	group	by owner) b
where	a.owner = b.owner (+)
and	a.owner not in ('SYS', 'SYSTEM')
order	by a.total_tables - nvl(b.analyzed_tables,0) desc
/

