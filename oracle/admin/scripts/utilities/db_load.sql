-- ------------------------------------------------------------------------------
-- File       : db_load.sql
-- Purpose    : Oracle administration helper: db load.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @db_load.sql
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
--db_load sysdate+(1/1440*-5) sysdate
--AAS = (DB Time / Elapsed Time) AAS is a time-normalized DB Time
--Load on database = AAS = DB Time/elapsed ~ = count(*)/elapsed
--V$ACTIVE_SESSION_HISTORY => COUNT(*) = DB Time in seconds
SELECT
    * 
FROM (
    SELECT
        COUNT(*)                                                     totalseconds
      , ROUND(COUNT(*) / ((CAST(&2 AS DATE) - CAST(&1 AS DATE)) * 86400), 1) AAS --DB Load on last N Minutes
	  , inst_id
    FROM
         gv$active_session_history a
    where sample_time BETWEEN &1 AND &2
	group by inst_id
)
/