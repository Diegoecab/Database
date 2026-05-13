-- ------------------------------------------------------------------------------
-- File       : datafile.sql
-- Purpose    : Oracle administration helper: datafile.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @datafile.sql
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
set lines 500
col name for a100 truncate
col TBS_NAME for a20 truncate
select FILE#, b.NAME TBS_NAME, a.name,CREATION_TIME, round(BYTES/1024/1024/1024) size_gb,BLOCK_SIZE, STATUS, ENABLED
from v$datafile a
join v$tablespace b on a.ts#=b.ts#
order by 1;