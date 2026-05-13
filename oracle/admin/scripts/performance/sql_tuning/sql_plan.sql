-- ------------------------------------------------------------------------------
-- File       : sql_plan.sql
-- Purpose    : Oracle SQL performance and tuning helper: sql plan.
-- Category   : performance/sql_tuning
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sql_plan.sql
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
--sql_plan sqlid
SET LINES 1000
SET PAGES 1000
COLUMN I FORMAT A3


  SELECT /*+ NO_MERGE */ 
         ROWNUM-1||
   DECODE(access_predicates,NULL,DECODE(filter_predicates,NULL,'','*'),'*') "I",
         SUBSTR(LPAD(' ',(DEPTH-1))||
   OPERATION,1,40)||
   DECODE(OPTIONS,NULL,'',' (' 
   || OPTIONS 
   || ')') "Operation",
         SUBSTR(OBJECT_NAME,1,30) "Object Name",
         cardinality "# Rows",
         bytes,
         cost,
         time
    FROM (
         SELECT * 
           FROM gv$sql_plan 
          WHERE sql_id = '&1'
         ) plan
ORDER BY id
/