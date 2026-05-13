-- ------------------------------------------------------------------------------
-- File       : tbs.sql
-- Purpose    : Oracle storage, ASM, ACFS or tablespace helper: tbs (2).
-- Category   : storage
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @tbs (2).sql
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
select  df_sp.tablespace_name, df_sp.megas total_df, free_sp.megas libres
from   
(
SELECT tablespace_name, sum(bytes)/1024/1024 megas
FROM   dba_free_space
group by tablespace_name ) free_sp,
(
select tablespace_name, sum(bytes)/1024/1024 megas
from   dba_data_files
group by tablespace_name) df_sp
where  free_sp.tablespace_name = df_sp.tablespace_name
/