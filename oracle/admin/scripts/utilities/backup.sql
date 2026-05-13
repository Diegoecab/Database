-- ------------------------------------------------------------------------------
-- File       : backup.sql
-- Purpose    : Oracle administration helper: backup.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @backup.sql
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
column file_name format a50
col tablespace_name format a15
set lines 132

select
	t.name tablespace_name,
	f.name file_name,
	b.status
from
	v$backup b,
	v$datafile f,
	v$tablespace t
where 	b.file# = f.file# and
	f.ts# = t.ts#
/
