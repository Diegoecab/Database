-- ------------------------------------------------------------------------------
-- File       : exp_avg.sql
-- Purpose    : Oracle administration helper: exp avg.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exp_avg.sql
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
COL avg_time HEAD "Min | avg_time"
select q.servername,
       q.db_sid,
       q.schema_name,
       round(avg((q.finished-q.started)*1440)) avg_time
  from exp_queue q
 where status ='DONE'
   and q.schema_name like '&schema_name'
   and q.finished >= sysdate-6
group by q.servername, q.db_sid, q.schema_name
order by 4;