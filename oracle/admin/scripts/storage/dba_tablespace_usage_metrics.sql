-- ------------------------------------------------------------------------------
-- File       : dba_tablespace_usage_metrics.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: dba tablespace usage metrics.
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @dba_tablespace_usage_metrics.sql
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
--dba_tablespace_usage_metrics.SQL
SELECT t.tablespace_name, t.contents, ROUND(m.used_percent, 2) as pct_used, 
ROUND((m.tablespace_size)*t.block_size/1024/1024, 3) mb_size,
ROUND((m.tablespace_size - m.used_space)*t.block_size/1024/1024, 3) mb_free, bigfile
FROM dba_tablespace_usage_metrics m,
dba_tablespaces t,
v$parameter p
WHERE p.name='statistics_level' and p.value!='BASIC'
AND t.tablespace_name = m.tablespace_name(+)
order by 3
;