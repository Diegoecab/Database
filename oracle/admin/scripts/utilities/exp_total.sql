-- ------------------------------------------------------------------------------
-- File       : exp_total.sql
-- Purpose    : Oracle administration helper: exp total.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @exp_total.sql
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
col jobsize for 9999999999999
col book_date for a12
col elap for 99999
-- TOTAL TIME PER SCHEMA
select q.job_id,
       q.servername,
       q.db_sid,
       q.schema_name,
       q.started,
       q.finished,
       round((NVL(q.finished,SYSDATE)-nvl(q.started,sysdate))*1440) elap,
       q.book_date||'('||q.run||')' BOOK_DATE,q.bkp_mode,
       s.jobsize/1024/1024 jobsize_mb,
       (select round(sum(zipsize)/1024/1024) from exp_log_file where job_id= q.job_id) realsize_mb
  from exp_queue q, exp_schema s
 where q.schema_name='&schema_name'
   and q.servername=s.servername
   and q.db_sid=s.db_sid
   and q.schema_name=s.schema_name
  AND TRUNC(SUBMITTED)> TRUNC(SYSDATE)-15
order by 1
/