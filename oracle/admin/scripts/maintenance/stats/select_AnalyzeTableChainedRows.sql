-- ------------------------------------------------------------------------------
-- File       : select_AnalyzeTableChainedRows.sql
-- Purpose    : Oracle database maintenance helper: select AnalyzeTableChainedRows.
-- Category   : maintenance/stats
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @select_AnalyzeTableChainedRows.sql
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
SELECT 'PROMPT ANALYZANDO TABLA '||TABLE_NAME||' DE '||ROUND(BYTES/1024/1024,1)||'MB ... 
ANALYZE TABLE '||table_name||' LIST CHAINED ROWS INTO CHAINED_ROWS;'
  FROM user_tables join user_segments ON segment_name=table_name order by bytes desc;