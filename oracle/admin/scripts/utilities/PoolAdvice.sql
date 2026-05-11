-- ------------------------------------------------------------------------------
-- File       : PoolAdvice.sql
-- Purpose    : Oracle administration helper: PoolAdvice.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @PoolAdvice.sql
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
--v$shared_pool_advice
set lines 400
set pages 999

col shared_pool_size_for_estimate format 99999999 head "Shared Pool Size (MB)"
col shared_pool_size_factor head "Size Factor"
col estd_lc_memory_object_hits format 99999999 head "Estimated Hits in Library Cache"
col estd_lc_size format 99999999 head "Estimate of LC Size"
col estd_lc_memory_objects format 99999999 head "Estimate of objects in LC"

select 
shared_pool_size_for_estimate, 
shared_pool_size_factor,
estd_lc_memory_object_hits,
estd_lc_size, estd_lc_memory_objects
from v$shared_pool_advice
order by shared_pool_size_factor
/
