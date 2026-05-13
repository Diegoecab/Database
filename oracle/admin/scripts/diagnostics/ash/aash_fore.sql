-- ------------------------------------------------------------------------------
-- File       : aash_fore.sql
-- Purpose    : Oracle diagnostic query/report helper: aash fore.
-- Category   : diagnostics/ash
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @aash_fore.sql
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
select CNT,
( CNT / ((CAST(sysdate AS DATE) - CAST(sysdate-7 AS DATE)) * 86400)) as AAS,
round(( CNT / ((CAST(sysdate AS DATE) - CAST(sysdate-7 AS DATE)) * 86400))*100/( select to_number(value) cpu_count from v$parameter where name='cpu_count'),1) AAS_FORE_PCT
from (
 select  10 * (COUNT(*)) as CNT
        FROM DBA_HIST_ACTIVE_SESS_HISTORY a where session_type <> 'BACKGROUND'
and sample_time BETWEEN sysdate-7 AND sysdate
 )
/
