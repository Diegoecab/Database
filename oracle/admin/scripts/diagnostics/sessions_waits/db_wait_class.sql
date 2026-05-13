-- ------------------------------------------------------------------------------
-- File       : db_wait_class.sql
-- Purpose    : Oracle diagnostic query/report helper: db wait class.
-- Category   : diagnostics/sessions_waits
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @db_wait_class.sql
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
--db_wait_class
set lines 200
select a.inst_id,WAIT_CLASS,
 TOTAL_WAITS,
 round(100 * (TOTAL_WAITS / SUM_WAITS),2) PCT_WAITS,
 ROUND((TIME_WAITED / 100),2) TIME_WAITED_SECS,
 round(100 * (TIME_WAITED / SUM_TIME),2) PCT_TIME
 from
 (select inst_id, WAIT_CLASS,
 TOTAL_WAITS,
 TIME_WAITED
 from gV$SYSTEM_WAIT_CLASS
 where WAIT_CLASS != 'Idle') a,
 (select inst_id,sum(TOTAL_WAITS) SUM_WAITS,
 sum(TIME_WAITED) SUM_TIME
 from gV$SYSTEM_WAIT_CLASS
 where WAIT_CLASS != 'Idle' group by inst_id) b
 order by 1,3 desc,5 desc;